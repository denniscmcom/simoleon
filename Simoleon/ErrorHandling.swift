//
//  ErrorHandling.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/8/21.
//

import Foundation

enum JsonErrors: Error {
    case fileMissing
    case loadFailed(cause: String)
    case parseFailed(cause: String)
}
