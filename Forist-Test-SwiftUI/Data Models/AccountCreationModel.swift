//
//  AccountCreationModel.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-19.
//

import Foundation

class AccountCreationModel: ObservableObject {
    
    @Published var accountType: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var dateOfBirth: String = ""
    @Published var gender: String = ""
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var imageData: Data = Data()
    @Published var setProfileImage: Bool = false
    @Published var bio = ""
    @Published var webAddress = ""
    
}
