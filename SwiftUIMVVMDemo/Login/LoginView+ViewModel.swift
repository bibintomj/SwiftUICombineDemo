//
//  LoginView+ViewModel.swift
//  SwiftUIMVVMDemo
//
//  Created by Bibin Joseph on 01/06/21.
//

import Foundation
import Combine

extension LoginView {
    class ViewModel: ObservableObject {
        @Published var loginSucces: Bool = false
        private var networkStore = UserNetwork()
        private var cancellable: AnyCancellable?
        
        init(networkStore: UserNetwork = .init()) {
            self.networkStore = networkStore
        }
        
    }
}

extension LoginView.ViewModel {
    func login(email: String, password: String) {
        self.cancellable = networkStore.login(email: email, password: password)
            .sink(receiveCompletion: { completion in
                self.loginSucces = true
                switch completion {
                case .finished: debugPrint("Login Success")
                case .failure(let error): debugPrint("Login Failed \(error.localizedDescription)")
                }
            }, receiveValue: { session in
                debugPrint(session.token)
               
            })
    }
}
