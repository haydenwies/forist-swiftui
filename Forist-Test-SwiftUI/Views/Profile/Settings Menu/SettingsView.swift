//
//  SettingsView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-22.
//

import SwiftUI

struct SettingsView: View {
    
    // For dismissing view
    @Environment(\.presentationMode) var presentationMode
    
    // For navigating to load after saveButtonTapped
    @ObservedObject var viewRouter: ViewRouter
    
    // Holding changed values -- change to UserDefaults
    @State var username = UserDefaults.standard.string(forKey: "username") ?? ""
    @State var email = UserDefaults.standard.string(forKey: "email") ?? ""
    @State var firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
    @State var lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
    @State var newPassword  = ""
    @State var imageData = Data()
    @State var setProfileImage = UserDefaults.standard.bool(forKey: "setProfileImage")
    @State var profileImageWasChanged = false
    @State var bio = UserDefaults.standard.string(forKey: "bio") ?? ""
    
    // Placeholder variables
    @State var profileImage: Image?
    
    // To pop to root view
    @State var popFromPassword = false
    @State var popFromProfileImage = false
    @State var popFromBio = false
    
    init(viewRouter: ViewRouter) {
        
        self.viewRouter = viewRouter
        
        // Cosmetic configuration for navigation bar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor.systemBackground
        navBarAppearance.shadowColor = UIColor.clear
        UINavigationBar.appearance().tintColor = UIColor.label
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
    }
    
    // Save button tapped
    func saveButtonTapped() {
        // Save changes
        // Change account info
        AccountSettingsManager.updateProfile(username: username, firstName: firstName, lastName: lastName, email: email, newPassword: newPassword, imageData: imageData, profileImageWasChanged: profileImageWasChanged, bio: bio)
        // Dismiss view
        presentationMode.wrappedValue.dismiss()
        // Move to load screen
        viewRouter.currentPage = .load
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack {
                    
                    // MARK: - Header
                    
                    Text("Account Settings")
                        .padding(.horizontal, 30)
                        .font(.system(size: 24, weight: .bold))
                    
                    Spacer()
                    
                    // MARK: - Close button
                    
                    Button(action: {
                        // Return to profile view
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color(UIColor.label))
                    })
                    .padding(.horizontal, 30)
                    
                    
                }
                .padding(.top, 20)
                
                ScrollView {
                    
                    // MARK: - Username
                    
                    VStack(spacing: 2) {
                        
                        HStack {
                            
                            Text("Username")
                                .padding(.horizontal, 20)
                            
                            Spacer()
                            
                        }
                        
                        TextField("Username", text: $username)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .stroke(Color(UIColor.label), lineWidth: 2)
                            )
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    
                    // MARK: - Email
                    
                    VStack(spacing: 2) {
                        
                        HStack {
                            
                            Text("Email")
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding(.horizontal, 20)
                            
                            Spacer()
                            
                        }
                        
                        TextField("Email", text: $email)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .stroke(Color(UIColor.label), lineWidth: 2)
                            )
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    
                    // MARK: - First name
                    
                    VStack(spacing: 2) {
                        
                        HStack {
                            
                            Text("First name")
                                .padding(.horizontal, 20)
                            
                            Spacer()
                            
                        }
                        
                        TextField("First name", text: $firstName)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .stroke(Color(UIColor.label), lineWidth: 2)
                            )
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    
                    // MARK: - Last name
                    
                    VStack(spacing: 2) {
                        
                        HStack {
                            
                            Text("Last name")
                                .padding(.horizontal, 20)
                            
                            Spacer()
                            
                        }
                        
                        TextField("Last name", text: $lastName)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .stroke(Color(UIColor.label), lineWidth: 2)
                            )
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    
                    // MARK: - Password
                    
                    NavigationLink(
                        destination: ChangePasswordView(popToRoot: self.$popFromPassword, newPassword: $newPassword),
                        isActive: $popFromPassword,
                        label: {
                            
                            ZStack {
                                
                                HStack {
                                    
                                    Image(systemName: "lock")
                                    
                                    Spacer()
                                    
                                }
                                
                                HStack {
                                    
                                    Text("Change password")
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrowshape.turn.up.forward.circle")
                                    
                                }
                                .padding(.leading, 30)
                            }
                            .foregroundColor(Color(UIColor.label))
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .stroke(Color(UIColor.label), lineWidth: 2)
                            )
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            
                        })
                    
                    // MARK: - Profile image
                    
                    NavigationLink(
                        destination: ChangeProfileImageView(popToRoot: self.$popFromProfileImage, setProfileImage: $setProfileImage, profileImageWasChanged: $profileImageWasChanged, imageData: $imageData, profileImage: $profileImage),
                        isActive: $popFromProfileImage,
                        label: {
                            
                            ZStack {
                                
                                HStack {
                                    
                                    Image(systemName: "person.circle")
                                    
                                    Spacer()
                                    
                                }
                                
                                HStack {
                                    
                                    Text("Change profile image")
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrowshape.turn.up.forward.circle")
                                    
                                }
                                .padding(.leading, 30)
                            }
                            .foregroundColor(Color(UIColor.label))
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .stroke(Color(UIColor.label), lineWidth: 2)
                            )
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            
                        })
                        .isDetailLink(false)
                    
                    // MARK: - Bio
                    
                    NavigationLink(
                        destination: ChangeBioView(popToRoot: self.$popFromBio, bio: $bio),
                        isActive: $popFromBio,
                        label: {
                            
                            ZStack {
                                
                                HStack {
                                    
                                    Image(systemName: "text.bubble")
                                    
                                    Spacer()
                                    
                                }
                                
                                HStack {
                                    
                                    Text("Change bio")
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrowshape.turn.up.forward.circle")
                                    
                                }
                                .padding(.leading, 30)
                            }
                            .foregroundColor(Color(UIColor.label))
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .stroke(Color(UIColor.label), lineWidth: 2)
                            )
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            
                        })
                    
                    // MARK: - Save button
                    
                    Button(action: {
                        saveButtonTapped()
                    }, label: {
                        Text("Save")
                            .foregroundColor(Color(UIColor.systemBackground))
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 200, height: 50, alignment: .center)
                            .background(Color(UIColor.gray))
                            .cornerRadius(40)
                            .padding()
                    })
                    
                    Spacer()
                    
                }
                .navigationBarHidden(true)
            }
            
        }
        
    }
    
    
}


// MARK: - Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewRouter: ViewRouter())
    }
}
