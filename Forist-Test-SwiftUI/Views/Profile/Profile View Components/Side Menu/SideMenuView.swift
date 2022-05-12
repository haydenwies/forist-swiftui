//
//  SideMenuView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct SideMenuView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    @ObservedObject var toggleVariables: ToggleVariablesModel
    
    var body: some View {
        
        ZStack {
            
            Color(UIColor.gray)
                .ignoresSafeArea()
            
            VStack {
                
                SideMenuHeaderView(toggleVariables: toggleVariables)
                    .frame(height: 200)
                
                SideMenuButtonsView(viewRouter: viewRouter, toggleVariables: toggleVariables)
                
                Spacer()
                
            }
            
        }
 
    }
    
    
}


// MARK: - Preview

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(viewRouter: ViewRouter(), toggleVariables: ToggleVariablesModel())
    }
}
