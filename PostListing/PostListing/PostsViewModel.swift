//
//  PostsViewModel.swift
//  PostListing
//
//  Created by Jon Chang on 6/19/23.
//

import Foundation
import Combine

class PostsViewModel: ObservableObject {
    
    @Published var postGroups = [PostGroup]()
    
    var cancellable = Set<AnyCancellable>()
    let service = PostService()

    @MainActor func getPosts() {
        Task {
            do {
                let posts: [PostResponse] = try await service.fetchPosts()
                self.postGroups = processPosts(posts: posts)
            } catch {
                if let error = error as? APIError {
                    print(error.description)
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @MainActor func addPost() {
        Task {
            do {
                let post: PostResponse = try await service.addPost(PostData(userId: 1, body: "Post body test",
                                                                            title: "Post title test"))
                print("post = \(post)")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func processPosts(posts: [PostResponse]) -> [PostGroup] {
        var processedPosts = [PostGroup]()
        //var processedPosts = [PostGroup(userId:1, posts: [PostResponse(userId: 1, id: 3333, title: "abcd", body: "somebody")])]
        
        // sort posts by ascending user order
        let sortedPosts = posts.sorted(by: {$0.userId < $1.userId})
        
        var i = 0
        var currId = 0
        var arr = [PostResponse]()
        
        while i < sortedPosts.count {
            var postId = sortedPosts[i].userId
            
            // this post from diff user
            if currId != postId {
                if arr.count > 0 {
                    processedPosts.append(PostGroup(userId:currId, posts: arr))
                }
                
                currId = postId
                arr = []
                
            // this post from same user
            } else {
                arr.append(sortedPosts[i])
            }
            i += 1
        }
        
        return processedPosts
    }
    
    /*
    func getPosts() {
        service.fetchPosts()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                }
            } receiveValue: { [weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellable)
    }
    */
}
