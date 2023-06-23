//
//  UserCell.swift
//  UserListing
//
//  Created by Jon Chang on 6/19/23.
//

import SwiftUI

struct UserCell: View {
    let user: UserResponse
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(user.id).")
            Text("\"\(user.title)\" (by User \(user.userId))")
        }
    }
}

/*
struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
*/
