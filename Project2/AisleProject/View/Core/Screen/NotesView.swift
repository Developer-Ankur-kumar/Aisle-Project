//
//  NotesView.swift
//  AisleProject
//
//  Created by Ankur Kumar on 05/11/24.
//

import SwiftUI

struct NotesView: View {
    @StateObject var notesViewModel = NotesViewModel()
    @Binding var noteSheetPresent:Bool
    let columns:[GridItem] = [GridItem(.flexible()),
                              GridItem(.flexible())]
    var body: some View {
        ScrollView {
            VStack{
                // Invites Section
                if let invites = notesViewModel.notesData?.invites {
                    VStack(alignment: .center,spacing: 10){
                        Text("Notes")
                            .font(.system(size: 28, weight: .bold))
                        
                            .font(.largeTitle)
                            .foregroundColor(.black)
                        Text("Personal Message to you")
                            .font(.custom("Gilroy", size: 18))
                            .foregroundColor(.black)
                        
                    }
                    ForEach(invites.profiles ?? [], id: \.generalInformation?.refID) { profile in
                        InvitesProfileView(profile: profile)
                    }
                }
                
                // Likes Section
                LazyVGrid(columns:columns){
                    if let likes = notesViewModel.notesData?.likes {
                        ForEach(likes.profiles ?? [], id: \.firstName) { profile in
                            HStack(alignment: .center){
                                LikesProfileView(profile: profile)
                            }
                        }
                    }
                }
            }
            .task {
                notesViewModel.getNotesDetails(token: notesViewModel.authToken)
            }
        }
        
    }
    
}

struct InvitesProfileView: View {
    let profile: InvitesProfile
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if let photos = profile.photos, let firstPhoto = photos.first, let photoUrl = firstPhoto.photo {
                AsyncImage(url: URL(string: photoUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 344, height: 344)
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }
            }
            
            HStack{
                VStack(alignment: .leading){
                    if let generalInfo = profile.generalInformation {
                        Text(generalInfo.firstName ?? "Unknown")
                            .font(.headline)
                        
                        Text("Age: \(generalInfo.age ?? 0)")
                        Text("Location: \(generalInfo.location?.summary ?? "Not Available")")
                        
                        if let work = profile.work?.industryV1 {
                            Text("Industry: \(work.name ?? "Not Available")")
                        }
                    }
                }
                
                Button {
                    
                } label: {
                    Text("Upgrade")
                        .modifier(ButtonModifier())
                }
            }
        }
    }
}

struct LikesProfileView: View {
    let profile: LikesProfile
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if let avatarUrl = profile.avatar {
                AsyncImage(url: URL(string: avatarUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 168, height: 255)
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }
            }
            
            VStack {
                Spacer()
                Text(profile.firstName ?? "Unknown")
                    .font(.footnote)
                    .foregroundColor(.white)
            }
        }
    }
}

