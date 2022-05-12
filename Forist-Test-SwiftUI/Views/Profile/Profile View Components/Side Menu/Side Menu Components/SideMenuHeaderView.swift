//
//  SideMenuHeaderView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct SideMenuHeaderView: View {
    
    @ObservedObject var toggleVariables: ToggleVariablesModel
    
    var body: some View {
        
        
        ZStack {
            
            // MARK: - Format for button
            
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            // Show menu bar
                            toggleVariables.hideTabBar.toggle()
                            // Return to profile view
                            toggleVariables.sideMenuButtonState.toggle()
                        }
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color(UIColor.label))
                    })
                    .padding(.horizontal, 30)
                    .padding(.vertical, 20)
                    
                }
                
                Spacer()
                
            }
            
            // MARK: - Format for logo and text
            
            HStack {
                
                VStack(alignment: .leading) {
                    
                    // Logo
                    Image(systemName: "leaf.fill")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 60, height: 60)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        .foregroundColor(Color(UIColor.label))
                    
                    // Text
                    Text("Hi \(UserDefaults.standard.string(forKey: "firstName") ?? "")")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color(UIColor.label))
                    
                    Spacer()
                    
                }.padding(30)
                
                Spacer()
                
            }
            
        }
        
    }
    
    
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(toggleVariables: ToggleVariablesModel())
    }
}
