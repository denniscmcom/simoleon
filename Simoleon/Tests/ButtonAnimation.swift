//
//  ButtonAnimation.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 28/8/21.
//

import SwiftUI

struct ButtonAnimation: View {
    @State private var scale: CGFloat = 1
    
    var body: some View {
        Button("Press here", action: animate)
            .scaleEffect(scale)
            .animation(.easeIn, value: scale)
    }
    
    private func animate() {
        scale += 0.2
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            scale -= 0.2
        }
    }
}

struct ButtonAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ButtonAnimation()
    }
}
