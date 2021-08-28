////
////  ConversionBox.swift
////  Simoleon
////
////  Created by Dennis Concepción Martín on 18/07/2021.
////
//
//import SwiftUI
//
//struct ConversionBox: View {
//    var currencyDetails: CurrencyDetailsModel
//    @State var currencyPair: CurrencyPairModel
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("\(baseName) (\(currencyPair.baseSymbol))")
//                .font(.callout)
//                .fontWeight(.semibold)
//                .padding(.top, 40)
//            
//            ZStack(alignment: .trailing) {
//                TextField("Enter amount", text: $amount) { startedEditing in
//                    if startedEditing {
//                        withAnimation {
//                            amountIsEditing = true
//                        }
//                    }
//                }
//                onCommit: {
//                    withAnimation {
//                        amountIsEditing = false
//                    }
//                }
//                .keyboardType(.decimalPad)
//                .font(Font.title.weight(.semibold))
//                .lineLimit(1)
//                .accessibilityIdentifier("ConversionTextField")
//            }
//            
//            Divider()
//
//            let quoteName = currencyDetails[currencyPair.quoteSymbol]!.name
//            Text("\(quoteName) (\(currencyPair.quoteSymbol))")
//                .font(.callout)
//                .fontWeight(.semibold)
//                .padding(.top, 10)
//            
//            if showingConversion {
//                Text("\(makeConversion(), specifier: "%.2f")")
//                    .font(Font.title.weight(.semibold))
//                    .lineLimit(1)
//                    .padding(.top, 5)
//            } else {
//                ProgressView()
//                    .padding(.top, 5)
//            }
//        }
//        .onAppear(perform: request)
//    }
//    
//    /*
//     if the amount can be converted to Double:
//     * Return amount
//     else:
//     * Return zero
//     */
//    func makeConversion() -> Double {
//        if let amountToConvert = Double(amount) {
//            return amountToConvert * price  // Conversion
//        } else {
//            return 0
//        }
//    }
//}
//
//
//struct ConversionBox_Previews: PreviewProvider {
//    static var previews: some View {
//        let fileController = File()
//        let currencyDetails: [String: CurrencyDetailsModel] = try! fileController.read(json: "CurrencyDetails.json")
//        ConversionBox(currencyPair: CurrencyPair(), currencyDetails: currencyDetails)
//    }
//}
