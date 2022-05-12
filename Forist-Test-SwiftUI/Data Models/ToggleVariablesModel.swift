//
//  ToggleVariables.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import Foundation

class ToggleVariablesModel: ObservableObject {
    
    @Published var sideMenuButtonState = false
    @Published var showContentTagSelection = false
    @Published var showSearchProfile = false
    @Published var hideTabBar = false
    @Published var showLoginScreen = false
    @Published var showSettings = false
    
    func hideTabBarFunc() {
        
        hideTabBar = true
        
    }
    
}
