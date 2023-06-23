//
//  UserService.swift
//  UserListing
//
//  Created by Jon Chang on 6/19/23.
//

import Foundation
import Combine

class UserService {
    
    var cancellable = Set<AnyCancellable>()
    
    let urlString = "https://jsonplaceholder.typicode.com/posts"
    func fetchUsers() -> Future<[UserResponse], Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            guard let url = URL(string: self.urlString) else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data } // Data
                .decode(type: [UserResponse].self, decoder: JSONDecoder())
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
    
}
