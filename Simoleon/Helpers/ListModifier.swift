//
//  ListModifier.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 31/7/21.
//

import SwiftUI

struct ListModifier: ViewModifier {
    func body(content: Content) -> some View {
            content
                .id(UUID())
                .listStyle(PlainListStyle())
                .gesture(DragGesture()
                            .onChanged({ _ in
                                UIApplication.shared.dismissKeyboard()
                            })
                )
        }
}
