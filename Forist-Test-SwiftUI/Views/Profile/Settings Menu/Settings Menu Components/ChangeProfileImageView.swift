//
//  ChangeProfileImageView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-26.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChangeProfileImageView: View {
    
    // For return to SettingsView
    @Binding var popToRoot: Bool
    
    // Value holders
    @Binding var setProfileImage: Bool
    @Binding var profileImageWasChanged: Bool
    @Binding var imageData: Data
    @Binding var profileImage: Image?
    @State var pickedImage: Image?
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    // Load image
    func loadImage() {
        setProfileImage = true
        profileImageWasChanged = true
        guard let inputImage = pickedImage else { return }
        profileImage = inputImage
    }
    
    var body: some View {
        
        VStack {
            
            // MARK: - Profile image
            
             if setProfileImage && profileImageWasChanged {
                
                profileImage!
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 200, height: 200)
                    // Present image picker action sheet
                    .onTapGesture {
                        showActionSheet = true
                    }
                    // Select image sheet
                    .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                        ImagePicker(pickedImage: $pickedImage, showImagePicker: $showImagePicker, imageData: $imageData)
                    }
                    
                    // Take or choose photo action sheet
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
            
             } else if setProfileImage {
  
                // Display selected image if available
                WebImage(url: URL(string: UserDefaults.standard.string(forKey: "profileImageURL")!))
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 200, height: 200)
                    // Present image picker action sheet
                    .onTapGesture {
                        showActionSheet = true
                    }
                    
                    // Select image sheet
                    .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                        ImagePicker(pickedImage: $pickedImage, showImagePicker: $showImagePicker, imageData: $imageData)
                    }
                    
                    // Take or choose photo action sheet
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
                
                // Select image sheet
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                    ImagePicker(pickedImage: $pickedImage, showImagePicker: $showImagePicker, imageData: $imageData)
                }
                
                // Take or choose photo action sheet
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
                
            }
            
            // MARK: - Text
            
            Text("(Tap to select new image)")
                .padding(5)
            
            // MARK: - Confirm button
            
            Button(action: {
                popToRoot.toggle()
            }, label: {
                Text("Confirm")
                    .foregroundColor(Color(UIColor.systemBackground))
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(Color(UIColor.gray))
                    .cornerRadius(40)
                    .padding(.vertical, 40)
            })
            
        }
        .onAppear(perform: {
            showActionSheet = false
        })
        
        
        
    }
    
}


// MARK: - Preview

struct ChangeProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeProfileImageView(popToRoot: .constant(false), setProfileImage: .constant(false), profileImageWasChanged: .constant(false), imageData: .constant(Data()), profileImage: .constant(nil))
    }
}
