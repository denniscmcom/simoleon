//
//  File.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 26/8/21.
//

import Foundation


func readJson<T: Decodable>(from filename: String) throws -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        throw ErrorHandling.Json.fileMissing
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        throw ErrorHandling.Json.loadFailed(cause: error.localizedDescription)
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        throw ErrorHandling.Json.parseFailed(cause: error.localizedDescription)
    }
}

func readConfig(withKey: String) -> String? {
    return (Bundle.main.infoDictionary?[withKey] as? String)?
        .replacingOccurrences(of: "\\", with: "")
}
