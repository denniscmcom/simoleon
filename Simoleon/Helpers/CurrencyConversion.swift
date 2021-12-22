//
//  CurrencyConversion.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 21/12/21.
//

import SwiftUI

struct CurrencyConversion: View {
    var conversion: CurrencyConversionResponse
    var currencyCode: String
    @Binding var showConversion: Bool
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 60)
                .foregroundColor(Color(.secondarySystemBackground))
                .overlay(
                    VStack {
                        if showConversion {
                            let amount = conversion.message.first!.amount
                            let formattedAmount = format(currency: amount)
                            Text(formattedAmount)
                                .font(.title2)
                        } else {
                            ProgressView()
                        }
                    }
                    .padding(.leading, 15)
                    
                    , alignment: .leading
                )
            
            if showConversion {
                let timestamp = conversion.message.first!.timestamp
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
    
    // COnvert epoch to date
    private func converToDate(epoch: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let date = Date(timeIntervalSince1970: TimeInterval(epoch/1000))
        
        return dateFormatter.string(from: date)
    }
}

struct CurrencyConversion_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyConversion(
            conversion:
                CurrencyConversionResponse(
                    message: [
                        CurrencyConversionResult(
                            rate: 1.31,
                            timestamp: 1288282222000,
                            amount: 95.63
                        )
                    ]
                ),
            currencyCode: "CHF",
            showConversion: .constant(true)
        )
    }
}
