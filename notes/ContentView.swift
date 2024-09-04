//
//  ContentView.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import SwiftUI
import FirebaseAuth
struct ContentView: View {
    @ObservedObject var dataManager = DataManager()
    @ObservedObject private var locationManager = LocationManager()
    @State private var loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
    
    var body: some View {
        VStack {
            if dataManager.isLoggedIn {
                NavigationView {
                    MainView()
                        .environmentObject(dataManager)
                        .environmentObject(locationManager)
                }
            } else {
                AuthScreen(hasLoggedIn: dataManager.hasLoggedInBefore)
                    .environmentObject(dataManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
