//
//  RegistrationTwoView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct RegistrationTwoView: View {
    
    // For navigating to profile after login/register attempt
    @ObservedObject var viewRouter: ViewRouter
    
    // For saving user data
    @ObservedObject var accountCreationModel: AccountCreationModel
    
    //Placeholder variables
    @State var datePlaceholder = Date()
    @State var dateFormatter = DateFormatter()
    @State var selectedGender = ""
    
    // For presenting alerts
    @State var alertContents: AlertContents?
    
    // Navigation variables
    @State var proceedToNext = false
    @State var showGenderSelection = false
    
    // Format date
    func setDate() {
        dateFormatter.dateStyle = .short
        accountCreationModel.dateOfBirth = "\(dateFormatter.string(from: datePlaceholder))"
    }
    
    // Next button tapped
    func nextButtonTapped() {
        // Set date
        setDate()
        // Validate fields
        if accountCreationModel.firstName.isEmpty || accountCreationModel.lastName.isEmpty || accountCreationModel.dateOfBirth.isEmpty || accountCreationModel.gender.isEmpty {
            // Fields empty
            // Present alert
            alertContents = AlertContents(title: "Error", message: "Please fill in all required fields", buttonTitle: "Okay")
        } else {
            // Transition to next screen
            proceedToNext.toggle()
        }
    }
    
    var body: some View {
        
        VStack {
            
            // MARK: - Header
            
            Text("Tell us about yourself // Who will be managing this account?")
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 150)
                .padding(.bottom, 40)
            
            // MARK: - First name field
            
            TextField("First name", text: $accountCreationModel.firstName)
                .autocapitalization(.words)
                .frame(width: 300, height: 50, alignment: .center)
                .padding(5)
            
            // MARK: - Last name field
            
            TextField("Last name", text: $accountCreationModel.lastName)
                .autocapitalization(.words)
                .frame(width: 300, height: 50, alignment: .center)
                .padding(5)
            
            // MARK: - Birth date field
            
            DatePicker("Date of birth", selection: $datePlaceholder, displayedComponents: .date)
                .frame(width: 300, height: 50, alignment: .center)
            
            // MARK: - Gender field
            
            Button(action: {
                showGenderSelection.toggle()
            }, label: {
                switch selectedGender {
                case "":
                    Text("Preferred gender")
                        .foregroundColor(Color(UIColor.systemGray3))
                        .frame(width: 300, height: 50, alignment: .leading)
                        .padding(5)
                default:
                        Text(selectedGender)
                            .foregroundColor(Color(UIColor.label))
                            .frame(width: 300, height: 50, alignment: .leading)
                            .padding(5)
                }
            })
            .sheet(isPresented: $showGenderSelection, content: {
                GenderSelectionView(accountCreationModel: accountCreationModel, selectedGender: $selectedGender)
            })
            
            
            // MARK: - Next button
            
            NavigationLink(
                destination: RegistrationThreeView(viewRouter: viewRouter, accountCreationModel: accountCreationModel),
                isActive: $proceedToNext,
                label: {
                    Button(action: {
                        nextButtonTapped()
                    }, label: {
                        Text("Next")
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

struct RegistrationTwoView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationTwoView(viewRouter: ViewRouter(), accountCreationModel: AccountCreationModel(), datePlaceholder: Date())
    }
}
