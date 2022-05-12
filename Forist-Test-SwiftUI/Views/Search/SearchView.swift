//
//  SearchView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct SearchView: View {
    
    // Passed to tab bar
    @ObservedObject var viewRouter: ViewRouter
    
    // Used  for toggling tab bar when clicking on user profile
    @ObservedObject var toggleVariables: ToggleVariablesModel
    
    // For managing search functionality
    @ObservedObject var searchManager = SearchManager()
    
    // Holds value contained in search bar
    @State var searchValue = ""
    
    @State var showFilterPage = false
    
    init(toggleVariables: ToggleVariablesModel, viewRouter: ViewRouter) {
        
        self.toggleVariables = toggleVariables
        self.viewRouter = viewRouter
        
        // Cosmetic configuration for navigation bar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor.systemBackground
        navBarAppearance.shadowColor = UIColor.clear
        UINavigationBar.appearance().tintColor = UIColor.label
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
    }
    
    // Search user from search bar
    func directSearchUser() {
        searchManager.isLoading = true
        searchManager.directSearchUser(input: searchValue)
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // MARK: - Search bar
                
                SearchBarView(value: $searchValue)
                    .padding(.vertical, 20)
                    .onChange(of: searchValue) { result in
                        directSearchUser()
                    }
                
                // MARK: - Filter search button
                
                if searchValue == "" {
                    
                    VStack(spacing: 25) {
                        HStack {
                            
                            Color(UIColor.label)
                                .frame(width: 100, height: 1)
                            
                            Text("or")
                                .padding(.horizontal, 5)
                                .padding(.bottom, 4)
                            
                            Color(UIColor.label)
                                .frame(width: 100, height: 1)
                            
                        }
                        Button(action: {
                            // Present filter search sheet
                            showFilterPage = true
                        }, label: {
                            ZStack {
                                Color(UIColor.label)
                                Text("Filter search")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(Color(UIColor.systemBackground))
                            }
                            .frame(width: 160, height: 50)
                            .cornerRadius(30)
                        })
                        .fullScreenCover(isPresented: $showFilterPage) {
                            SearchFilterView()
                        }
                    }
                    
                    Spacer()
                    
                }
                
                // MARK: - Empty space when typing
                
                if searchManager.isLoading {
                    
                    Spacer()
                    
                }
                
                // MARK: - Search results
                
                if !searchManager.isLoading {
                    
                    ScrollView {
                        
                        ForEach(searchManager.userModel, id: \.userID) {
                            
                            user in
                            
                            if user.userID != "" {
                                
                                NavigationLink(destination: EmptyView(), label: {})
                                
                                ZStack {
                                    
                                    NavigationLink(destination: SearchProfileView(userData: user), label: {
                                        
                                        SearchResultView(userData: user)
                                            .padding(.horizontal, 35)
                                            .padding(.vertical, 15)
                                        
                                    })
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                // MARK: - Tab bar
                TabBarView(viewRouter: viewRouter, toggleVariables: toggleVariables)
                
            }
            .navigationBarHidden(true)
            
        }
        
    }
    
    
}


// MARK: - Preview

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(toggleVariables: ToggleVariablesModel(), viewRouter: ViewRouter())
    }
}
