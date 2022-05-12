//
//  View Router.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import Foundation


enum Page {
    
    case profile
    case login
    case messages
    case notifications
    case search
    case load 
    
}


class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .login
    
}
