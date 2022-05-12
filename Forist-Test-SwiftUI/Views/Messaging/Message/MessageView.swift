//
//  MessageView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-08-08.
//

import SwiftUI
import Firebase

struct MessageView: View {
    
    
    var chatroomModel: ChatroomModel
    
    @ObservedObject var messagesManager = MessagesManager()
    
    var user = Auth.auth().currentUser!.uid
    @State var messageField = ""
    
    init(chatroomModel: ChatroomModel) {
        self.chatroomModel = chatroomModel
        messagesManager.fetchData(documentID: chatroomModel.id)
    }
    
    var body: some View {
        
        VStack {
            
                // MARK: Header
                
                if chatroomModel.user01UserID != user {
                    Text(chatroomModel.user01Username)
                        .font(.system(size: 22, weight: .semibold))
                } else {
                    Text(chatroomModel.user02Username)
                        .font(.system(size: 22, weight: .semibold))
                }
                
            Spacer()
            
            // MARK: Message list
            
            ScrollViewReader { value in
                
                ScrollView {
                    
                    ForEach(messagesManager.messages) {
                        (message) in
                        
                        // MARK: Message not from current user
                        
                        if message.sender != user {
                            HStack {
                                Text(message.content)
                                    .foregroundColor(Color(UIColor.label))
                                    .padding(.horizontal)
                                    .padding(.vertical, 9)
                                    .background(
                                        Color(UIColor.systemGray3)
                                            .cornerRadius(20)
                                    )
                                Spacer()
                            }
                            .id(message.sendTime)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 1)
                            
                        } else {
                            
                            // MARK: Message from current user
                            
                            HStack {
                                Spacer()
                                Text(message.content)
                                    .foregroundColor(Color(UIColor.white))
                                    .padding(.horizontal)
                                    .padding(.vertical, 9)
                                    .background(
                                        Color(UIColor.purple)
                                            .cornerRadius(20)
                                    )
                            }
                            .id(message.sendTime)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 1)
                            
                        }
                        
                    }
                    
                    // MARK: Jump to bottom of scroll view
                    
                    .onAppear(perform: {
                        value.scrollTo(messagesManager.messages.last?.sendTime)
                    })
                    .onChange(of: messagesManager.messages.count, perform: { _ in
                        withAnimation {
                            value.scrollTo(messagesManager.messages.last?.sendTime)
                        }
                    })
                    
                }
                
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            
            // MARK: - Send message field
            
            HStack {
                
                // MARK: Text field
                
                TextField("Say something here...", text: $messageField)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25.0)
                            .stroke(Color(UIColor.label), lineWidth: 1)
                    )
                
                Spacer()
                
                // MARK: Send button
                
                Button(action: {
                    // Send message
                    messagesManager.sendMessage(contents: messageField, documentID: chatroomModel.id)
                    messageField = ""
                }, label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(UIColor.label))
                        .padding(5)
                })
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            
            
        }
        
    }
    
    
}


// MARK: - Preview

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(chatroomModel: ChatroomModel(id: "", user01UserID: "", user01FirstName: "", user01LastName: "", user01Username: "", user01ProfileImageURL: "", user01AccountType: "", user01SetProfileImage: false, user02UserID: "", user02FirstName: "", user02LastName: "", user02Username: "", user02ProfileImageURL: "", user02AccountType: "", user02SetProfileImage: false))
    }
}
