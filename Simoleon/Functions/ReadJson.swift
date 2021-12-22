//
//  ReadJson.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 8/12/21.
//

import Foundation

// Read JSON file
func readJson<T: Decodable>(from filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Failed to locate \(filename)")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Failed to load \(filename)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Failed to decode \(filename)")
    }
}
