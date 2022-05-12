//
//  AuthManager.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-17.
//

import Foundation
import Firebase

class AuthManager {
    
    static var databaseRoot = Firestore.firestore()
    
    // MARK: - getUserID
    
    static func getUserID(userID: String) -> DocumentReference {
        
        return databaseRoot.collection("users").document(userID)
        
    }
    
    // MARK: - signUp
    
    static func signUp(username: String, email: String, password: String, firstName: String, lastName: String, dateOfBirth: String, bio: String, accountType: String, searchableArray: [String], contentTagsArray: [String], imageData: Data, setProfileImage: Bool, webAddress: String, onSuccess: @escaping (_ user: UserModel) -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) {
            (authData, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userID = authData?.user.uid else { return }
            
            let storageProfileUserID = StorageManager.storageProfileID(userID: userID)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            StorageManager.saveProfileImage(userID: userID, username: username, email: email, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, bio: bio, accountType: accountType, searchableArray: searchableArray, contentTagsArray: contentTagsArray, imageData: imageData, metadata: metadata, setProfileImage: setProfileImage, storageProfileImageRef: storageProfileUserID, webAddress: webAddress, onSuccess: onSuccess, onError: onError)
            
        }
        
    }
    
    // MARK: - validatePassword
    
    static func validatePassword(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    // MARK: - signIn
    
    static func signIn(email: String, password: String, onSuccess: @escaping (_ user: UserModel) -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {
            (authData, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userID = authData?.user.uid else { return }
            
            let firestoreUserID = getUserID(userID: userID)
            
            firestoreUserID.getDocument {
                (document, error) in
                
                if let dict = document?.data() {
                    guard let decodedUser = try? UserModel.init(fromDictionary: dict) else { return }
                    
                    onSuccess(decodedUser)
                }
            }
        }
    }
    
    // MARK: - signOut
    
    static func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
        }
    }
    
    
}


