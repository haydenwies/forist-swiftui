//
//  SearchProfileInfoPanelView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-15.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct SearchProfileInfoPanelView: View {
    
    // Holds data to be displayed on user profile
    var userData: UserModel
    
    @ObservedObject var chatroomManager = ChatroomManager()
    
    @State var alertContents: AlertContents?
    
    @Binding var showMessagePopup: Bool
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Spacer(minLength: 10)
                
                VStack {
                    
                    HStack(alignment: .top) {
                        
                        // MARK: - Profile image
                        
                        if userData.setProfileImage {
                        
                            WebImage(url: URL(string: userData.profileImageURL))
                                        .resizable()
                                        .frame(width: 75, height:75)
                                        .clipShape(Circle())
                            
                        } else {
                            
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 75, height:75)
                            .foregroundColor(Color(UIColor.systemBackground))
                        
                        }
                            
                        VStack(alignment: .leading) {
                            
                            // MARK: - Username
                            
                            Text(userData.username)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Color(UIColor.systemBackground))
                            
                            // MARK: - Full name
                            
                            Text("\(userData.firstName) \(userData.lastName)")
                                .foregroundColor(Color(UIColor.systemBackground))
                            
                        }
                        .padding(5)
                        
                        Spacer()
                        
                    }
                    .padding(.top)
                    
                    HStack {
                        
                        // MARK: - Bio
                        
                        Text(userData.bio)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .padding()
                        
                        Spacer()
                        
                    }
                    
                    // MARK: - Message button
                    
                    Button(action: {
                        chatroomManager.doesChatroomExist(user01UserID: Auth.auth().currentUser!.uid, user02UserID: userData.userID, handler: {
                            (documentExists) in
                            if documentExists  {
                                // Show alert
                                alertContents = AlertContents(title: "Error", message: "You already have a chat open with this person", buttonTitle: "Okay")
                            } else {
                                showMessagePopup = true
                            }
                        })
                        
                    }, label: {
                        
                        Text("Message")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(UIColor.label))
                            .padding(.horizontal, 100)
                            .padding(.vertical, 5)
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(10.0)
                            
                            
                    })
                    .padding(.bottom, 2)
                    
                }
                .clipped()
                .padding()
                .background(Color(UIColor.label))
                .cornerRadius(30)
                
                Spacer(minLength: 10)
                
            }
            
        }
        .alert(item: $alertContents) { details in
            Alert(title: Text(alertContents!.title), message: Text(alertContents!.message), dismissButton: .default(Text(alertContents!.buttonTitle)))
        }
        
    }
    
    
}


// MARK: - Preview

struct SearchProfileInfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        SearchProfileInfoPanelView(userData: UserModel(userID: "", username: "", firstName: "", lastName: "", dateOfBirth: "", email: "", profileImageURL: "", setProfileImage: false, bio: "", accountType: "", searchableArray: [], contentTagsArray: [], webAddress: ""), showMessagePopup: .constant(false))
    }
}
