//
//  MessagesManager.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-08-08.
//

import Foundation
import Firebase

// MARK: - MessagesModel

struct MessagesModel: Codable, Identifiable {
    
    var id: String
    var content: String
    var sender: String
    var sendTime: Date
    
}

// MARK: - MessagesManager

class MessagesManager: ObservableObject {
    
    @Published var messages = [MessagesModel]()
    let database = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    // MARK: sendMessage
    
    func sendMessage(contents: String, documentID: String) {
        
        if user != nil {
                        
            database.collection("chatrooms").document(documentID).collection("messages").addDocument(data: [
                "sendTime" : Date(),
                "sender" : user!.uid,
                "message" : contents
            ])
            
        }
        
    }
    
    // MARK: fetchData
    
    func fetchData(documentID: String) {
        
        if user != nil {
            
            database.collection("chatrooms").document(documentID).collection("messages").order(by: "sendTime", descending: false).addSnapshotListener {
                (snapshot, error) in
                
                
                guard let documents = snapshot?.documents else {
                    print(error!.localizedDescription)
                    return
                }
                
                self.messages = documents.map({
                    (docSnapshot) -> MessagesModel in
                    
                    let data = docSnapshot.data()
                    let documentID = docSnapshot.documentID
                    let content = data["message"] as? String ?? ""
                    let sender = data["sender"] as? String ?? ""
                    let sendTime = data["sendTime"] as? Date ?? Date()
                    return MessagesModel(id: documentID, content: content, sender: sender, sendTime: sendTime)
                })
                
            }
            
        }
        
    }
    
    
}
