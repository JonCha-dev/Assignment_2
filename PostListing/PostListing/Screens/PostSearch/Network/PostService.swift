//
//  PostService.swift
//  PostListing
//
//  Created by Jon Chang on 6/19/23.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidUrl
    case invalidResponse
    case emptyData
    case serviceUnavailable
    case decodingError
    
    var description: String {
        switch self {
        case .invalidUrl:
            return "invalid url"
        case .invalidResponse:
            return "invalid response"
        case .emptyData:
            return "empty data"
        case .serviceUnavailable:
            return "service unavailable"
        case .decodingError:
            return "decoding error"
        }
    }
}


class PostService {
    struct Constants {
        static let baseURL = "https://jsonplaceholder.typicode.com/posts"
    }
    
    func fetchPosts() async throws -> [PostResponse] {
        guard let url = URL(string: Constants.baseURL) else { throw APIError.invalidUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        return try JSONDecoder().decode([PostResponse].self, from: data)
    }
    
    func addPost(_ postData: PostData) async throws -> PostResponse {
        guard let url = URL(string: Constants.baseURL) else {
            throw APIError.invalidUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(postData)
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let resp = (response as? HTTPURLResponse), resp.statusCode == 201 else {
            throw APIError.serviceUnavailable
        }
        
        /*
        if let responseString = String(data: data, encoding: .utf8) {
            print("Response: \(responseString)")
        }
        */
        
        return try JSONDecoder().decode(PostResponse.self, from: data)
    }
    
    /*
    var cancellable = Set<AnyCancellable>()
    
    let urlString = "https://jsonplaceholder.typicode.com/posts"
    func fetchPosts() -> Future<[PostResponse], Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            guard let url = URL(string: self.urlString) else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data } // Data
                .decode(type: [PostResponse].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in // subscribing to events coming from publisher
                    switch completion {
                    case .finished:
                        break
                    case .failure(let err):
                        promise(.failure(err))
                    }
                } receiveValue: { response in
                    promise(.success(response))
                }
                .store(in: &self.cancellable)
        }
    }
    */
    
}
