//
//  RegistrationThreeView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct RegistrationThreeView: View {
    
    // For navigating to profile after login/register attempt
    @ObservedObject var viewRouter: ViewRouter
    
    // For saving user data
    @ObservedObject var accountCreationModel: AccountCreationModel
    
    @State var confirmedPasword = ""
    
    // For presenting alerts
    @State var alertContents: AlertContents?
    
    // Navigation variable
    @State var proceedToNext = false
    
    // Next button tapped
    func nextButtonTapped() {
        // Validate fields
        if accountCreationModel.username.isEmpty || accountCreationModel.email.isEmpty || accountCreationModel.password.isEmpty {
            // Fields empty
            // Present alert
            alertContents = AlertContents(title: "Error", message: "Please fill in all required fields", buttonTitle: "Okay")
        } else {
            // Validate password
            let isPasswordValid = AuthManager.validatePassword(accountCreationModel.password)
            if !isPasswordValid {
                // Password isn't valid
                // Present alert
                alertContents = AlertContents(title: "Error", message: "Please make a password that's at least 8 characters long, contains a special character, and a number", buttonTitle: "Okay")
            } else if accountCreationModel.password != confirmedPasword {
                // Passwords dont match
                // Present alert
                alertContents = AlertContents(title: "Error", message: "Passwords don't match", buttonTitle: "Okay")
            } else {
                // Proceed to next view
                proceedToNext.toggle()
            }
        }
    }
    
    var body: some View {
        
        VStack {
            
            // MARK: - Header
            
            Text("Create your account.")
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 150)
                .padding(.bottom, 40)
            
            // MARK: - Username field
            
            TextField("Username // Company name", text: $accountCreationModel.username)
                .autocapitalization(.none)
                .frame(width: 300, height: 50, alignment: .center)
                .padding(8)
            
            // MARK: - Email field
            
            TextField("Email", text: $accountCreationModel.email)
                .autocapitalization(.none)
                .frame(width: 300, height: 50, alignment: .center)
                .padding(8)
            
            // MARK: - Password field
            
            SecureField("Password", text: $accountCreationModel.password)
                .autocapitalization(.none)
                .frame(width: 300, height: 50, alignment: .center)
                .padding(8)
            
            // MARK: - Password confirmation field
            
            SecureField("Confirm password", text: $confirmedPasword)
                .autocapitalization(.none)
                .frame(width: 300, height: 50, alignment: .center)
                .padding(8)
            
            // MARK: - Next button
            
            NavigationLink(
                destination: RegistrationFourView(viewRouter: viewRouter, accountCreationModel: accountCreationModel),
                isActive: $proceedToNext,
                label: {
                    Button(action: {
                        nextButtonTapped()
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(Color(UIColor.systemBackground))
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 200, height: 50, alignment: .center)
                            .background(Color(UIColor.gray))
                            .cornerRadius(40)
                            .padding()
                    })
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

struct RegistrationThreeView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationThreeView(viewRouter: ViewRouter(), accountCreationModel: AccountCreationModel())
    }
}
