//
//  SearchBarView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var value: String
    @State var isSearching = false
    
    var body: some View {
        
        HStack {
            
            // MARK: - Search bar
            
            TextField("Seach users", text: $value)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.leading, 15)
                .padding(.trailing, 25)
        }
        .padding()
        .background(Color(UIColor.systemGray5))
        .cornerRadius(40)
        .padding(.horizontal)
        .onTapGesture(perform: {
             isSearching = true
        })
        .overlay(
            
            // MARK: - "X" button
            
            HStack {
                Spacer()
                Button(action: {
                    // Clear user search field
                    value = ""
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(UIColor.label))
                        .frame(width: 30, height: 30)
                        })
            }
            .padding(.horizontal, 30)
        )
    }
    
    
}


// MARK: - Preview

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(value: .constant(""))
    }
}
