//
//  SearchProfileView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-15.
//

import SwiftUI

struct SearchProfileView: View {
        
    // Holds data to be displayed on user profile
    var userData: UserModel
    
    @State var showMessagePopup = false
    
    var body: some View {
        
        ScrollView {
            
            SearchProfileInfoPanelView(userData: userData, showMessagePopup: $showMessagePopup)
                .padding(.top, 20)
            
            SearchProfileTagsPanelView(userData: userData)
                
            SearchProfileWebView(userData: userData)
                            
        }
        .navigationBarTitleDisplayMode(.inline)
        .popover(isPresented: $showMessagePopup, content: {
            NewMessagePopupView(userData: userData)
        })
        
    }
    
    
}


// MARK: - Preview

struct SearchProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SearchProfileView(userData: UserModel(userID: "", username: "", firstName: "", lastName: "", dateOfBirth: "", email: "", profileImageURL: "", setProfileImage: false, bio: "", accountType: "", searchableArray: [], contentTagsArray: [], webAddress: ""))
    }
}
