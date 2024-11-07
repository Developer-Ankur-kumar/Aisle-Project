//
//  OTPView.swift
//  AisleProject
//
//  Created by Ankur Kumar on 05/11/24.
//

import SwiftUI

struct OTPView: View {
    @State private var timer = 59
    @State var noteSheetPresent = false
    @Binding var otpSheetPresent:Bool
    @ObservedObject var otpViewModel = OTPViewModel()
    @StateObject var notesViewModel =  NotesViewModel()
    var phoneNumber: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack{
                Text("+91 \(phoneNumber)")
                    .font(.custom("Inter", size: 18))
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                Image("fluent_edit-24-filled")
                    .resizable()
                    .frame(width: 14,height: 14)
                    .padding(.vertical)
            }
            
            Text("Enter The\nOTP")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.black)
            
            TextField("9999", text: $otpViewModel.otp)
                .font(.system(size: 18, weight: .bold))
                .frame(width: 78,height: 36)
                .multilineTextAlignment(.center)
                .modifier(TextFieldModifier())
            
            
            HStack {
                Button(action: {
                    otpViewModel.phoneNumber = phoneNumber
                    otpViewModel.postOTP { token in
                        notesViewModel.authToken = token // Set the token in the shared NotesViewModel
                        if otpViewModel.isNavigateToNoteScreen {
                            noteSheetPresent.toggle()
                        }
                    }
                    
                }) {
                    Text("Continue")
                        .modifier(ButtonModifier())
                }
                
                Text("\(String(format: "%02d", timer / 60)):\(String(format: "%02d", timer % 60))")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.leading, 10)
            }
            
            Spacer()
        }
        .fullScreenCover(isPresented: $noteSheetPresent){
            ThreadTabView(noteSheetPresent:noteSheetPresent, notesViewModel: notesViewModel)
            //            NotesView(notesViewModel: notesViewModel, noteSheetPresent:$noteSheetPresent)
            
        }
        .padding(.leading, -60)
        .padding(.top, 80)
        .onAppear {
            startTimer()
        }
    }
    
    // Countdown timer function
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timer > 0 {
                self.timer -= 1
            } else {
                timer.invalidate()
            }
        }
    }
}



