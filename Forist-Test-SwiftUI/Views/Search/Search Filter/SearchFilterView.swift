//
//  SearchFilterView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-23.
//

import SwiftUI

struct SearchFilterView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var filteredSearchManager = FilteredSearchManager()
    
    // Account type isSelected variables
    @State var creatorIsSelected = false
    @State var businessIsSelected = false
    @State var nonProfitIsSelected = false
    
    @State var showResults = false
    
    // Content selection tags
    @State var tagsCollection: [String : Bool] = [
        "music": false,
        "art" : false
    ]
    
    // Platform isSelected variables
    @State var instagramIsSelected = false
    @State var youtubeIsSelected = false
    @State var tiktokIsSelected = false
    
    init() {
       
        // Cosmetic configuration for navigation bar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor.systemBackground
        navBarAppearance.shadowColor = UIColor.clear
        UINavigationBar.appearance().tintColor = UIColor.label
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // MARK: - Dismiss button
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        // Dismiss view
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color(UIColor.label))
                            .padding()
                            .padding(.trailing, 10)
                    })
                    
                }
                
                // MARK: - User type selection
                
                ScrollView {
                    
                    VStack {
                        
                        HStack {
                            
                            Text("Account Type")
                                .font(.system(size: 18, weight: .semibold))
                                .padding(.leading, 30)
                                .padding(.bottom, 10)
                            
                            Spacer()
                            
                        }
                        
                        HStack {
                            
                            Spacer()
                            
                            CheckBoxView(checked: $creatorIsSelected)
                            Text("Creator")
                            
                            Spacer()
                            
                            CheckBoxView(checked: $businessIsSelected)
                            Text("Business")
                            
                            Spacer()
                            
                            CheckBoxView(checked: $nonProfitIsSelected)
                            Text("Non Profit")
                            
                            Spacer()
                            
                        }
                        .padding(.bottom, 30)
                        
                        // MARK: - Content categories
                        
                        HStack {
                            
                            Text("Content Categories")
                                .font(.system(size: 18, weight: .semibold))
                                .padding(.leading, 30)
                                .padding(.bottom, 10)
                            
                            Spacer()
                            
                        }
                        
                        HStack {
                            
                            // Tag: Art
                            
                            Button(action: {
                                tagsCollection["art"]!.toggle()
                            }, label: {
                                ZStack{
                                    
                                    if tagsCollection["art"]!{
                                        Color(UIColor.green)
                                    } else {
                                        Color(UIColor.red)
                                    }
                                    Text("Art")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16))
                                }
                                .frame(width: 40, height: 25)
                                .cornerRadius(5)
                            })
                            
                            // Tag: Music
                            
                            Button(action: {
                                tagsCollection["music"]!.toggle()
                            }, label: {
                                ZStack{
                                    if tagsCollection["music"]!{
                                        Color(UIColor.green)
                                    } else {
                                        Color(UIColor.red)
                                    }
                                    Text("Music")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16))
                                }
                                .frame(width: 60, height: 25)
                                .cornerRadius(5)
                            })
                            
                        }
                        .padding(.bottom, 30)
                        
                        // MARK: - Instagram
                        
                        VStack {
                            
                            HStack {
                                
                                CheckBoxView(checked: $instagramIsSelected)
                                    .padding(.leading, 30)
                                
                                Text("Instagram")
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Spacer()
                                
                            }
                            
                            if instagramIsSelected {
                                // Stats selection box
                                ZStack{
                                    Color(UIColor.label)
                                    Text("Stats selection box")
                                        .foregroundColor(Color(UIColor.systemBackground))
                                }
                                .frame(height: 100)
                                .cornerRadius(10)
                                .padding(.horizontal)
                                
                            }
                            
                        }
                        .padding(.bottom, 30)
                        
                        // MARK: - YouTube
                        
                        VStack {
                            
                            HStack {
                                
                                CheckBoxView(checked: $youtubeIsSelected)
                                    .padding(.leading, 30)
                                
                                Text("YouTube")
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Spacer()
                                
                            }
                            
                            if youtubeIsSelected {
                                // Stats selection box
                                ZStack{
                                    Color(UIColor.label)
                                    Text("Stats selection box")
                                        .foregroundColor(Color(UIColor.systemBackground))
                                }
                                .frame(height: 100)
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }
                            
                        }
                        .padding(.bottom, 30)
                        
                        // MARK: - TikTok
                        
                        VStack {
                            
                            HStack {
                                
                                CheckBoxView(checked: $tiktokIsSelected)
                                    .padding(.leading, 30)
                                
                                Text("TikTok")
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Spacer()
                                
                            }
                            
                            if tiktokIsSelected {
                                // Stats selection box
                                ZStack{
                                    Color(UIColor.label)
                                    Text("Stats selection box")
                                        .foregroundColor(Color(UIColor.systemBackground))
                                }
                                .frame(height: 100)
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }
                            
                        }
                        
                        // MARK: - Search with filter button
                        
                        NavigationLink(destination: SearchFilterResultsView(filteredSearchManager: filteredSearchManager),
                                       isActive: $showResults,
                                       label: {
                                        
                                        Button(action: {
                                            // Start loading of users
                                            filteredSearchManager.isLoading = true
                                            // Call search function
                                            filteredSearchManager.filterUsers(isCreatorSelected: creatorIsSelected, isBusinessSelected: businessIsSelected, isNonProfitSelected: nonProfitIsSelected, tagsCollection: tagsCollection)
                                            // Show results page
                                            showResults = true
                                            
                                        }, label: {
                                            ZStack {
                                                Color(UIColor.label)
                                                Text("Search with filter")
                                                    .font(.system(size: 16, weight: .semibold))
                                                    .foregroundColor(Color(UIColor.systemBackground))
                                            }
                                            .frame(width: 200, height: 60)
                                            .cornerRadius(30)
                                        })
                                        .padding(30)
                                        
                                       })
                        
                        Spacer()
                        
                    }
                    
                }
                
            }
            .navigationBarHidden(true)
            
        }
        
    }
    
    
}


// MARK: - Preview

struct FilterSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterView()
    }
}
