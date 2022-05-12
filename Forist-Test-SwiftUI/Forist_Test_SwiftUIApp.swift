//
//  Forist_Test_SwiftUIApp.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI
import Firebase

@main
struct Forist_Test_SwiftUIApp: App {
    
    @StateObject var viewRouter = ViewRouter()
        
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MotherView(viewRouter: viewRouter)
        }
    }
    
}
