//
//  SimpleSuccess.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 20/07/2021.
//

import SwiftUI

class HapticsController {
    
    /*
     Default haptic for success action
     */
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
