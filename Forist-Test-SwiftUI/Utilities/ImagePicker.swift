//
//  ImagePicker.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-16.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var pickedImage: Image?
    @Binding var showImagePicker: Bool
    @Binding var imageData: Data
    
    // MARK: - makeCoordinator
    
    // Assigns Coordinator class as ImagePicker coordinator
    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator(self)
    }
    
    // MARK: - makeUIViewController
    
    // Configures ImagePicker
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    // MARK: - updateUIViewController
    
    // Used to initialize values of selected image
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // MARK: - func imagePickerController
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // Assign selected image from picker as UIImage
            let uiImage = info[.editedImage] as! UIImage
            
            // Set selected image to pickedImage as type Image
            parent.pickedImage = Image(uiImage: uiImage)
            
            // Compression quality of 1.0 is min compression and 0.0 is max compression
            if let mediaData = uiImage.jpegData(compressionQuality: 0.8) {
                parent.imageData = mediaData
            }
            
            // Dismiss image picker
            parent.showImagePicker = false
            
        }
        
    }
    
    
}
