//
//  PostView.swift
//  PostListing
//
//  Created by Jon Chang on 6/23/23.
//

import SwiftUI

struct PostView: View {
    let post: PostResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
                .bold()
                .padding([.top, .bottom],20)
                .font(.system(size:20))
            Text(post.body)
            Spacer()
        }
    }
}

/*
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
*/
