//
//  RegistrationFiveView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-15.
//

import SwiftUI

struct RegistrationFiveView: View {
    
    // For navigating to profile after login/register attempt
    @ObservedObject var viewRouter: ViewRouter
    
    // For saving user data
    @ObservedObject var accountCreationModel: AccountCreationModel
    
    // For presenting alerts
    @State var alertContents: AlertContents?
    
    // Determines what button was pressed
    @State var skipButton = false
    
    // Sign up
    func signUp() {
        var searchableArray: [String]
        // Make searchable array
        if accountCreationModel.accountType == "creator" {
            searchableArray = accountCreationModel.username.splitString() + accountCreationModel.firstName.splitString() + accountCreationModel.lastName.splitString()
        } else {
            searchableArray = accountCreationModel.username.splitString()
        }
        // Create user
        AuthManager.signUp(
            username: accountCreationModel.username.trimSpaces(),
            email: accountCreationModel.email.trimSpaces(),
            password: accountCreationModel.password.trimSpaces(),
            firstName: accountCreationModel.firstName.trimSpaces(),
            lastName: accountCreationModel.lastName.trimSpaces(),
            dateOfBirth: accountCreationModel.dateOfBirth,
            bio: accountCreationModel.bio,
            accountType: accountCreationModel.accountType,
            searchableArray: searchableArray,
            contentTagsArray: [],
            imageData: accountCreationModel.imageData,
            setProfileImage: accountCreationModel.setProfileImage,
            webAddress: accountCreationModel.webAddress,
            onSuccess: {
                (user) in
                // Signed in successfully
                // Save user data
                // Encode entire user data to JSON object for backup
                do {
                    let encoder = JSONEncoder()
                    let userData = try encoder.encode(user)
                    UserDefaults.standard.set(userData, forKey: "user")
                } catch  {
                    print("Unable to encode UserModel")
                }
                // Set UserDefaults for quick access data
                UserDefaults.standard.set(user.username, forKey: "username")
                UserDefaults.standard.set(user.firstName, forKey: "firstName")
                UserDefaults.standard.set(user.lastName, forKey: "lastName")
                UserDefaults.standard.set(user.profileImageURL, forKey: "profileImageURL")
                UserDefaults.standard.set(user.setProfileImage, forKey: "setProfileImage")
                UserDefaults.standard.set(user.bio, forKey: "bio")
                UserDefaults.standard.set(user.contentTagsArray, forKey: "contentTagsArray")
                UserDefaults.standard.set(user.email, forKey: "email")
                UserDefaults.standard.set(user.dateOfBirth, forKey: "dateOfBirth")
                // Transition to profile
                if skipButton {
                    skipButton = false
                    skipButtonTapped()
                } else {
                    nextButtonTapped()
                }
            }, onError: {
                (error) in
                alertContents = AlertContents(title: "Error", message: error, buttonTitle: "Okay")
            })
    }
    
    // Next button tapped
    func nextButtonTapped() {
        // Validate field
        if accountCreationModel.bio != "" {
            // Create user
            signUp()
            // Proceed to profile
            viewRouter.currentPage = .profile
        } else {
            // Present alert
            alertContents = AlertContents(title: "Error", message: "Please provide a bio in the given space", buttonTitle: "Okay")
        }
    }
    
    // Skip button tapped
    func skipButtonTapped() {
        // Bio set as empty string
        // Create user
        signUp()
        // Proceed to profile
        viewRouter.currentPage = .profile
    }
    
    var body: some View {
        
        VStack {
            
            // MARK: - Header
            
            Text("Tell everyone who you are")
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 150)
                .padding(.bottom, 40)
            
            // MARK: - Bio field
            
            TextField("Add a bio", text: $accountCreationModel.bio)
                .autocapitalization(.none)
                .frame(width: 300, height: 50, alignment: .center)
                .padding(8)
            
            // MARK: - Next button
            
            Button(action: {
               signUp()
            }, label: {
                Text("Go to profile")
                    .foregroundColor(Color(UIColor.systemBackground))
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(Color(UIColor.gray))
                    .cornerRadius(40)
                    .padding(.top, 30)
            })
            
            // MARK: - Skip button
            
            Button(action: {
                skipButton = true
                signUp()
            }, label: {
                Text("Skip and go to profile")
                    .foregroundColor(Color(UIColor.label))
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.top, 15)
            })
            
            Spacer()
            
        }
        
        // MARK: - Alert
        
        .alert(item: $alertContents) { details in
            Alert(title: Text(alertContents!.title), message: Text(alertContents!.message), dismissButton: .default(Text(alertContents!.buttonTitle)))
        }
        
    }
    
    
}


// MARK: - Preview

struct RegistrationFiveView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFiveView(viewRouter: ViewRouter(), accountCreationModel: AccountCreationModel())
    }
}
