//
//  UserResponse.swift
//  UserListing
//
//  Created by Jon Chang on 6/19/23.
//

import Foundation

struct UserResponse: Decodable, Identifiable {
    let userId:Int
    let id:Int
    let title:String
    let body:String
}
