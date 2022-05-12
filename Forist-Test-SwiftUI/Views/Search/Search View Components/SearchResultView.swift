//
//  SearchResultView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchResultView: View {
    
    var userData: UserModel
    
    var body: some View {
        
        HStack {
        
        HStack(spacing: 15) {
            
            // MARK: - Profile image
            
            if userData.setProfileImage {
                
                WebImage(url: URL(string: userData.profileImageURL))
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                
            } else {
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(Color(UIColor.label))
                    .frame(width: 50, height: 50)
                
            }
            
            VStack(alignment: .leading, spacing: 4) {
                
                // MARK: - Username
                
                Text(userData.username)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(UIColor.label))
                
                HStack(alignment: .bottom, spacing: 5) {
                       
                    // MARK: - Full name
                    
                    if userData.accountType == "creator" {
                    
                    Text(userData.firstName)
                            .font(.system(size: 14))
                            .foregroundColor(Color(UIColor.label))
                        
                    Text(userData.lastName)
                            .font(.system(size: 14))
                            .foregroundColor(Color(UIColor.label))
                    
                    }
                        
                }
                
            }
            
        }
        
        Spacer()
        
        // MARK: - Account type indicator
            
            switch userData.accountType {
            case "creator":
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .foregroundColor(Color(UIColor.label))
                    .padding(.top, 5)
            case "business":
                Image(systemName: "briefcase.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .scaledToFit()
                    .foregroundColor(Color(UIColor.label))
                    .padding(.top, 5)
            case "nonProfit":
                Image(systemName: "cross.case.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .scaledToFit()
                    .foregroundColor(Color(UIColor.label))
                    .padding(.top, 5)
            default:
                Image(systemName: "circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .scaledToFit()
                    .foregroundColor(Color(UIColor.label))
                    .padding(.top, 5)
            }
        
        }
        
    }
    
    
}


// MARK: - Preview

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(userData: UserModel(userID: "", username: "", firstName: "", lastName: "", dateOfBirth: "", email: "", profileImageURL: "", setProfileImage: false, bio: "", accountType: "", searchableArray: [], contentTagsArray: [], webAddress: ""))
    }
}
