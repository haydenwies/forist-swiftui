//
//  SearchProfileWebView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-08-15.
//

import SwiftUI

struct SearchProfileWebView: View {
    
    // Holds data to be displayed on user profile
    var userData: UserModel
    
    // For presenting alerts
    @State var alertContents: AlertContents?
    
    @State var showWebView = false
    
    var body: some View {
        
        Button(action: {
            
            if userData.webAddress.isEmpty {
                // Show alert
                alertContents = AlertContents(title: "Error", message: "No web addresse connected to your page, tap options menu on the upper right corner to add one", buttonTitle: "Okay")
            } else {
                showWebView = true
            }
            
        }, label: {

            HStack {
                
                Spacer(minLength: 10)
                
                HStack {
                    
                    Spacer()
                    
                    Image(systemName: "globe")
                        .resizable()
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(width: 25, height: 25)
                        .padding(.vertical)
                        
                    
                    Spacer()
                    
                }
                .clipped()
                .padding()
                .background(Color(UIColor.label))
                .cornerRadius(30)
                
                Spacer(minLength: 10)
                
            }

        })
        .fullScreenCover(isPresented: $showWebView, content: {
            VStack {
                
                Button(action: {
                    showWebView = false
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color(UIColor.label))
                            .padding(.horizontal, 25)
                            .padding(.vertical, 5)
                    }
                })
                
                WebView(url: userData.webAddress)
               
            }
            
        })
        .alert(item: $alertContents) { details in
            Alert(title: Text(alertContents!.title), message: Text(alertContents!.message), dismissButton: .default(Text(alertContents!.buttonTitle)))
        }
        
    }
    
    
}


// MARK: - Preview

struct SearchProfileWebView_Previews: PreviewProvider {
    static var previews: some View {
        SearchProfileWebView(userData: UserModel(userID: "", username: "", firstName: "", lastName: "", dateOfBirth: "", email: "", profileImageURL: "", setProfileImage: false, bio: "", accountType: "", searchableArray: [], contentTagsArray: [], webAddress: ""))
    }
}
