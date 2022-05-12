//
//  NewMessagePopupView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-08-08.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct NewMessagePopupView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var chatroomManager = ChatroomManager()
    @ObservedObject var messagesManager = MessagesManager()
    
    var userData: UserModel
    
    @State var message = ""
    
    var body: some View {
        
        VStack {
            
            // MARK:- Header
            
            HStack {
                
                // MARK: "Send message to:"
                
                
                Text("Send message to:")
                    .padding(.horizontal, 30)
                    .font(.system(size: 24, weight: .bold))
                
                Spacer()
                
                // MARK: Close button
                
                Button(action: {
                    // Dismiss view
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(UIColor.label))
                        .padding()
                        .padding(.trailing, 10)
                })
                
            }
            
            // MARK: - Profile display
            
            HStack {
                
                if userData.setProfileImage {
                    
                    WebImage(url: URL(string: userData.profileImageURL))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    
                    
                } else {
                    
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(Color(UIColor.label))
                        .frame(width: 50, height: 50)
                    
                                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        // MARK: Username
                        
                        Text(userData.username)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(UIColor.systemBackground))
                        
                        HStack(alignment: .bottom, spacing: 5) {
                            
                            // MARK: Full name
                            
                            if userData.accountType == "creator" {
                                
                                Text(userData.firstName)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(UIColor.systemBackground))
                                
                                Text(userData.lastName)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(UIColor.systemBackground))
                                
                        }
                        
                    }
                    
                }
                    .padding()
                
                Spacer()
                
            }
            
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
            .background(
                Color(UIColor.label)
                    .cornerRadius(20)
                    .padding(.horizontal, 10)
            )
            
            Spacer()
            
            // MARK: - New mesage
            
            HStack {
                
                // MARK: Text field
                
                TextField("Say something here...", text: $message)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25.0)
                            .stroke(Color(UIColor.label), lineWidth: 1)
                    )
                
                Spacer()
                
                // MARK: Send button
                
                Button(action: {
                    
                    // Get chatroom id
                    let documentID = chatroomManager.getArrayString(user01UserID: Auth.auth().currentUser!.uid, user02UserID: userData.userID)
                    // Create chatroom
                    chatroomManager.createChatroom(user02UserID: userData.userID, user02FirstName: userData.firstName, user02LastName: userData.lastName, user02Username: userData.username, user02ProfileImagrURL: userData.profileImageURL, user02AccountType: userData.accountType, user02SetProfileImage: userData.setProfileImage, handler: {
                        
                        // Send message
                        messagesManager.sendMessage(contents: message, documentID: documentID)
                        
                    })
                    
                    // Dismiss view
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(UIColor.label))
                        .padding(5)
                })
                
            }
            .padding(.horizontal, 20)
            
        }
        
    }
    
    
}


// MARK: - Preview

struct NewMessagePopupView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessagePopupView(userData: UserModel(userID: "", username: "", firstName: "", lastName: "", dateOfBirth: "", email: "", profileImageURL: "", setProfileImage: true, bio: "", accountType: "", searchableArray: [], contentTagsArray: [], webAddress: ""))
    }
}
