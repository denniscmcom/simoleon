//
//  AppDelegate.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 31/7/21.
//

import SwiftUI
import Purchases

// Add an AppDelegate to a SwiftUI app
class AppDelegate: NSObject, UIApplicationDelegate, PurchasesDelegate {
    
    // Set delegate to Purchases
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        Purchases.shared.delegate = self
        return true
    }
    
    // Handle purchases started on the App Store
    func purchases(
        _ purchases: Purchases,
        shouldPurchasePromoProduct product: SKProduct,
        defermentBlock makeDeferredPurchase: @escaping RCDeferredPromotionalPurchaseBlock
    ) {
        makeDeferredPurchase { (transaction, purchaserInfo, error, userCancelled) in
            if purchaserInfo?.entitlements["all"]?.isActive == true {
                print("Subscription purchased from App Store")
            }
        }
    }
}
