////
////  Sidebar.swift
////  Simoleon
////
////  Created by Dennis Concepción Martín on 18/07/2021.
////
//
//import SwiftUI
//
//struct Sidebar: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(sortDescriptors: []) private var defaultCurrency: FetchedResults<DefaultCurrency>
//    
//    var body: some View {
//        List {
//            NavigationLink(destination: Conversion()) {
//                Label("Convert", systemImage: "arrow.counterclockwise.circle")
//            }
//            .accessibilityIdentifier("NavigateToConversion")
//            
//            NavigationLink(destination: Favorites()) {
//                Label("Favorites", systemImage: "star")
//            }
//            .accessibilityIdentifier("NavigateToFavorites")
//            
//            NavigationLink(destination: Settings()) {
//                Label("Settings", systemImage: "gear")
//            }
//            .accessibilityIdentifier("NavigateToSettings")
//        }
//        .listStyle(SidebarListStyle())
//        .navigationTitle("Categories")
//        .accessibilityIdentifier("Sidebar")
//    }
//}
//
//struct Sidebar_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            Sidebar()
//        }
//    }
//}
