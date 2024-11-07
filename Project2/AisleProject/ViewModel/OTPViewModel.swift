//
//  OTPViewModel.swift
//  AisleProject
//
//  Created by Ankur Kumar on 05/11/24.
//

import Foundation

class OTPViewModel:ObservableObject{
    
    @Published var phoneNumber = ""
    @Published var otp :String = ""
    @Published var authToken:String? = nil
    @Published var isNavigateToNoteScreen = false
    @Published var timer = 59

    
    func postOTP(completion: @escaping (String?) -> Void) {
        let parameter = ["number": "+91\(phoneNumber)",
                         "otp": otp]
        
        APIManager.shared.postRequest(request: APIRequest.otpEndpoint, body: parameter) { result in
            switch result {
            case .success(let data):
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw response: \(jsonString)") 
                }
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let token = json["token"] as? String {
                        DispatchQueue.main.async {
                            self.authToken = token
                            self.isNavigateToNoteScreen = true
                            completion(token)
                        }
                    } else {
                        print("No token found in response.")
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                }
            case .failure(let error):
                print("Request failed with error:", error)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
}



    

