//
//  AboutView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        Form {
            Section(header: Text("Feedback")) {
                Link(destination: URL(string: "https://itunes.apple.com/app/id1576390953?action=write-review")!) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color(.systemRed))
                            .imageScale(.large)

                        Text("Rate Simoleon")
                    }
                }
            }
            
            Section(header: Text("Stay in touch")) {
                Link(destination: URL(string: "https://twitter.com/dennisconcep")!) {
                    HStack {
                        Image("TwitterLogo")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        Text("Developer's Twitter")
                    }
                }
                
                Link(destination: URL(string: "https://dennistech.io/contact")!) {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color(.systemIndigo))
                            .imageScale(.large)
                        
                        Text("Contact")
                    }
                }
            }
            
            Section(header: Text("Information")) {
                Link(destination: URL(string: "https://dennistech.io")!) {
                    Text("Website")
                }
                
                Link(destination: URL(string: "https://dennistech.io/simoleon-privacy-policy")!) {
                    Text("Privacy Policy")
                }
                
                Link(destination: URL(string: "https://dennistech.io/simoleon-terms-of-use")!) {
                    Text("Terms of Use")
                }
            }
        }
        .navigationTitle("About")
        .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
            NavigationView { content }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
