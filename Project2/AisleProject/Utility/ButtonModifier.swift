//
//  ViewModifier.swift
//  AisleProject
//
//  Created by Ankur Kumar on 05/11/24.
//

import SwiftUI

struct ButtonModifier:ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.black)
            .frame(width: 96,height: 40)
            .background(Color.yellow)
            .cornerRadius(20)
    }
}
