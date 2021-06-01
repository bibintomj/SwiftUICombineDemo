//
//  LoginView.swift
//  SwiftUIMVVMDemo
//
//  Created by Bibin Joseph on 01/06/21.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = "eve.holt@reqres.in"
    @State var password: String = "cityslicka"
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    
    var body: some View {
        NavigationView {
            ZStack {
                Image("BG1")
                    .resizable(capInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .ignoresSafeArea()
                
                Section {
                    Group {
                        VStack(alignment: .center, spacing: 20) {
                            HStack(spacing: 15) {
                                Text("Login")
                                    .font(.largeTitle)
                                    .fontWeight(.black)
                                    .multilineTextAlignment(.leading)
                                
                                Image("apple")
                                    .renderingMode(.template)
                                    .foregroundColor(Color("AccentColor"))
                            }
                            
                            TextField("example@mail.com", text: $email)
                                .padding(10)
                                .font(Font.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(Color.primary)
                                .background(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(Color.init(.systemGroupedBackground))
                            
                            SecureField("Password", text: $password)
                                .padding(10)
                                .font(Font.system(size: 15, weight: .medium, design: .default))
                                .foregroundColor(Color.primary)
                                .background(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(Color.init(.systemGroupedBackground))
                            
                            //                Button("Login") {}
                            //                    .scaledToFill()
                            
                            Button(action: {
                                viewModel.login(email: email, password: password)
                                
                            }) {
                                Text("LOGIN")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .font(.title3)
                                    .padding()
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke(Color("AccentColor"), lineWidth: 1)
                                    ).background(RoundedRectangle(cornerRadius: 40).fill(Color("AccentColor")))
                            }
                        }
                        .padding(EdgeInsets(top: 40, leading: 15, bottom: 40, trailing: 15))
                    }
                    .background(Color.init(.secondarySystemGroupedBackground))
                    .cornerRadius(20)
                }
                .padding(15)
                
                NavigationLink(
                    destination: UserListView(),
                    isActive: $viewModel.loginSucces,
                    label: {
                        EmptyView()
                    })
                    .hidden()
                //            .background(Color.init(.systemGroupedBackground))
            }
            
        }
        //        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}
