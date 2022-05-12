//
//  ChangeWebAddressView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-08-13.
//

import SwiftUI
import Firebase

struct ChangeWebAddressView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var webAddress = UserDefaults.standard.string(forKey: "webAddress") ?? ""
    
    func saveButtonTapped() {
        
        if webAddress != UserDefaults.standard.string(forKey: "webAddress") {
        
            // Save to UserDefaults
            UserDefaults.standard.set(webAddress, forKey: "webAddress")
            // Save to database
            let database = Firestore.firestore()
            let userID = Auth.auth().currentUser!.uid
            database.collection("users").document(userID).updateData(["webAddress" : webAddress])
            
        }
        
        presentationMode.wrappedValue.dismiss()
            
    }
    
    var body: some View {
        
        VStack {
        
            Text("Change web address displayed on profile:")
                .font(.system(size: 18, weight: .medium))
                .padding(.horizontal)
        
            TextField("https://www.example.com", text: $webAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color(UIColor.label), lineWidth: 2)
                )
                .padding()
            
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
            
        }
    
    }
    
    
}


// MARK: - Preview

struct ChangeWebAddressView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeWebAddressView()
    }
}
