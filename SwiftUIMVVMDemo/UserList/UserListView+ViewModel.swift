//
//  UserListViewModel.swift
//  SwiftUIMVVMDemo
//
//  Created by Bibin Joseph on 22/05/21.
//

import Foundation
import Combine

extension UserListView {
    class ViewModel: ObservableObject {
        @Published private(set) var activityInProgress: Bool = false
        @Published private(set) var users: [User] = []
        
        private var id: String
        private var networkStore: UserNetworkStore
        private var paginator = Paginator()
        
        private var cancellable: AnyCancellable?
        
        init(id: String, networkStore: UserNetworkStore) {
            self.id = id
            self.networkStore = networkStore
        }
        
    }
}

extension UserListView.ViewModel {
    func getUsers() {
        guard let nextPage = paginator.nextPage else {
            return
        }
        
        activityInProgress = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           
            self.cancellable = self.networkStore.getUsers(pageNumber: nextPage)
//                .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
                .sink { completion in
                    self.activityInProgress = false
                    switch completion {
                    case .finished: debugPrint("Users list Fetch Completed")
                    case .failure(let error): debugPrint("User list fetch FAILED. Reason: \(error.localizedDescription)")
                    }
                } receiveValue: { model in
                    self.paginator.currentPage = model.page
                    self.paginator.totalPages = model.totalPages
                    self.users += model.users
                }
        }
        
    }
}
