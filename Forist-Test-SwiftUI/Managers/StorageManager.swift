//
//  StorageManager.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-17.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

class StorageManager {
    
    static var storage = Storage.storage()
    static var storageRoot = storage.reference(forURL: "gs://forist-test-swiftui-cf275.appspot.com")
    static var storageProfileImage = storageRoot.child("/profileImage")
 
    // MARK: - storageProfileID
    
    static func storageProfileID(userID: String) -> StorageReference {
        return storageProfileImage.child(userID)
    }
    
    // MARK: - saveProfileImage
    
    static func saveProfileImage(userID: String, username: String, email: String, firstName: String, lastName: String, dateOfBirth: String, bio: String, accountType: String, searchableArray: [String], contentTagsArray: [String], imageData: Data, metadata: StorageMetadata, setProfileImage: Bool, storageProfileImageRef: StorageReference, webAddress: String, onSuccess: @escaping(_ user: UserModel) -> Void, onError: @escaping(_ error: String) -> Void) {
        
        storageProfileImageRef.putData(imageData, metadata: metadata) {
            (StorageMetadata, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storageProfileImageRef.downloadURL {
                (url, error) in
                if let metaImageURL = url?.absoluteString {
                    
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges {
                            (error) in
                            
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                            
                        }
                        
                    }
                    
                    let firestoreUserID = AuthManager.getUserID(userID: userID)
                    let user = UserModel.init(userID: userID, username: username, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, email: email, profileImageURL: metaImageURL, setProfileImage: setProfileImage, bio: bio, accountType: accountType, searchableArray: searchableArray, contentTagsArray: contentTagsArray, webAddress: webAddress)
                    guard let dict = try? user.asDictionary() else { return }
                    firestoreUserID.setData(dict) {
                        (error) in
                        
                        if error != nil {
                            onError(error!.localizedDescription)
                        }
                        
                    }
                    
                    onSuccess(user)
                    
                }
            }
            
        }
        
    }
    
    // MARK: - updateDocument
    
    static func updateDocument(field: String, newData: Any) {
        let documentRef = Firestore.firestore().collection("users").document("\(Auth.auth().currentUser!.uid)")

        // Update data
        documentRef.updateData([
            "\(field)": newData
        ]) { (error) in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }

    }
    
    
}
