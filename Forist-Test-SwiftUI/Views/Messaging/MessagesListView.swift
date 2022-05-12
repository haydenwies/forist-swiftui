//
//  MessagesView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct MessagesListView: View {
    
    // Passed to tab bar
    @ObservedObject var viewRouter: ViewRouter
    
    // Used  for toggling tab bar when clicking on user profile
    @ObservedObject var toggleVariables: ToggleVariablesModel
    
//    @ObservedObject var chatroomManager = ChatroomManager()
    @ObservedObject var chatroomManager: ChatroomManager
    
    init(viewRouter: ViewRouter, toggleVariables: ToggleVariablesModel, chatroomManager: ChatroomManager) {
        self.viewRouter = viewRouter
        self.toggleVariables = toggleVariables
        self.chatroomManager = chatroomManager
//        chatroomManager.fetchChatrooms()
        
        // Cosmetic configuration for navigation bar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor.systemBackground
        navBarAppearance.shadowColor = UIColor.clear
        UINavigationBar.appearance().tintColor = UIColor.label
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
    }
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack {
                    
                    // MARK: Header
                    
                    HStack {
                        
                        Text("Messages")
                            .font(.system(size: 24, weight: .bold))
                            .padding(.horizontal)
                            .padding(.top, 40)
                            .padding(.bottom, 10)
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        
                        ForEach(chatroomManager.chatrooms) { chatroom in
                            
                            VStack {
                                
                                NavigationLink(
                                    destination: MessageView(chatroomModel: chatroom),
                                    label: {
                                        
                                        HStack {
                                            
                                            // MARK: User01 display
                                            
                                            if chatroom.user01UserID != Auth.auth().currentUser!.uid {
                                                                                                
                                                HStack {
                                                    
                                                    if chatroom.user01SetProfileImage {
                                                        WebImage(url: URL(string: chatroom.user01ProfileImageURL))
                                                            .resizable()
                                                            .frame(width: 60, height: 60)
                                                            .clipShape(Circle())
                                                    } else {
                                                        Image(systemName: "person.circle.fill")
                                                            .resizable()
                                                            .foregroundColor(Color(UIColor.label))
                                                            .frame(width: 60, height: 60)
                                                    }
                                                    
                                                    VStack(alignment: .leading) {
                                                        Text(chatroom.user01Username)
                                                            .font(.system(size: 18, weight: .semibold))
                                                            .foregroundColor(Color(UIColor.label))
                                                        if chatroom.user01AccountType == "creator" {
                                                            Text("\(chatroom.user01FirstName) \(chatroom.user01LastName)")
                                                                .font(.system(size: 18, weight: .regular))
                                                                .foregroundColor(Color(UIColor.label))
                                                        }
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                            // MARK: User02 display
                                            
                                            if chatroom.user02UserID != Auth.auth().currentUser!.uid {
                                                
                                                HStack {
                                                    
                                                    if chatroom.user02SetProfileImage {
                                                        WebImage(url: URL(string: chatroom.user02ProfileImageURL))
                                                            .resizable()
                                                            .frame(width: 60, height: 60)
                                                            .clipShape(Circle())
                                                    } else {
                                                        Image(systemName: "person.circle.fill")
                                                            .resizable()
                                                            .foregroundColor(Color(UIColor.label))
                                                            .frame(width: 60, height: 60)
                                                    }
                                                    
                                                    VStack(alignment: .leading) {
                                                        Text(chatroom.user02Username)
                                                            .font(.system(size: 18, weight: .semibold))
                                                            .foregroundColor(Color(UIColor.label))
                                                        if chatroom.user02AccountType == "creator" {
                                                            Text("\(chatroom.user02FirstName) \(chatroom.user02LastName)")
                                                                .font(.system(size: 18, weight: .regular))
                                                                .foregroundColor(Color(UIColor.label))
                                                        }
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                            Spacer()
                                            
                                            // MARK: Arrow
                                            
                                            Image(systemName: "arrow.right.circle.fill")
                                                .resizable()
                                                .foregroundColor(Color(UIColor.label))
                                                .frame(width: 20, height: 20)
                                            
                                        }
                                        .id(chatroom.id)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        
                                    })
                                
                                // MARK: Divider
                                
                                if chatroom.id != chatroomManager.chatrooms.last?.id {
                                    Color(UIColor.label)
                                        .frame(height: 1)
                                        .padding(.horizontal, 20)
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                TabBarView(viewRouter: viewRouter, toggleVariables: toggleVariables)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            
        }
        
    }
    
    
}


// MARK: - Preview

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesListView(viewRouter: ViewRouter(), toggleVariables: ToggleVariablesModel(), chatroomManager: ChatroomManager())
    }
}
