//
//  ImageLoader.swift
//  SwiftUIMVVMDemo
//
//  Created by Bibin Joseph on 01/06/21.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage = #imageLiteral(resourceName: "user")
    
    var url: URL?

    private var cancellable: AnyCancellable?

    init(url: URL? = nil) {
        self.url = url
        load()
    }
}

private extension ImageLoader {
    func load() {
        guard url != nil else {
            return
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: url!)
            .map { UIImage(data: $0.data) }
            .replaceError(with: #imageLiteral(resourceName: "user"))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 ?? #imageLiteral(resourceName: "user") }
    }
}
