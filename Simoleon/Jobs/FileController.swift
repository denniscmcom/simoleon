//
//  ReadConfig.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 20/07/2021.
//

import Foundation

class FileController {
    
    /*
     Read configuration variables from Config.xconfig
     */
    func readConfigVariable(withKey: String) -> String? {
        return (Bundle.main.infoDictionary?[withKey] as? String)?
            .replacingOccurrences(of: "\\", with: "")
    }
    
    /*
     Decode and read json file
     */
    func read<T: Decodable>(json filename: String) throws -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            throw JsonErrors.fileMissing
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            throw JsonErrors.loadFailed(cause: error.localizedDescription)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw JsonErrors.parseFailed(cause: error.localizedDescription)
        }
    }
}
