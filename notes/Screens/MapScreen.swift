//
//  MapScreen.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var locationManager: LocationManager
    @State private var region: MKCoordinateRegion
    @State private var appeared: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if !dataManager.notes.isEmpty {
                    Map(coordinateRegion: $region, annotationItems: dataManager.notes) { note in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(note.latitude), longitude: Double(note.longitude))) {
                            NavigationLink {
                                NoteDetailView(note: note)
                                    .environmentObject(dataManager)
                                    .environmentObject(locationManager)
                            } label: {
                                VStack {
                                    Image(systemName: note.image?.text ?? "mappin.circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.red)
                                    Text(note.title)
                                        .font(.caption)
                                        .padding(5)
                                        .background(Color.white)
                                        .foregroundColor(Color.black)
                                        .cornerRadius(5)
                                        .shadow(radius: 5)
                                }
                            }
                        }
                    }
                } else {
                    VStack {
                        Text("No notes found")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
            }
            .navigationTitle("Notes Map")
            .onChange(of: locationManager.location) {
                if !appeared {
                    updateRegion()
                    appeared.toggle()
                }
            }
        }
    }
    
    init(latitude: CGFloat, longitude: CGFloat) {
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), // Default to San Francisco
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        ))
    }
    
    private func updateRegion() {
        let center = CLLocationCoordinate2D(latitude: Double(locationManager.latitude), longitude: Double(locationManager.longitude))
            region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
}
