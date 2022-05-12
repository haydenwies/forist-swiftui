//
//  ProfileView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    @ObservedObject var toggleVariables: ToggleVariablesModel
    
    var body: some View {
        
        ZStack {
            
            // MARK: - Side menu
            if toggleVariables.sideMenuButtonState {
                SideMenuView(viewRouter: viewRouter, toggleVariables: toggleVariables)
            }
            
            ZStack {
                
                // MARK: - Background
                Color(UIColor.systemBackground)
                
                VStack {
                    
                    // MARK: - Menu button
                    MenuButtonView(toggleVariables: toggleVariables)
                    
                    ScrollView {
                        
                        // MARK: - Account info panel
                        InfoPanelView()
                        
                        HStack {
                            
                            // MARK: - Tags panel
                            TagsPanelView(toggleVariables: toggleVariables)
                            
                            WebPageView()
                            
                        }
                        
                    }
                    
                }
                
                // MARK: - Button overlay (toggle sideMenuButtonState)
                if toggleVariables.sideMenuButtonState {
                    Button(action: {
                        withAnimation(.spring()) {
                            // Returns to profile view
                            toggleVariables.sideMenuButtonState.toggle()
                            // Shows tab bar
                            toggleVariables.hideTabBar.toggle()
                        }
                    }, label: {
                        Color(UIColor.clear)
                    })
                }
                
            }
            .cornerRadius(toggleVariables.sideMenuButtonState ? 20 : 10)
            .offset(x: toggleVariables.sideMenuButtonState ? 300 : 0, y: toggleVariables.sideMenuButtonState ? 44 : 0)
            .scaleEffect(toggleVariables.sideMenuButtonState ? 0.8 : 1)
            
        }
        
    }
    
    
}


// MARK: - Preview

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewRouter: ViewRouter(), toggleVariables: ToggleVariablesModel())
    }
}
