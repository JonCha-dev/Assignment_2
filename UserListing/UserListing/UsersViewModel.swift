//
//  UsersViewModel.swift
//  UserListing
//
//  Created by Jon Chang on 6/19/23.
//

import Foundation
import Combine

class UsersViewModel: ObservableObject {
    
    @Published var users = [UserResponse]()
    
    var cancellable = Set<AnyCancellable>()
    let service = UserService()
    
    func getUsers() {
        service.fetchUsers()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                }
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellable)
    }
}
