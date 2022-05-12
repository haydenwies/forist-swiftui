//
//  AccountSettingsManager.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-27.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

class AccountSettingsManager {
    
    // MARK: - Update profile
    
    static func updateProfile(username: String, firstName: String, lastName: String, email: String, newPassword: String, imageData: Data, profileImageWasChanged: Bool, bio: String) {
        
        let userID = Auth.auth().currentUser!.uid
        
        let storageProfileUserID = StorageManager.storageProfileID(userID: userID)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        saveProfileData(username: username, firstName: firstName, lastName: lastName, email: email, newPassword: newPassword, imageData: imageData, metadata: metadata, profileImageWasChanged: profileImageWasChanged, bio: bio, storageProfileImageRef: storageProfileUserID)
        
    }
   
    // MARK: - Save profile data
    
    static func saveProfileData(username: String, firstName: String, lastName: String, email: String, newPassword: String, imageData: Data, metadata: StorageMetadata, profileImageWasChanged: Bool, bio: String, storageProfileImageRef: StorageReference) {
        
        // To determine if a variable was changed
        var changesMade = false
        
        // Decode UserModel
        let encodedUserData = UserDefaults.standard.data(forKey: "user")!
        do {
            let decoder = JSONDecoder()
            var userData = try decoder.decode(UserModel.self, from: encodedUserData)
            
            // Username
            if !username.isEmpty {
                // Change in userData
                userData.username = username
                // Save to UserDefaults
                UserDefaults.standard.set(username, forKey: "username")
                changesMade = true
            }
            
            // First name
            if !firstName.isEmpty {
                // Change in userData
                userData.firstName = firstName
                // Save to UserDefaults
                UserDefaults.standard.set(firstName, forKey: "firstName")
                changesMade = true
            }
            
            // Last name
            if !lastName.isEmpty {
                // Change in userData
                userData.lastName = lastName
                // Save to UserDefaults
                UserDefaults.standard.set(lastName, forKey: "lastName")
                changesMade = true
            }
            
            // Email
            if !email.isEmpty {
                // Change email in authentication
                Auth.auth().currentUser!.updateEmail(to: email) {
                    (error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    } else {
                        // Change in userData
                        userData.email = email
                        // Save to UserDefauls
                        UserDefaults.standard.set(email, forKey: "email")
                        changesMade = true
                    }
                }
            }

            // Bio
            if !bio.isEmpty {
                // Change in userData
                userData.bio = bio
                // Save to UserDefaults
                UserDefaults.standard.set(bio, forKey: "bio")
                changesMade = true
            }
            
            // Password
            if !newPassword.isEmpty {
                Auth.auth().currentUser!.updatePassword(to: newPassword) {
                    (error) in
                    
                    if error != nil {
                        print(error!.localizedDescription)
                    }
                }
            }
            
            // Searchable array
            if userData.accountType == "creator" {
                // For creator accounts
                userData.searchableArray = userData.username.splitString() + userData.firstName.splitString() + userData.lastName.splitString()
            } else {
                // For business or non profit accounts
                userData.searchableArray = userData.username.splitString()
            }
            
            // Profile image
            if profileImageWasChanged {
                // Profile image wasn changed
                storageProfileImageRef.putData(imageData, metadata: metadata) {
                    (StorageMetadata, error) in
                    
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    // Get reference URL to new image
                    storageProfileImageRef.downloadURL {
                        (url, error) in
                        
                        // Save to UserDefaults and userData
                        if let metaImageURL = url?.absoluteString {
                            userData.profileImageURL = metaImageURL
                            UserDefaults.standard.set(metaImageURL, forKey: "profileImageURL")
                            
                            // Change user info
                            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                                
                                changeRequest.photoURL = url
                                changeRequest.displayName = username
                                changeRequest.commitChanges {
                                    (error) in
                                    
                                    if error != nil {
                                        print(error!.localizedDescription)
                                        return
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                        // Save data to Firestore
                        let firestoreUserID = AuthManager.getUserID(userID: userData.userID)
                        guard let dict = try? userData.asDictionary() else { return }
                        firestoreUserID.setData(dict) {
                            (error) in
                            
                            if error != nil {
                                print(error!.localizedDescription)
                            }
                            
                        }
                        
                    }
                    
                }
                
            } else {
                // Profile image wasn't changed
                if changesMade {
                    // Other changes were made
                    let firestoreUserID = AuthManager.getUserID(userID: userData.userID)
                    guard let dict = try? userData.asDictionary() else { return }
                    firestoreUserID.setData(dict) {
                        (error) in
                        
                        if error != nil {
                            print(error!.localizedDescription)
                        }
                        
                    }
                    
                }
                
            }
            
        } catch {
            
            print("Cannot decode user")
            
        }
        
    }
    
    
}
