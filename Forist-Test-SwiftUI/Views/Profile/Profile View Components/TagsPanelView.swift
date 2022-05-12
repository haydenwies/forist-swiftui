//
//  TagsPanelView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct TagsPanelView: View {
    
    @ObservedObject var toggleVariables: ToggleVariablesModel
    
    var body: some View {
        
        Button(action: {
            
            // Show ContentTagSelection
            toggleVariables.showContentTagSelection.toggle()

        }, label: {
            
            HStack {
                
                Spacer(minLength: 10)
                
                HStack {
                    
                    // MARK: - Tag icon
                    
                    Spacer()
                    
                    Image(systemName: "tag.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .padding(.vertical)
                    
                    Spacer()
                    
                }
                .clipped()
                .padding()
                .background(Color(UIColor.label))
                .cornerRadius(30)
                
                Spacer(minLength: 5)
                
            }
            
        })
        .fullScreenCover(isPresented: $toggleVariables.showContentTagSelection, content: {
            TagSelectionView(toggleVaribales: toggleVariables)
    })
        
    }
    
    
}


// MARK: - Preview

struct TagsPanelView_Previews: PreviewProvider {
    static var previews: some View {
        TagsPanelView(toggleVariables: ToggleVariablesModel())
    }
}
