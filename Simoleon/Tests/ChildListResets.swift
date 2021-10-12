//
//  ModalSheetSelection.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 26/8/21.
//

import SwiftUI

struct ParentView: View {
    @State var selection: Int = 1
    @State private var showingList = false
    
    var body: some View {
        VStack {
            Button("Show list", action: {showingList = true})
                .sheet(isPresented: $showingList) {
                    ModalSheetSelection(selection: $selection)
                }
            
            Text("My first var is: \(selection)")
        }
    }
}

struct ModalSheetSelection: View {
    @Binding var selection: Int
    
    var body: some View {
        NavigationView {
            List {
                SearchBar(placeholder: "", text: .constant(""))
                ForEach((1..<100), id: \.self) { number in
                    Button(action: {selection = number}) {
                        Text("\(number)")
                    }
                }
            }
            .id(UUID())
            .navigationTitle("Currencies")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
