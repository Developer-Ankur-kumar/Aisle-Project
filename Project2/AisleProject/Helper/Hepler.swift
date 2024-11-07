//
//  Hepler.swift
//  AisleProject
//
//  Created by Ankur Kumar on 05/11/24.
//

import Foundation


struct APIRequest {
    static let baseURL = "https://app.aisle.co/V1"
    static let loginEndpoint = "/users/phone_number_login"
    static let otpEndpoint = "/users/verify_otp"
    static let notesEndpoint = "/users/test_profile_list"
}

enum APIError:Error{
    case invalidURL
    case requestFaild
    case DecodingError
    case EncodingError
}

struct APIResponse: Codable {
    let status: Bool
    let message: String?
}
