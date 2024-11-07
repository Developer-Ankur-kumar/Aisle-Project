//
//  TabView.swift
//  AisleProject
//
//  Created by Ankur Kumar on 07/11/24.
//

import SwiftUI

struct ThreadTabView: View {
    
    @State private var selectedTab = 1
    @State var noteSheetPresent = false
    @StateObject var notesViewModel =  NotesViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DiscoverProfile()
                .tabItem {
                    VStack{
                        Image(systemName: selectedTab == 0  ? "square.grid.3x3.fill": "square.grid.3x3.fill" )
                            .environment(\.symbolVariants,selectedTab == 0 ? .fill : .none)
                        Text("Discover")
                        
                    }
                }
                .onAppear{selectedTab = 0}
                .tag(0)
            
            NotesView(notesViewModel: notesViewModel, noteSheetPresent:$noteSheetPresent)
                .tabItem {
                    VStack{
                        Image(systemName: selectedTab == 1 ? "envelope.badge" : "envelope.badge")
                        Text("Notes")
                    }
                }
                .onAppear{selectedTab = 1}
                .tag(1)
            
            MatcheProfile()
                .tabItem {
                    VStack{
                        Image(systemName: selectedTab == 2 ? "message": "message")
                            .environment(\.symbolVariants,selectedTab == 2 ? .fill : .none)
                        Text("matches")
                    }
                    
                }
                .onAppear{selectedTab = 2}
                .tag(2)
            
            UserProfile()
                .tabItem {
                    VStack{
                        Image(systemName: selectedTab == 3 ? "person" : "person")
                            .environment(\.symbolVariants,selectedTab == 3 ? .fill : .none)
                        Text("Profile")
                    }
                    
                }
                .onAppear{selectedTab = 3}
                .tag(3)
        }
    }
}



#Preview {
    ThreadTabView()
}

struct DiscoverProfile: View {
    var body: some View {
        Text("DiscoverProfile")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct MatcheProfile: View {
    var body: some View {
        Text("MatcheProfile")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct UserProfile: View {
    var body: some View {
        Text("UserProfile")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}
