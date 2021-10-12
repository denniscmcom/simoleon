//
//  Request.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 20/07/2021.
//

import Foundation

class NetworkHelper {
    func httpRequest<T: Decodable>(url: String, model: T.Type, completion: @escaping (_ result: T) -> Void) throws {
        // We take some model data T.Type
        guard let url = URL(string: url) else { throw ErrorHandling.Networking.invalidURL }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    // Decode response with the model passed
                    let decodedResponse = try JSONDecoder().decode(model, from: data)
                    DispatchQueue.main.async {
                        completion(decodedResponse)
                    }
                    return
                } catch {
                    // Return error regarding the escaping code
                    print(error)
                }
            }
            // Error with the request
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }
}
