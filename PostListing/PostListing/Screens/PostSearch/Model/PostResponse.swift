//
//  PostResponse.swift
//  PostListing
//
//  Created by Jon Chang on 6/19/23.
//

import Foundation

struct PostResponse: Decodable, Identifiable {
    let userId:Int
    let id:Int
    let title:String
    let body:String
}

struct PostGroup: Identifiable {
    let id = UUID()
    let userId: Int
    let posts:[PostResponse]
}

struct PostData: Codable {
    let userId: Int
    let body: String
    let title: String
}
