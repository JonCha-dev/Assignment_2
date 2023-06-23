//
//  ContentView.swift
//  UserListing
//
//  Created by Jon Chang on 6/19/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = UsersViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                listView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("All Posts")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
            }
            .onAppear {
                viewModel
                    .getUsers()
            }
        }
    }
    
    private func listView() -> some View {
        List(viewModel.users) { user in
            NavigationLink {
                VStack {
                    PostView(user: user)
                }
            } label: {
                UserCell(user: user)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
