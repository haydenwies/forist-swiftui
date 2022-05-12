//
//  FilteredSearchManager.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-08-10.
//

import Foundation
import Firebase

class FilteredSearchManager: ObservableObject {
    
    @Published var users = [UserModel]()
    @Published var isLoading = false
    var database = Firestore.firestore()
    
    // MARK: - fetchUsers
    
    func fetchUsers(onSuccess: @escaping(_ users: [DocumentSnapshot]) -> Void ) {
     
        database.collection("users").getDocuments {
            (snapshot, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                let users = snapshot!.documents
                onSuccess(users)
                
            }
            
        }
        
    }
    
    // MARK: - filterUsers
    
    func filterUsers(isCreatorSelected: Bool, isBusinessSelected: Bool, isNonProfitSelected: Bool, tagsCollection: [String : Bool]) {
        
        fetchUsers(onSuccess: {
            (snapshot) in
            self.users = snapshot.map {
                (userSnapshot) -> UserModel in
                                
                let data = userSnapshot.data()
                var user = UserModel(userID: "", username: "", firstName: "", lastName: "", dateOfBirth: "", email: "", profileImageURL: "", setProfileImage: false, bio: "", accountType: "", searchableArray: [], contentTagsArray: [], webAddress: "")
                
                if data!["accountType"] as! String == "creator" && isCreatorSelected {
                    user = self.returnUser(data: data!, tagsCollection: tagsCollection)
                }
                
                if data!["accountType"] as! String == "business" && isBusinessSelected {
                    user = self.returnUser(data: data!, tagsCollection: tagsCollection)
                }
                
                if data!["accountType"] as! String == "nonProfit" {
                    if isNonProfitSelected {
                        user = self.returnUser(data: data!, tagsCollection: tagsCollection)
                    }
                }
                                
                return user
                
            }

        })
        
    }
    
    // MARK: - returnUsers
    
    func returnUser(data: [String : Any], tagsCollection: [String : Bool]) -> UserModel {
        
        // Conditions variables
        var containsContentCategory = false
        
        // User reference variables
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
        
        // Filter for contentTagsArray

        // Format contentTagsArray
        let filteredDictionary = tagsCollection.filter { $0.value == true }
        let tagsList = Array(filteredDictionary.keys.map{ $0 })
        // If contentTagsArray contains one element from tagsCollection dictionary, set containsContentCategory to true
        for category in tagsList {
            if contentTagsArray.contains(category) {
                containsContentCategory = true
            }
        }
        
        // Must meet filter conditions to return user else return "empty" user
        if containsContentCategory {
            self.isLoading = false
            
            return UserModel(userID: userID, username: username, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, email: email, profileImageURL: profileImageURL, setProfileImage: setProfileImage, bio: bio, accountType: accountType, searchableArray: searchableArray, contentTagsArray: contentTagsArray, webAddress: webAddress)
            
        } else {

            self.isLoading = true

            return UserModel(userID: "", username: "", firstName: "", lastName: "", dateOfBirth: "", email: "", profileImageURL: "", setProfileImage: false, bio: "", accountType: "", searchableArray: [], contentTagsArray: [], webAddress: "")

        }
        
    }
    
    
}
