//
//  APIManager.swift
//  AisleProject
//
//  Created by Ankur Kumar on 05/11/24.
//

import Foundation

final class APIManager{
    static let shared = APIManager()
    private init(){}
    
    //Post API
    func postRequest<T: Encodable>(request: String, body: T, completion: @escaping (Result<Data, APIError>) -> Void) {
            guard let url = URL(string: APIRequest.baseURL + request) else {
                completion(.failure(.invalidURL))
                return
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                completion(.failure(.EncodingError))
                return
            }
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data else{
                    return
                }
                
                if error != nil {
                    completion(.failure(.requestFaild))
                } else {
                    completion(.success(data))
                    print("response data:", String(data: data, encoding: .utf8) ?? "No readable data")

                }
            }.resume()
        }
    
    //Get API
     func getRequest(endpoint: String, authToken: String, completion: @escaping (Result<Data, Error>) -> Void) {
         guard let url = URL(string: APIRequest.baseURL + endpoint) else { return }
           
           var request = URLRequest(url: url)
           request.httpMethod = "GET"
           request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
           
           URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   completion(.failure(error))
               } else {
                   completion(.success(data ?? Data()))
               }
           }.resume()
       }
    
    
    }
