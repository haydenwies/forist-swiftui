//
//  SearchFilterResultsView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-08-11.
//

import SwiftUI

struct SearchFilterResultsView: View {
    
    @ObservedObject var filteredSearchManager: FilteredSearchManager
    
    var body: some View {
        
        if !filteredSearchManager.isLoading {
            
            ScrollView {
                
                ForEach(filteredSearchManager.users, id: \.userID) {
                    (user) in
                    if user.userID != "" {
                        
                        NavigationLink(destination: SearchProfileView(userData: user), label: {
                           
                            SearchResultView(userData: user)
                                .padding(.horizontal, 35)
                                .padding(.vertical, 15)
                            
                        })
                        
                    }
                    
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            
        } else if !filteredSearchManager.isLoading && filteredSearchManager.users.count == 0 {

            // **** Show "No users match your search criteria" ****
            EmptyView()
                .navigationBarTitleDisplayMode(.inline)
            
        } else {
            
            // Loading
            EmptyView()
                .navigationBarTitleDisplayMode(.inline)
                
        }
        
    }
    
    
}


// MARK: - Preview

struct SearchFilterResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterResultsView(filteredSearchManager: FilteredSearchManager())
    }
}
