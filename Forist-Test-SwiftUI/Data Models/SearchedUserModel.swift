//
//  SearchedUserModel.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-23.
//

import Foundation

class SelectedUserData: ObservableObject {
    
    @Published var username = ""
    @Published var userID = ""
    @Published var email = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var bio = ""
    @Published var searchableTags = [""]
    @Published var accountType = ""
    @Published var profileImageURL = ""
     
}
