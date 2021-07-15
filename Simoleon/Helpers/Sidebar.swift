//
//  Sidebar.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 14/07/2021.
//

import SwiftUI

struct Sidebar: View {
    @Binding var selectedView: String?
    
    var body: some View {
        List {
            NavigationLink(destination: ContentView(), tag: "Currencies", selection: $selectedView) {
                Text("Currencies")
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(selectedView: .constant(""))
    }
}
