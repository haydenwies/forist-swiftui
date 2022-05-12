//
//  SwiftUIView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-17.
//

import SwiftUI

struct GenderSelectionView: View {
    
    // For popping view once selection is made
    @Environment(\.presentationMode) var presentationMode
    
    // For saving user data
    @ObservedObject var accountCreationModel: AccountCreationModel
    
    // To be displayed on RegistrationTwoView
    @Binding var selectedGender: String

    
    @State var gender = [
        "male" : false,
        "female" : false,
        "nonBinary" : false,
        "transgender" : false,
        "other" : false,
        "preferNotToSay" : false
    ]
    
    // Confirm button tapped
    func confirmButtonTapped() {
        // Convert dictionary to filtered string:
        // Filter dictionary for only true values
        let filteredDictionary = gender.filter { $0.value == true }
        // Assign keys from filteredDictionary to array
        let filteredArray = Array(filteredDictionary.keys.map{ $0 })
        // Set first value of array as a string
        if filteredArray.count == 1 {
            accountCreationModel.gender = filteredArray[0]
            // Dismiss view
            presentationMode.wrappedValue.dismiss()
        }
        // Else do nothing (if nothing was selected)
    }
    
    var body: some View {
        
        VStack(alignment: .center  , spacing: 20) {
            
            // MARK: - Male
            
            Button(action: {
                gender.keys.forEach { gender[$0] = false }
                gender["male"] = true
                selectedGender = "Male"
            }, label: {
                ZStack {
                    if gender["male"]! {
                        Color(UIColor.gray)
                    } else {
                        Color(UIColor.red)
                    }
                    Text("Male")
                        .foregroundColor(Color(UIColor.label))
                        .font(.system(size: 18, weight: .semibold))
                }
                .frame(width: 50, height: 25)
                .cornerRadius(5)
            })
            
            // MARK: - Female
            
            Button(action: {
                gender.keys.forEach { gender[$0] = false }
                gender["female"] = true
                selectedGender = "Female"
            }, label: {
                ZStack {
                    if gender["female"]! {
                        Color(UIColor.gray)
                    } else {
                        Color(UIColor.red)
                    }
                    Text("Female")
                        .foregroundColor(Color(UIColor.label))
                        .font(.system(size: 18, weight: .semibold))
                }
                .frame(width: 70, height: 25)
                .cornerRadius(5)
            })
            
            // MARK: - NonBinary
            
            Button(action: {
                gender.keys.forEach { gender[$0] = false }
                gender["nonBinary"] = true
                selectedGender = "Non Binary"
            }, label: {
                ZStack {
                    if gender["nonBinary"]! {
                        Color(UIColor.gray)
                    } else {
                        Color(UIColor.red)
                    }
                    Text("Non-Binary")
                        .foregroundColor(Color(UIColor.label))
                        .font(.system(size: 18, weight: .semibold))
                }
                .frame(width: 110, height: 25)
                .cornerRadius(5)
            })
            
            // MARK: - Transgender
            
            Button(action: {
                gender.keys.forEach { gender[$0] = false }
                gender["transgender"] = true
                selectedGender = "Transgender"
            }, label: {
                ZStack {
                    if gender["transgender"]! {
                        Color(UIColor.gray)
                    } else {
                        Color(UIColor.red)
                    }
                    Text("Transgender")
                        .foregroundColor(Color(UIColor.label))
                        .font(.system(size: 18, weight: .semibold))
                }
                .frame(width: 120, height: 25)
                .cornerRadius(5)
            })
            
            // MARK: - Other
            
            Button(action: {
                gender.keys.forEach { gender[$0] = false }
                gender["other"] = true
                selectedGender = "Other"
            }, label: {
                ZStack {
                    if gender["other"]! {
                        Color(UIColor.gray)
                    } else {
                        Color(UIColor.red)
                    }
                    Text("Other")
                        .foregroundColor(Color(UIColor.label))
                        .font(.system(size: 18, weight: .semibold))
                }
                .frame(width: 60, height: 25)
                .cornerRadius(5)
            })
            
            // MARK: - PreferNotToSay
            
            Button(action: {
                gender.keys.forEach { gender[$0] = false }
                gender["preferNotToSay"] = true
                selectedGender = "Prefer not to say"
            }, label: {
                ZStack {
                    if gender["preferNotToSay"]! {
                        Color(UIColor.gray)
                    } else {
                        Color(UIColor.red)
                    }
                    Text("Prefer not to say")
                        .foregroundColor(Color(UIColor.label))
                        .font(.system(size: 18, weight: .semibold))
                }
                .frame(width: 150, height: 25)
                .cornerRadius(5)
            })
            
            // MARK: - Confirm
            
            Button(action: {
                confirmButtonTapped()
            }, label: {
                ZStack {
                    
                    Color(UIColor.gray)
                    
                    Text("Confirm")
                        .foregroundColor(Color(UIColor.label))
                        .font(.system(size: 18, weight: .semibold))
                }
            })
            .frame(width: 150, height: 50)
            .cornerRadius(40)
            .padding(.vertical, 30)
            
        }
        
    }
    
    
}


// MARK: - Preview

struct GenderSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectionView(accountCreationModel: AccountCreationModel(), selectedGender: .constant(""))
    }
}
