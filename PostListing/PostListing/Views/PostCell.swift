//
//  PostCell.swift
//  PostListing
//
//  Created by Jon Chang on 6/19/23.
//

import SwiftUI

struct PostCell: View {
    let post: PostResponse
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text("\(post.title)")
                .foregroundColor(.black)
        }
        .padding()
        .frame(width:350, height:50, alignment: .leading)
        .background(Color(red:0.267, green:0.784, blue:0.89))
        .cornerRadius(20)
    }
}

/*
struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell()
    }
}
*/
