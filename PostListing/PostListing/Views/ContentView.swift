//
//  ContentView.swift
//  PostListing
//
//  Created by Jon Chang on 6/19/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PostsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    Text("All Posts")
                        .font(.system(size:40))
                        .padding([.bottom], 20)
                    ForEach(viewModel.postGroups) { group in
                        VStack(alignment: .leading) {
                            Text("Posts by user \(group.userId)")
                                .bold()
                            listView(group.posts)
                        }
                        .padding([.bottom], 50)
                    }
                }
            }
        }
        .onAppear {
            viewModel.getPosts()
        }
    }
    

    private func listView(_ posts: [PostResponse]) -> some View {
        ForEach(posts) { post in
            NavigationLink {
                ZStack {
                    PostView(post: post)
                }
            } label: {
                PostCell(post: post)
            }
        }
    }
 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
