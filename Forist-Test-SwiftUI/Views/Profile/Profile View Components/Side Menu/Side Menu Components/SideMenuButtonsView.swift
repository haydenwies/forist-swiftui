//
//  SideMenuButtonsView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct SideMenuButtonsView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    @ObservedObject var toggleVariables: ToggleVariablesModel
    
    @State var showChangeWebAddress = false
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            // MARK: - ChangeWebAddress
            
            HStack {
                
                Button(action: {
                    // Show changeWebAddressView
                    showChangeWebAddress = true
                }, label: {
                    
                    Image(systemName: "globe")
                        .foregroundColor(Color(UIColor.label))
                    
                    Text("Change web address")
                        .foregroundColor(Color(UIColor.label))
                    
                })
                .popover(isPresented: $showChangeWebAddress, content: {
                    ChangeWebAddressView()
                })
                
                Spacer()
                
            }
            
            .padding(.horizontal, 30)
            
            // MARK: - Settings
            
            HStack {
                
                Button(action: {
                    // Present settingsView
                    toggleVariables.showSettings.toggle()
                }, label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(Color(UIColor.label))
                    Text("Settings")
                        .foregroundColor(Color(UIColor.label))
                })
                .fullScreenCover(isPresented: $toggleVariables.showSettings, content: {
                    SettingsView(viewRouter: viewRouter)
                })
                
                // Moves button to left of screen
                Spacer()
                
            }
            .padding(.horizontal, 30)
            
            // MARK: - Sign out
            
            HStack {
                
                Button(action: {
                    // Clear user session
                    AuthManager.signOut()
                    // Return to login screen
                    viewRouter.currentPage = .login
                }, label: {
                    Image(systemName: "arrowshape.turn.up.left.fill")
                        .foregroundColor(Color(UIColor.label))
                    Text("Log out")
                        .foregroundColor(Color(UIColor.label))
                })
                
                // Moves button to left of screen
                Spacer()
                
            }.padding(.horizontal, 30)
            
        }
        .padding(.top, 30)
        
    }
    
    
}


// MARK: - Preview

struct SideMenuButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuButtonsView(viewRouter: ViewRouter(), toggleVariables: ToggleVariablesModel())
    }
}
