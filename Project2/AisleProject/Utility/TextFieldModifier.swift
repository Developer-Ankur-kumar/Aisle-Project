//
//  TextFieldModifier.swift
//  AisleProject
//
//  Created by Ankur Kumar on 05/11/24.
//

import SwiftUI

struct TextFieldModifier:ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18))
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            .keyboardType(.numberPad)
    }
    
}

   
