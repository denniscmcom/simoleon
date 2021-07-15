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
    @State private var price: Float = 1
    @State private var amountToConvert = "100"
    @State private var isEditing = false
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
                        
                        Text("\(makeConversion(), specifier: "%.2f")")
                            .padding(.horizontal)
                        
                        Spacer()
                        Text("\(secondaryCurrency)")
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal)
                }
                .frame(height: 50)
                .cornerRadius(13)
                
                Text("From \(currencyMetadata[secondaryCurrency]!.name) to \(currencyMetadata[mainCurrency]!.name) at \(price, specifier: "%.2f") exchange rate.")
                    .multilineTextAlignment(.center)
                
            }
            .padding()
        }
        .onAppear { requestApi(mainCurrency, secondaryCurrency) }
        .navigationTitle("Conversion")
    }
    
    private func makeConversion() -> Float {
        if amountToConvert.isEmpty {  /// Avoid nil error when string is empty
            return 0
        } else {
            let conversion = Float(amountToConvert)!  * price

            return conversion
        }
    }
    
    private func requestApi(_ mainCurrency: String, _ secondaryCurrency: String) {
        let url = "https://api.simoleon.app/quotes=\(mainCurrency)-\(secondaryCurrency)"
        AF.request(url).responseDecodable(of: [CurrencyQuoteModel].self) { response in
            if let price = response.value![0].price {
                self.price = price
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
