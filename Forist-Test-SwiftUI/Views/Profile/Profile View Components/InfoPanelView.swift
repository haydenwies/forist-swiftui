//
//  AccountInfoPanel.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI
import SDWebImageSwiftUI

struct InfoPanelView: View {
    
    var profileImageURL: URL? = URL(string: UserDefaults.standard.string(forKey: "profileImageURL")!)
    
    var body: some View {
        
        HStack {
            
            // For gap on each side of the panel view
            Spacer(minLength: 10)
            
            // Groups profile image, name, and bio fields
            VStack {
                
                // Groups profile image and name fields
                HStack(alignment: .top) {
                    
                    // MARK: - Profile image
                    
                    // Check if profileImageURL contains a value, else display placeholder image
                    if UserDefaults.standard.bool(forKey: "setProfileImage") {
                        WebImage(url: profileImageURL)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 75, height:75)
                            .scaledToFit()
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 75, height:75)
                            .foregroundColor(Color(UIColor.systemBackground))
                    }
                    
                    // Groups both username and full name fields
                    VStack(alignment: .leading) {
                        
                        // MARK: - Username
                        
                        Text("\(UserDefaults.standard.string(forKey: "username") ?? "")")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(UIColor.systemBackground))
                        
                        // MARK: - Full name
                        
                        Text("\(UserDefaults.standard.string(forKey: "firstName") ?? "") \(UserDefaults.standard.string(forKey: "lastName") ?? "")")
                            .foregroundColor(Color(UIColor.systemBackground))
                        
                    }
                    .padding(5)
                    
                    // Pushes profile image and name fields to left
                    Spacer()
                    
                }
                .padding(.top)
                
                // MARK: - Bio

                
                if UserDefaults.standard.string(forKey: "bio") != "" {
                    
                    HStack {
                        
                        Text("\(UserDefaults.standard.string(forKey: "bio") ?? "")")
                            .foregroundColor(Color(UIColor.systemBackground))
                        
                        // Pushes bio to left
                        Spacer()
                        
                    }
                    .padding(15)
                    
                } else {
                    Text("")
                }
                
            }
            .clipped()
            .padding()
            .background(Color(UIColor.label))
            .cornerRadius(30)
            
            // For gap on each side of the panel view
            Spacer(minLength: 10)
            
        }
    
    }
    
    
}


// MARK: - Preview

struct AccountInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView()
    }
}
