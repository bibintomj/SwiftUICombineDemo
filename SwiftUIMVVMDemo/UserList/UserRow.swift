//
//  UserRow.swift
//  SwiftUIMVVMDemo
//
//  Created by Bibin Joseph on 01/06/21.
//

import SwiftUI

struct UserRow: View {
    @State var user: User
    @StateObject var imageLoader: ImageLoader
    
    @State var layout: LayoutConfiguration
 
    init(user: User, layout: LayoutConfiguration = .minimal) {
        self.user = user
        self.layout = layout
        _imageLoader = StateObject(wrappedValue: .init(url: URL(string: user.avatar)))
    }
    
    var body: some View {
        if layout == .minimal {
            HStack(spacing: 15) {
                Image(uiImage: imageLoader.image)
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .clipped()
                    .cornerRadius(20)
                Text("\(user.firstName) \(user.lastName)")
            }
        } else {
            VStack(spacing: 15) {
                Image(uiImage: imageLoader.image)
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipped()
                    .cornerRadius(50)
                Text("\(user.firstName) \(user.lastName)")
                    .fontWeight(.bold)
                Text(user.email)
                    .fontWeight(.semibold)
            }
        }
        
    }
}

extension UserRow {
    enum LayoutConfiguration {
        case minimal, detailed
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRow(user: .init(id: 0,
                            email: "John@mail.com",
                            firstName: "John",
                            lastName: "K K",
                            avatar: "https://reqres.in/img/faces/2-image.jpg"),
                layout: .detailed)
    }
}
