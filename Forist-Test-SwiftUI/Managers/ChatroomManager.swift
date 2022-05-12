//
//  ChatroomManager.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-08-05.
//

import Foundation
import Firebase

// MARK: - ChatroomModel

struct ChatroomModel: Codable, Identifiable {
    
    var id: String
    var user01UserID: String
    var user01FirstName: String
    var user01LastName: String
    var user01Username: String
    var user01ProfileImageURL: String
    var user01AccountType: String
    var user01SetProfileImage: Bool
    var user02UserID: String
    var user02FirstName: String
    var user02LastName: String
    var user02Username: String
    var user02ProfileImageURL: String
    var user02AccountType: String
    var user02SetProfileImage: Bool
    
}

// MARK: - ChatroomManager

class ChatroomManager: ObservableObject {
    
    @Published var chatrooms = [ChatroomModel]()
    private let database = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    // MARK: - fetchChatrooms
    
    func fetchChatrooms() {
        
        if user != nil {
            
            database.collection("chatrooms").whereField("users", arrayContains: user!.uid).addSnapshotListener({
                (snapshot, error) in
                
                guard let documents = snapshot?.documents else {
                    print("no current chatrooms available")
                    return
                }
                
                self.chatrooms = documents.map({docSnapshot -> ChatroomModel in
                    let data = docSnapshot.data()
                    
                    let docID = docSnapshot.documentID
                    let user01UserID = data["user01UserID"] as? String ?? ""
                    let user01FirstName = data["user01FirstName"] as? String ?? ""
                    let user01LastName = data["user01LastName"] as? String ?? ""
                    let user01Username = data["user01Username"] as? String ?? ""
                    let user01ProflieImageURL = data["user01ProfileImageURL"] as? String ?? ""
                    let user01AccountType = data["user01AccountType"] as? String ?? ""
                    let user01SetProfileImage = data["user01SetProfileImage"] as? Bool ?? false
                    let user02UserID = data["user02UserID"] as? String ?? ""
                    let user02FirstName = data["user02FirstName"] as? String ?? ""
                    let user02LastName = data["user02LastName"] as? String ?? ""
                    let user02Username = data["user02Username"] as? String ?? ""
                    let user02ProflieImageURL = data["user02ProfileImageURL"] as? String ?? ""
                    let user02AccountType = data["user02AccountType"] as? String ?? ""
                    let user02SetProfileImage = data["user02SetProfileImage"] as? Bool ?? false
                    
                    return ChatroomModel(id: docID, user01UserID: user01UserID, user01FirstName: user01FirstName, user01LastName: user01LastName, user01Username: user01Username, user01ProfileImageURL: user01ProflieImageURL, user01AccountType: user01AccountType, user01SetProfileImage: user01SetProfileImage, user02UserID: user02UserID, user02FirstName: user02FirstName, user02LastName: user02LastName, user02Username: user02Username, user02ProfileImageURL: user02ProflieImageURL, user02AccountType: user02AccountType, user02SetProfileImage: user02SetProfileImage)
                })
                
            })
        }
        
    }
    
    
    // MARK: - createChatroom
    
    func createChatroom(user02UserID: String, user02FirstName: String, user02LastName: String, user02Username: String, user02ProfileImagrURL: String, user02AccountType: String, user02SetProfileImage: Bool, handler: @escaping() -> Void) {
        
        if user != nil {
            
            let arrayString = getArrayString(user01UserID: Auth.auth().currentUser!.uid, user02UserID: user02UserID)
            
            database.collection("chatrooms").document(arrayString).setData([
                
                "arrayString" : arrayString,
                "users" : [Auth.auth().currentUser!.uid, user02UserID],
                "user01UserID" : Auth.auth().currentUser!.uid,
                "user01FirstName" : UserDefaults.standard.string(forKey: "firstName")!,
                "user01LastName" : UserDefaults.standard.string(forKey: "lastName")!,
                "user01Username" : UserDefaults.standard.string(forKey: "username")!,
                "user01ProfileImageURL" : UserDefaults.standard.string(forKey: "profileImageURL")!,
                "user01AccountType" : UserDefaults.standard.string(forKey: "accountType")!,
                "user01SetProfileImage" : UserDefaults.standard.bool(forKey: "setProfileImage"),
                "user02UserID" : user02UserID,
                "user02FirstName" : user02FirstName,
                "user02LastName" : user02LastName,
                "user02Username" : user02Username,
                "user02ProfileImageURL" : user02ProfileImagrURL,
                "user02AccountType" : user02AccountType,
                "user02SetProfileImage" : user02SetProfileImage
            ]) {
                (error) in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    handler()
                }
            }
            
        }
        
    }
    
    // MARK: - getArrayString
    
    func getArrayString(user01UserID: String, user02UserID: String) -> String {
        
        let userArray = [user01UserID, user02UserID].sorted()
        let arrayString = (userArray.map{String($0).capitalized}).joined()
        return arrayString
    }
    
    // MARK: - doesChatroomExist
    
    func doesChatroomExist(user01UserID: String, user02UserID: String, handler: @escaping(_ documentExists: Bool) -> Void) {
        
        
        let documentID = getArrayString(user01UserID: user01UserID, user02UserID: user02UserID)
        let documentRef = database.collection("chatrooms").document(documentID)
        documentRef.getDocument {
            (docSnapshot, error) in
            if let document = docSnapshot {
                if document.exists {
                    handler(true)
                } else {
                    handler(false)
                }
                
            }
            
        }
        
    }
    
    
}
