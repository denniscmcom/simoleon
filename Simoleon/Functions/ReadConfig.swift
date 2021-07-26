//
//  ReadConfig.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 20/07/2021.
//

import SwiftUI

func readConfig(_ key: String) -> String? {
    return (Bundle.main.infoDictionary?[key] as? String)?
        .replacingOccurrences(of: "\\", with: "")
}
