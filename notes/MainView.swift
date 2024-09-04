//
//  MenuView.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import Foundation
import SwiftUI
import CoreLocation

struct MainView: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        TabView {
            UsersListView()
                .environmentObject(locationManager)
                .environmentObject(dataManager)
                .tabItem {
                    Label("Users", systemImage: "person.3")
                }
            
            NoteScreen()
                .environmentObject(locationManager)
                .environmentObject(dataManager)
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                }
            
            MapScreen(latitude: locationManager.latitude, longitude: locationManager.latitude)
                .environmentObject(locationManager)
                .environmentObject(dataManager)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}
