//
//  LoginView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct LoginView: View {
    
    // For navigating to profile after login/register attempt
    @ObservedObject var viewRouter: ViewRouter
    
    // Used to hide menu bar
    @ObservedObject var toggleVariables: ToggleVariablesModel
    
    // For showing alerts
    @State var alertContents: AlertContents?
    
    // Placeholder variables
    @State var email = ""
    @State var password = ""
    
    init(toggleVariables: ToggleVariablesModel, viewRouter: ViewRouter) {
        
        self.toggleVariables = toggleVariables
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
    
    // Sign in
    func signIn() {
        // Sign in user witn email and passsword
        AuthManager.signIn(email: email, password: password, onSuccess: {
            
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
            UserDefaults.standard.set(user.accountType, forKey: "accountType")
            // Transition to profile
            viewRouter.currentPage = .profile
        }, onError: {
            (error) in
            // Could not sign in
            // Presetn alert
            alertContents = AlertContents(title: "Error", message: "Issue logging in user", buttonTitle: "Okay")
        })
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // MARK: - Log in header
                
                Text("Header")
                    .foregroundColor(Color(UIColor.label))
                    .font(.system(size: 30))
                    .padding(.top, 30)
                
                // MARK: - Email text field
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .frame(width: 300, height: 50, alignment: .center)
                    .padding(.top, 60)
                
                // MARK: - Password text field
                
                TextField("Password", text: $password)
                    .autocapitalization(.none)
                    .frame(width: 300, height: 50, alignment: .center)
                    .padding(.top, 20)
                
                // MARK: - Log in button
                
                Button(action: {
                    // Sign in
                    signIn()
                }, label: {
                    Text("Log in")
                        .foregroundColor(Color(UIColor.systemBackground))
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color(UIColor.gray))
                        .cornerRadius(40)
                        .padding()
                })
                
                // Seperates login button and sign up button
                Spacer()
                
                // MARK: - Sign up button
                
                NavigationLink(
                    destination: RegistrationOneView(viewRouter: viewRouter),
                    label: {
                        Text("Sign up")
                            .foregroundColor(Color(UIColor.label))
                    })
                
            }
            .navigationBarHidden(true)
            
        }
        
        .alert(item: $alertContents) { details in
            Alert(title: Text(alertContents!.title), message: Text(alertContents!.message), dismissButton: .default(Text(alertContents!.buttonTitle)))
        }
        
    }
    
    
}


// MARK: - Preview

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(toggleVariables: ToggleVariablesModel(), viewRouter: ViewRouter())
    }
}
