//
//  PhoneNumberViewModel.swift
//  AisleProject
//
//  Created by Ankur Kumar on 05/11/24.
//

import Foundation

class PhoneNumberViewModel: ObservableObject {
    @Published var phoneNumber :String = String()
    @Published var isNavigateToOTPScreen = false
    @Published var otpSheetPresent = false

    
    func postMobileNumber() {
        let parameter = ["number": "+91\(phoneNumber)"]
        
        APIManager.shared.postRequest(request: APIRequest.loginEndpoint, body: parameter) { result in
            switch result {
            case .success(let data):
                print("Mobile Number :", String(data: data, encoding: .utf8) ?? "No readable data")
                
                do {
                    let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.isNavigateToOTPScreen = decodedResponse.status
                        self.otpSheetPresent = decodedResponse.status
                        if !decodedResponse.status {
                            print("Error: \(decodedResponse.message ?? "Invalid phone number")")
                        }
                    }
                } catch {
                    print("Decoding error:", error)
                    DispatchQueue.main.async {
                        self.isNavigateToOTPScreen = false
                    }
                }
                
            case .failure(let error):
                print("Request failed with error:", error)
                DispatchQueue.main.async {
                    self.isNavigateToOTPScreen = false
                }
            }
        }
    }
}



