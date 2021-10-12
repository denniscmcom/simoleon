//
//  ErrorHandling.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/8/21.
//

import Foundation

class ErrorHandling {
    enum Json: Error {
        case fileMissing
        case loadFailed(cause: String)
        case parseFailed(cause: String)
    }
    
    enum Networking: Error {
        case invalidURL
    }
}
