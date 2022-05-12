//
//  GenderDictionaryModel.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-20.
//

import Foundation

class GenderDictionaryModel: ObservableObject {
    
    @Published var gender: [String : Bool] = [
        "male" : false,
        "female" : false,
        "nonBinary" : false,
        "transgender" : false,
        "other" : false,
        "preferNotToSay" : false
    ]
        
}
