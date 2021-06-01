//
//  UserView.swift
//  SwiftUIMVVMDemo
//
//  Created by Bibin Joseph on 22/05/21.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel = .init(id: "5", networkStore: UserNetwork())) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Group {
                List(viewModel.users) { user in
                    withAnimation {
                        NavigationLink(destination: UserRow(user: user, layout: .detailed)) {
                            UserRow(user: user)
                        }
                        .onAppear {
                            if viewModel.users.last == user {
                                viewModel.getUsers()
                            }
                        }
                    }
                }
            }
            if viewModel.activityInProgress {
                ProgressView()
            }
        }
        .navigationTitle("Users")
        .onAppear {
            viewModel.getUsers()
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
            .preferredColorScheme(.dark)
    }
}
