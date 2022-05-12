//
//  UserModel.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-17.
//

import Foundation

struct UserModel: Encodable, Decodable {
    
    var userID: String
    var username: String
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var email: String
    var profileImageURL: String
    var setProfileImage: Bool
    var bio: String
    var accountType: String
    var searchableArray: [String]
    var contentTagsArray: [String]
    var webAddress: String
    
}
