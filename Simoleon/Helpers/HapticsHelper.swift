//
//  SimpleSuccess.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 20/07/2021.
//

import SwiftUI

class HapticsHelper {
    
    // MARK: - Simple success
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
