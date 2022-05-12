//
//  AlertModel.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-20.
//

import Foundation

struct AlertContents: Identifiable {
    
    var id = UUID()
    var title: String = ""
    var message: String = ""
    var buttonTitle: String = ""
    
}
