//
//  LoadView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-14.
//

import SwiftUI

struct LoadView: View {
    
    // For navigating to profile
    @StateObject var viewRouter: ViewRouter
    
    // Timer for load
    @State var timeRemaining = 1
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        Text("Loading")
            .onReceive(timer) { _ in
                       if self.timeRemaining > 0 {
                           self.timeRemaining -= 1
                       } else {
                           viewRouter.currentPage = .profile
                       }
            }
        
    }
    
}


// MARK: - Preview

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView(viewRouter: ViewRouter())
    }
}
