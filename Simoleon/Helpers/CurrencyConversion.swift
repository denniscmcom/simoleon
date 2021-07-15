//
//  CurrencyConversion.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI
import Alamofire

struct CurrencyConversion: View {
    var currency: String
    @State private var price: Double = 1.00
    @State private var amountToConvert = "100"
    @State private var isEditing = false
    @State private var showConversion = false
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        let currencies = currency.components(separatedBy: "/")
        let mainCurrency = String(currencies[0])
        let secondaryCurrency = String(currencies[1])
        
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ZStack {
                    Rectangle()
                       .foregroundColor(Color(.secondarySystemBackground))
                    
                    HStack {
                        Image(currencyMetadata[mainCurrency]!.flag)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(.systemGray), lineWidth: 1))
                        
                        TextField("Amount", text: $amountToConvert) { startedEditing in
                            if startedEditing {
                                withAnimation {
                                    isEditing = true
                                }
                            }
                        }
                        onCommit: {
                             withAnimation {
                                isEditing = false
                             }
                         }
                        .keyboardType(.decimalPad)
                        .lineLimit(1)
                        .padding(.horizontal)
                        
                        Text("\(mainCurrency)")
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal)
                }
                .frame(height: 50)
                .cornerRadius(13)
                
                ZStack {
                    Rectangle()
                       .foregroundColor(Color(.secondarySystemBackground))
                    
                    HStack {
                        Image(currencyMetadata[secondaryCurrency]!.flag)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(.systemGray), lineWidth: 1))
                        
                        if showConversion {
                            Text("\(makeConversion(), specifier: "%.4f")")
                                .lineLimit(1)
                                .padding(.horizontal)
                        } else {
                            ProgressView()
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                        Text("\(secondaryCurrency)")
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal)
                }
                .frame(height: 50)
                .cornerRadius(13)
                
                if showConversion {
                    Text("From \(currencyMetadata[mainCurrency]!.name) to \(currencyMetadata[secondaryCurrency]!.name) at \(price, specifier: "%.4f") exchange rate.")
                        .multilineTextAlignment(.center)
                }
                
            }
            .padding()
        }
        .onAppear { requestApi(mainCurrency, secondaryCurrency) }
        .navigationTitle("Conversion")
    }
    
    private func makeConversion() -> Double {
        if amountToConvert.isEmpty {  /// Avoid nil error when string is empty
            return 0
        } else {
            let conversion = Double(amountToConvert)!  * price

            return conversion
        }
    }
    
    private func requestApi(_ mainCurrency: String, _ secondaryCurrency: String) {
        let url = "https://api.simoleon.app/quotes=\(mainCurrency)-\(secondaryCurrency)"
        AF.request(url).responseDecodable(of: [CurrencyQuoteModel].self) { response in
            if let currencyQuotes = response.value {
                if let price = currencyQuotes[0].price {
                    self.price = price
                }
                self.showConversion = true
            } else {
//               Handle error
            }
        }
    }
}

struct CurrencyConversion_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CurrencyConversion(currency: "USD/GBP")
        }
    }
}
