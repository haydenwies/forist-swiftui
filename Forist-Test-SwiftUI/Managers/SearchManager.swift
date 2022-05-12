//
//  SearchManager.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class SearchManager: ObservableObject {
    
    @Published var userModel = [UserModel]()
    @Published var isLoading = false
    
    func directSearchUser(input: String) {
        
        Firestore.firestore().collection("users")
            // Make sure searchKey contains typed letters
            .whereField("searchableArray", arrayContains: input.lowercased().trimSpaces()).getDocuments { [self]
                (querySnapshot, error) in
                guard let snap = querySnapshot else {
                    print(error?.localizedDescription ?? "Error fetching users")
                    return
                }
                let documents = snap.documents
                self.userModel = documents.map { (queryDocumentSnapshot) -> UserModel in
                    let data = queryDocumentSnapshot.data()
                    
                    if data["userID"] as! String != Auth.auth().currentUser!.uid {
                               
                        
                        let userID = data["userID"] as! String
                        let email = data["email"] as! String
                        let username = data["username"] as! String
                        let firstName = data["firstName"] as! String
                        let lastName = data["lastName"] as! String
                        let bio = data["bio"] as! String
                        let contentTagsArray = data["contentTagsArray"] as! [String]
                        let accountType = data["accountType"] as! String
                        let profileImageURL = data["profileImageURL"] as! String
                        let dateOfBirth = data["dateOfBirth"] as! String
                        let setProfileImage = data["setProfileImage"] as! Bool
                        let searchableArray = data["searchableArray"] as! [String]
                        let webAddress = data["webAddress"] as! String
                        
                        print(webAddress)
                        
                        self.isLoading = false
                        
                        return UserModel(userID: userID, username: username, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, email: email, profileImageURL: profileImageURL, setProfileImage: setProfileImage, bio: bio, accountType: accountType, searchableArray: searchableArray, contentTagsArray: contentTagsArray, webAddress: webAddress)
                 
                    } else {
                        
                        self.isLoading = false
                        
                        return UserModel(userID: "", username: "", firstName: "", lastName: "", dateOfBirth: "", email: "", profileImageURL: "", setProfileImage: false, bio: "", accountType: "", searchableArray: [], contentTagsArray: [], webAddress: "")
                        
                    }
                }
                
            }
        
    }
    
    
}

