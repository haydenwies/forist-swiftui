//
//  01RegistrationView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct RegistrationOneView: View {
    
    // For navigating to profile after login/register attempt
    @StateObject var viewRouter: ViewRouter
    
    // For saving user data
    @ObservedObject var accountCreationModel = AccountCreationModel()
    
    // Navigation variable
    @State var proceedToNext = false
    
    var body: some View {
        
        VStack {
            
            // MARK: - Title
            
            Text("Who is this account for?")
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 40)
                .padding(.bottom, 40)
            
            // MARK: - Content creator button
            
            NavigationLink(
                destination: RegistrationTwoView(viewRouter: viewRouter, accountCreationModel: accountCreationModel),
                isActive: $proceedToNext,
                label: {
                    Button(action: {
                        // Set account type
                        accountCreationModel.accountType = "creator"
                        // Proceed to next screen
                        proceedToNext.toggle()
                    }, label: {
                        Text("Content creator")
                            .foregroundColor(Color(UIColor.systemBackground))
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 250, height: 50, alignment: .center)
                            .background(Color(UIColor.gray))
                            .cornerRadius(40)
                            .padding(10)
                    })
                })
            
            // MARK: - Business button
            
            NavigationLink(
                destination: RegistrationTwoView(viewRouter: viewRouter, accountCreationModel: accountCreationModel),
                isActive: $proceedToNext,
                label: {
                    Button(action: {
                        // Set account type
                        accountCreationModel.accountType = "business"
                        // Proceed to next screen
                        proceedToNext.toggle()
                    }, label: {
                        Text("Business")
                            .foregroundColor(Color(UIColor.systemBackground))
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 250, height: 50, alignment: .center)
                            .background(Color(UIColor.gray))
                            .cornerRadius(40)
                            .padding(10)
                    })
                })
            
            // MARK: - Non-profit button
            
            NavigationLink(
                destination: RegistrationTwoView(viewRouter: viewRouter, accountCreationModel: accountCreationModel),
                isActive: $proceedToNext,
                label: {
                    Button(action: {
                        // Set account type
                        accountCreationModel.accountType = "nonProfit"
                        // Proceed to next screen
                        proceedToNext.toggle()
                    }, label: {
                        Text("Non-profit organization")
                            .foregroundColor(Color(UIColor.systemBackground))
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 250, height: 50, alignment: .center)
                            .background(Color(UIColor.gray))
                            .cornerRadius(40)
                            .padding(10)
                    })
                })
            
            
            
        }
        
    }
    
    
}


// MARK: - Preview

struct RegistrationOneView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationOneView(viewRouter: ViewRouter())
    }
}
