//
//  Paginator.swift
//  SwiftUIMVVMDemo
//
//  Created by Bibin Joseph on 01/06/21.
//

import Foundation

struct Paginator {
    var currentPage: Int = 0
    var totalPages: Int = 1
    var nextPage: Int? { currentPage + 1 <= totalPages ? currentPage + 1 : nil }
}
