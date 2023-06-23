//
//  PostView.swift
//  UserListing
//
//  Created by Jon Chang on 6/23/23.
//

import SwiftUI

struct PostView: View {
    let user: UserResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.title)
                .bold()
                .padding([.top, .bottom],20)
                .font(.system(size:20))
            Text(user.body)
        }
        Spacer()
    }
}

/*
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
*/
