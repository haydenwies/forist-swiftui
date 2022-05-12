//
//  TagSelectionView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct TagSelectionView: View {
    
    // For dismissing the view
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var toggleVaribales: ToggleVariablesModel
    
    @ObservedObject var contentTagsModel = ContentTagsModel()
    
    // Sync content tags (on appear)
    func syncContentTags() {
        let contentTagsArray = UserDefaults.standard.stringArray(forKey: "contentTagsArray")!
        if contentTagsArray.isEmpty == false {
            for category in contentTagsArray {
                contentTagsModel.contentTags["\(category)"] = true
            }
        }
    }
    
    // Update content tags (after changes)
    func updateContentTags() {
        // Update tags
        // Filter dictionary for only true values
        let filteredDictionary = contentTagsModel.contentTags.filter { $0.value == true }
        // Assign keys from filteredDictionary to array
        var activeTagsArray = Array(filteredDictionary.keys.map{ $0 })
        // Sort array alphabetically
        activeTagsArray.sort()
        // Save to UserDefaults
        UserDefaults.standard.set(activeTagsArray, forKey: "contentTagsArray")
        // Update Firebase
        StorageManager.updateDocument(field: "contentTagsArray", newData: activeTagsArray)
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Spacer()
                
                // MARK: - Close button
                
                Button(action: {
                    // Return to profile view
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(UIColor.label))
                })
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                
            }
            
            Spacer()
            
            HStack {
                
                // MARK: - Art
                
                Button (action: {
                    // Toggle content tag dictionary value
                    contentTagsModel.contentTags["art"]!.toggle()
                }, label: {
                    ZStack{
                        if contentTagsModel.contentTags["art"]! {
                            Color(UIColor.green)
                        } else {
                            Color(UIColor.gray)
                        }
                        Text("Art")
                            .foregroundColor(.black)
                    }
                    .frame(width: 40, height: 25)
                    .cornerRadius(5)
                })
                
                // MARK: - Music
                
                Button (action: {
                    // Toggle content tag dictionary value
                    contentTagsModel.contentTags["music"]!.toggle()
                }, label: {
                    ZStack{
                        if contentTagsModel.contentTags["music"]! {
                            Color(UIColor.green)
                        } else {
                            Color(UIColor.gray)
                        }
                        Text("Music")
                            .foregroundColor(.black)
                    }
                    .frame(width: 60, height: 25)
                    .cornerRadius(5)
                })
                
            }
            
            // MARK: - Update tags button
            
            Button(action: {
                // Save changes
                updateContentTags()
                // Dismiss view
                presentationMode.wrappedValue.dismiss()
            }, label: {
                ZStack {
                    Color(UIColor.label)
                        .frame(width: 130, height: 50)
                        .cornerRadius(50)
                    Text("Update Tags")
                        .fontWeight(.medium)
                        .foregroundColor(Color(UIColor.systemBackground))
                }
            })
            .padding()
            
            Spacer()
            
        }
        
        // MARK: - onAppear
        
        .onAppear(perform: {
            // Sync tags to display current settings
            syncContentTags()
        })
        
    }
    
    
}


// MARK: - Preview

struct TagSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TagSelectionView(toggleVaribales: ToggleVariablesModel())
    }
}
