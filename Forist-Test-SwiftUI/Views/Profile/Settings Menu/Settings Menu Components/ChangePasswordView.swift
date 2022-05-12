//
//  ChangePasswordView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-26.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ChangePasswordView: View {
    
    // For return to SettingsView
    @Binding var popToRoot: Bool
    
    // Value holders
    @State var password = ""
    @Binding var newPassword: String
    @State var confirmNewPassword = ""
    
    // For presenting alerts
    @State var alertContents: AlertContents?
    
    func confirmButtonPressed() {
        
        if password.isEmpty || newPassword.isEmpty || confirmNewPassword.isEmpty {
            
            // Present alert
            alertContents = AlertContents(title: "Error", message: "Please fill in all required fields", buttonTitle: "Okay")
            
        } else {
            
            if newPassword != confirmNewPassword {
                
                // Present alert
                alertContents = AlertContents(title: "Error", message: "Passwords do not match", buttonTitle: "Okay")
                
            } else {
                
                let isPasswordValid = AuthManager.validatePassword(newPassword)
                if !isPasswordValid {
                    
                    // Present alert
                    alertContents = AlertContents(title: "Error", message: "Password must be at least 8 characters long, contains a special character, and a number", buttonTitle: "Okay")
                    
                } else {
                    
                    let encodedUserData = UserDefaults.standard.data(forKey: "user")!
                    do {
                        let decoder = JSONDecoder()
                        let userData = try decoder.decode(UserModel.self, from: encodedUserData)
                        
                        let reauthenticateCredential = EmailAuthProvider.credential(withEmail: userData.email, password: password)
                        
                        Auth.auth().currentUser!.reauthenticate(with: reauthenticateCredential) {
                            (AuthDataResult, error) in
                            
                            if error != nil {
                                print(error!.localizedDescription)
                            } else {
                                
                                popToRoot.toggle()
                                
                            }
                        }
                        
                    } catch {
                        print("Could not decode user")
                    }
                    
                }
                
            }
            
        }
        
    }
    
    var body: some View {
        
        VStack {
            
            // MARK: - Password
            
            VStack(spacing: 2) {
                
                HStack {
                    
                    Text("Password")
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                }
                
                TextField("Password", text: $password)
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
            
            // MARK: - Confirm password
            
            VStack(spacing: 2) {
                
                HStack {
                    
                    Text("New password")
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                }
                
                TextField("new password", text: $newPassword)
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
            
            // MARK: - New password
            
            VStack(spacing: 2) {
                
                HStack {
                    
                    Text("Confirm new password")
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                }
                
                TextField("Confirm new password", text: $confirmNewPassword)
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
            
            // MARK: - Confirm button
            
            Button(action: {
                confirmButtonPressed()
            }, label: {
                Text("Confirm")
                    .foregroundColor(Color(UIColor.systemBackground))
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(Color(UIColor.gray))
                    .cornerRadius(40)
                    .padding()
            })
            
        }
        .alert(item: $alertContents) { details in
            Alert(title: Text(alertContents!.title), message: Text(alertContents!.message), dismissButton: .default(Text(alertContents!.buttonTitle)))
        }
        
    }
    
}


// MARK: - Preview

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(popToRoot: .constant(false), newPassword: .constant(""))
    }
}
