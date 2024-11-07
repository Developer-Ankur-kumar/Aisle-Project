//
//  NotesViewModel.swift
//  AisleProject
//
//  Created by Ankur Kumar on 06/11/24.
//

import Foundation


class NotesViewModel:ObservableObject{
    
    @Published var authToken:String?
    @Published var notesData: NotesData?
    
    func getNotesDetails(token: String?) {
           guard let token = token else {
               print("No auth token available")
               return
           }

           APIManager.shared.getRequest(endpoint: APIRequest.notesEndpoint, authToken: token) { result in
               switch result {
               case .success(let data):
                   // Print the raw JSON data for debugging
                   if let jsonString = String(data: data, encoding: .utf8) {
                       print("Raw JSON: \(jsonString)")
                   }

                   do {
                       // Decode the NotesData object
                       let decodedData = try JSONDecoder().decode(NotesData.self, from: data)
                       DispatchQueue.main.async {
                           self.notesData = decodedData
                           print("Successfully decoded notes data: \(decodedData)")
                       }
                   } catch {
                       print("Failed to decode NotesData: \(error)")
                   }
                   
               case .failure(let error):
                   print("Error: \(error)")
               }
           }
       }
}
