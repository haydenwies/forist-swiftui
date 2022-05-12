//
//  SearchProfileTagsPanelView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-15.
//

import SwiftUI

struct SearchProfileTagsPanelView: View {
    
    // Holds data to be displayed on user profile
    var userData: UserModel
    
    var body: some View {
        
        //
        let formattedArray = (userData.contentTagsArray.map{String($0).capitalized}).joined(separator: ", ")
        
        HStack {
            
            Spacer(minLength: 10)
            
            HStack {
                
                // MARK: - Tag icon
                
                Image(systemName: "tag.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .padding(.leading)
                
                Text(":")
                    .foregroundColor(Color(UIColor.systemBackground))
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.bottom, 3)
                
                // MARK: - List of content tags
                
                if formattedArray.isEmpty {
                    
                    Text("No content categories")
                        .foregroundColor(Color(UIColor.systemBackground))
                        .padding(.leading, 10)
                    
                } else {
                    
                    Text(formattedArray)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .padding(.leading, 10)
                    
                }
                
                Spacer()
                
            }
            .padding(.vertical)
            .padding()
            .background(Color(UIColor.label))
            .cornerRadius(30)
            
            Spacer(minLength: 10)
            
        }
        
    }
    
    
}


// MARK: - Preview

struct SearchProfileTagsPanelView_Previews: PreviewProvider {
    static var previews: some View {
        SearchProfileTagsPanelView(userData: UserModel(userID: "", username: "", firstName: "", lastName: "", dateOfBirth: "", email: "", profileImageURL: "", setProfileImage: false, bio: "", accountType: "", searchableArray: [], contentTagsArray: [], webAddress: ""))
    }
}
