//
//  CheckBoxView.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-23.
//

import SwiftUI

struct CheckBoxView: View {
    
    @Binding var checked: Bool

        var body: some View {
            
            Image(systemName: checked ? "circle.fill" : "circle")
                .foregroundColor(checked ? Color(UIColor.label) : Color(UIColor.systemGray))
                .onTapGesture {
                    self.checked.toggle()
                }
            
        }
    
    
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(checked: .constant(true))
    }
}
