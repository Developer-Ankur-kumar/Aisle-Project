//
//  ContentView.swift
//  AisleProject
//
//  Created by Ankur Kumar on 05/11/24.
//

import SwiftUI

struct PhoneView: View {
    @ObservedObject var phoneNumberViewModel = PhoneNumberViewModel()
    @ObservedObject var notesViewModel = NotesViewModel()
    
    var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("Get OTP")
                    .font(.custom("Inter", size: 18))
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                Text("Enter Your\nPhone Number")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)
                
                HStack(spacing: 10) {
                    TextField("+91", text: .constant("+91"))
                        .font(.system(size: 18, weight: .bold))
                        .frame(width: 64, height: 36)
                        .multilineTextAlignment(.center)
                        .modifier(TextFieldModifier())
                        .disabled(true)
                    
                    TextField("9999999999", text: $phoneNumberViewModel.phoneNumber)
                        .font(.system(size: 18, weight: .bold))
                        .frame(width: 147,height: 36)
                        .padding(.leading, 10)
                        .modifier(TextFieldModifier())
                    
                }
                Button{
                    phoneNumberViewModel.postMobileNumber()
//                        otpSheetPresent.toggle()
                    
                } label: {
                    Text("Continue")
                        .modifier(ButtonModifier())
                }
                .disabled(phoneNumberViewModel.phoneNumber.isEmpty)
            }
            .padding(.leading, -60)
            .padding(.top, 80)
            Spacer()
            .fullScreenCover(isPresented: $phoneNumberViewModel.otpSheetPresent){
                OTPView(otpSheetPresent: $phoneNumberViewModel.otpSheetPresent, notesViewModel: notesViewModel, phoneNumber:phoneNumberViewModel.phoneNumber)
                    .padding(.leading, -60)
            .padding(.top, 30)
        }
    }
}

