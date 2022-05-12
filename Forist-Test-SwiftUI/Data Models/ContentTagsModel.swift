//
//  ContentTagsModel.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-22.
//

import Foundation

class ContentTagsModel: ObservableObject {
    
    @Published var contentTags = [
        "music": false,
        "art" : false
    ]
    
}
