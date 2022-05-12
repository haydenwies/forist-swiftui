//
//  WebPageView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-08-12.
//

import SwiftUI

struct WebPageView: View {
    
    // For presenting alerts
    @State var alertContents: AlertContents?
    
    @State var showWebView = false
    
    var body: some View {
    
        Button(action: {
            
            if UserDefaults.standard.string(forKey: "webAddress") == nil || UserDefaults.standard.string(forKey: "webAddress")!.isEmpty {
                // Show alert
                alertContents = AlertContents(title: "Error", message: "No web addresse connected to your page, tap options menu on the upper right corner to add one", buttonTitle: "Okay")
            } else {
                showWebView = true
            }
            
        }, label: {

            HStack {
                
                Spacer(minLength: 5)
                
                HStack {
                    
                    Spacer()
                    
                    Image(systemName: "globe")
                        .resizable()
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(width: 25, height: 25)
                        .padding(.vertical)
                        
                    
                    Spacer()
                    
                }
                .clipped()
                .padding()
                .background(Color(UIColor.label))
                .cornerRadius(30)
                
                Spacer(minLength: 10)
                
            }

        })
        .popover(isPresented: $showWebView, content: {
            WebView(url: UserDefaults.standard.string(forKey: "webAddress")!)
        })
        .alert(item: $alertContents) { details in
            Alert(title: Text(alertContents!.title), message: Text(alertContents!.message), dismissButton: .default(Text(alertContents!.buttonTitle)))
        }
        
    }
    
    
}


// MARK: - Preview

struct WebPageView_Previews: PreviewProvider {
    static var previews: some View {
        WebPageView()
    }
}
