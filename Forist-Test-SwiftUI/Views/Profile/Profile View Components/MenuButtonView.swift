//
//  SideMenuButtonView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct MenuButtonView: View {
    
    // Containing instances for toggling tab bar
    @ObservedObject var toggleVariables: ToggleVariablesModel
    
    var body: some View {
       
        HStack {
            
            Spacer()
            
            Button(action: {
                withAnimation(.spring()) {
                    // Show side menu
                    toggleVariables.sideMenuButtonState.toggle()
                    // Hide menu bar
                    toggleVariables.hideTabBar.toggle()
                }
            }, label: {
                Image(systemName: "ellipsis.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color(UIColor.label))
            })
            .padding(.trailing, 20)
            .padding(.top, 10)
            .padding(.bottom, 10)
        }
        
    }
    
    
}


// MARK: - Preview

struct SideMenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MenuButtonView(toggleVariables: ToggleVariablesModel())
    }
}
