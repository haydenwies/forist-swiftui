//
//  ChangeBioView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-26.
//

import SwiftUI

struct ChangeBioView: View {
    
    // For return to SettingsView
    @Binding var popToRoot: Bool
    
    @Binding var bio: String
    
    var body: some View {
        
        VStack {
            
            TextField("Bio", text: $bio)
                .autocapitalization(.none)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color(UIColor.label), lineWidth: 2)
                )
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            
            Button(action: {
                popToRoot.toggle()
            }, label: {
                Text("Confirm")
                    .foregroundColor(Color(UIColor.systemBackground))
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(Color(UIColor.gray))
                    .cornerRadius(40)
                    .padding(.vertical, 20)
            })
            
        }
        
    }
    
    
}


// MARK: - Preview

struct ChangeBioView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeBioView(popToRoot: .constant(false), bio: .constant(""))
    }
}
