//
//  TabBarView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct TabBarView: View {
    
    // Used to change current page variable 
    @StateObject var viewRouter: ViewRouter
    
    // Containing instances to toggle tab bar
    @ObservedObject var toggleVariables: ToggleVariablesModel
    
    var body: some View {
        
        VStack {
            
            // Pushes bar to bottom of screen
            Spacer()
            
            ZStack {
                
                // MARK: - Background colour
                Color(UIColor.label)
                    .scaledToFill()
                    .frame(width: 350, height: 50)
                    .cornerRadius(25)
                
                HStack(spacing: 60) {
                    
                    // MARK: - Profile button
                    Button(action: {
                        viewRouter.currentPage = .profile
                    }, label: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(UIColor.systemBackground))
                            .frame(width: 22, height: 22)
                    })
                    
                    // MARK: - Messages page
                    Button(action: {
                        // Button action
                        viewRouter.currentPage = .messages
                    }, label: {
                        Image(systemName: "message.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(UIColor.systemBackground))
                            .frame(width: 22, height: 22)
                    })
                    
                    // MARK: - Notifications page
                    Button(action: {
                        // Button action
                        viewRouter.currentPage = .notifications
                    }, label: {
                        Image(systemName: "newspaper.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(UIColor.systemBackground))
                            .frame(width: 22, height: 22)
                    })
                    
                    // MARK: - Search page
                    Button(action: {
                        // Button action
                        viewRouter.currentPage = .search
                    }, label: {
                        Image(systemName: "binoculars.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(UIColor.systemBackground))
                            .frame(width: 22, height: 22)
                    })
                    
                }
            }
        }
        .offset(x: 0, y : toggleVariables.hideTabBar ? 100 : 0)
        .ignoresSafeArea(.keyboard)
        
    }
    
    
}


// MARK: - Preview

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(viewRouter: ViewRouter(), toggleVariables: ToggleVariablesModel())
    }
}
