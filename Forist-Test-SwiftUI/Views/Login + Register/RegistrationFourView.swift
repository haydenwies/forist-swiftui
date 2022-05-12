//
//  RegistrationFourView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-15.
//

import SwiftUI

struct RegistrationFourView: View {
    
    // For navigating to profile after login/register attempt
    @ObservedObject var viewRouter: ViewRouter
    
    // For saving user data
    @ObservedObject var accountCreationModel: AccountCreationModel
    
    // Placeholder variables
    @State var profileImage: Image?
    @State var pickedImage: Image?
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    // For presenting alerts
    @State var alertContents: AlertContents?
    
    // Navigation variable
    @State var proceedToNext = false
    
    // Load image
    func loadImage() {
        guard let inputImage = pickedImage else { return }
        profileImage = inputImage
    }
    
    // Next button tapped
    func nextButtonTapped() {
        // Check if image is selected
        if accountCreationModel.imageData != Data() {
            // Has selected image
            accountCreationModel.setProfileImage = true
            // Proceed to next view
            proceedToNext.toggle()
        } else {
            // No image selected
            // Present alert
            alertContents = AlertContents(title: "Error", message: "Please choose a profile photo", buttonTitle: "Okay")
        }
    }
    
    // Skip button tapped
    func skipButtonTapped() {
        // Image data set as empty
        accountCreationModel.setProfileImage = false
        // Proceed to next view
        proceedToNext.toggle()
    }
    
    var body: some View {
        
        VStack {
            
            // MARK: - Header
            
            Text("Give your profile a face")
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 150)
                .padding(.bottom, 40)
            
            // MARK: - Profile image selection button
            
            if profileImage != nil {
                
                // Display selected image if available
                profileImage!
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 200, height: 200)
                    // Present image picker action sheet
                    .onTapGesture {
                        showActionSheet = true
                    }
                
            } else {
                
                // If no image has been selected show placeholder
                ZStack {
                    
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(Color(UIColor.label))
                        .frame(width: 200, height: 200)
                    
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.leading, 120)
                        .padding(.bottom, 120)
                        .foregroundColor(Color(UIColor.gray))
                    
                }
                // Present image picker action sheet
                .onTapGesture {
                    showActionSheet = true
                }
                
            }
            
            // MARK: - Context
            
            Text("(Tap to select a photo)")
                .font(.system(size: 14))
                .padding(5)
            
            // MARK: - Next button
            
            // Fixes popout bug
            NavigationLink(destination: EmptyView()) {
                EmptyView()
            }
            
            NavigationLink(
                destination: RegistrationFiveView(viewRouter: viewRouter, accountCreationModel: accountCreationModel),
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
                            .padding(.top, 30)
                    })
                })
            
            // MARK: - Skip button
            
            NavigationLink(
                destination: RegistrationFiveView(viewRouter: viewRouter, accountCreationModel: accountCreationModel),
                label: {
                    Button(action: {
                       skipButtonTapped()
                    }, label: {
                        Text("Skip")
                            .foregroundColor(Color(UIColor.label))
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.top, 15)
                    })
                })
            
            Spacer()
            
        }
        
        // MARK: - Sheet to present image picker
        
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(pickedImage: $pickedImage, showImagePicker: $showImagePicker, imageData: $accountCreationModel.imageData)
        }
        
        // MARK: - Action sheet to present image selection methods
        
        .actionSheet(isPresented: $showActionSheet, content: {
            ActionSheet(title: Text(""), buttons: [
                .default(Text("Choose a photo")) {
                    sourceType = .photoLibrary
                    showImagePicker = true
                },
                .default(Text("Take a photo")) {
                    sourceType = .camera
                    showImagePicker = true
                },
                .cancel()
                
            ])
        })
        
        // MARK: - Alert
        
        .alert(item: $alertContents) { details in
            Alert(title: Text(alertContents!.title), message: Text(alertContents!.message), dismissButton: .default(Text(alertContents!.buttonTitle)))
        }
        
    }
    
    
}


// MARK: - Preview

struct RegistrationFourView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFourView(viewRouter: ViewRouter(), accountCreationModel: AccountCreationModel())
    }
}
