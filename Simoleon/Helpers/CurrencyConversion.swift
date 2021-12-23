//
//  CurrencyConversion.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 21/12/21.
//

import SwiftUI

struct CurrencyConversion: View {
    var latestRate: CurrencyLatestRateResponse
    var currencyCode: String
    @Binding var amount: String
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 60)
                .foregroundColor(Color(.secondarySystemBackground))
                .overlay(
                    VStack {
                        if latestRate.message.isEmpty {
                            ProgressView()
                        } else {
                            let conversion = convert(amount: amount)
                            let formattedAmount = format(currency: conversion)
                            Text(formattedAmount)
                                .font(.title2)
                        }
                    }
                    .padding(.leading, 15)
                    
                    , alignment: .leading
                )
            
            if !latestRate.message.isEmpty {
                let timestamp = latestRate.message.first!.timestamp
                Text("Last updated: \(converToDate(epoch: timestamp))")
                    .font(.caption)
                    .opacity(0.6)
            }
        }
    }
    
    // Format conversion to specific currency format
    private func format(currency: Double) -> String {
        let formatter = NumberFormatter()
        formatter.currencyCode = currencyCode
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: currency))!
    }
    
    // Convert epoch to date
    private func converToDate(epoch: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let date = Date(timeIntervalSince1970: TimeInterval(epoch/1000))
        
        return dateFormatter.string(from: date)
    }
    
    // Compute conversion
    private func convert(amount: String) -> Double {
        guard let amount = Double(amount) else {
            return Double()
        }
        
        let rate = latestRate.message.first!.rate
        let conversion = amount * rate
        
        return conversion
    }
}

struct CurrencyConversion_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyConversion(
            latestRate:
                CurrencyLatestRateResponse(
                    message: [
                        CurrencyLatestRateResult(
                            rate: 1.31,
                            timestamp: 1288282222000
                        )
                    ]
                ),
            currencyCode: "CHF",
            amount: .constant("1")
        )
    }
}
