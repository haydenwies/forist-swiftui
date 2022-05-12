//
//  ContentView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI
import FirebaseAuth

struct MotherView: View {
    
    // Responsive for changing current view displayed on the mother view 
    @ObservedObject var viewRouter: ViewRouter

    @ObservedObject var chatroomManager = ChatroomManager()
    
    // Containing instances for showing temporary views and toggling tab bar
    @ObservedObject var toggleVariables = ToggleVariablesModel()
    
    init(viewRouter: ViewRouter) {
        self.viewRouter = viewRouter
        chatroomManager.fetchChatrooms()
    }
    
    var body: some View {
        
        ZStack {
            
            switch viewRouter.currentPage {
            
            // MARK: - Profile view
            
            case .profile:
                ProfileView(viewRouter: viewRouter, toggleVariables: toggleVariables)
                
            // MARK: - Login view
                
            case .login:
                LoginView(toggleVariables: toggleVariables, viewRouter: viewRouter)
             
            // MARK: - Messages view
                
            case .messages:
                MessagesListView(viewRouter: viewRouter, toggleVariables: toggleVariables, chatroomManager: chatroomManager)
                
            // MARK: - Notification view
                
            case .notifications:
                NotificationView()
             
            // MARK: - Search view
                
            case .search:
                SearchView(toggleVariables: toggleVariables, viewRouter: viewRouter)
                    .onAppear(perform: {
                        toggleVariables.hideTabBar = true
                    })
               
            // MARK: - Loading view
                
            case .load:
                LoadView(viewRouter: viewRouter)
                
            }
            
            // MARK: - Tab bar
            
            switch viewRouter.currentPage {
            
            case .login:
                EmptyView()
                
            case .search:
                EmptyView()
                
            case .load:
                EmptyView()
                
            case .messages:
                EmptyView()
                
            default:
                TabBarView(viewRouter: viewRouter, toggleVariables: toggleVariables)
                
            }
            
            
            
        }
        .onAppear(perform: {
            // Check to see if there is a user in session
            if Auth.auth().currentUser != nil {
                // There is a user
                viewRouter.currentPage = .profile
            } else {
                // No user currently in session
                viewRouter.currentPage = .login
            }
        })
        
    }
    
    
}


// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewRouter: ViewRouter())
    }
}
