//
//  NotesListView.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import SwiftUI

struct NoteScreen: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var isPresentingNewNote = false
    @State private var error: Bool = false
    @State private var message: String = ""
    
    var body: some View {
        NavigationView {
                VStack {
                    if dataManager.notes.isEmpty {
                        VStack {
                            Text("No notes found")
                                .font(.title)
                                .foregroundColor(.gray)
                            Text("Tap the '+' button to create a new note.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                    } else {
                        List {
                            ForEach(dataManager.notes) { note in
                                NavigationLink {
                                    NoteDetailView(note: note)
                                        .environmentObject(dataManager)
                                        .environmentObject(locationManager)
                                } label: {
                                    HStack (alignment: .center){
                                        if let image = note.image {
                                            Image(systemName: image.text)
                                        }
                                        VStack(alignment: .leading) {
                                            Text(note.title)
                                                .font(.headline)
                                            Text(note.content)
                                                .lineLimit(2)
                                                .padding(.bottom)
                                            Text(note.date, style: .date)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteNotes)
                        }
                    }
                }
                .presentPopup(message, type: .error, isPresented: error)
                .navigationTitle("Notes")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if locationManager.location != nil {
                                isPresentingNewNote = true
                            } else {
                                self.error = true
                                self.message = "There is no available location"
                            }
                            
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        if locationManager.location == nil {
                            Button {
                                locationManager.refreshLocation(openSettings: true)
                            } label: {
                                Text("Refresh Location")
                            }
                            
                        }
                    }
                }
                .sheet(isPresented: $isPresentingNewNote) {
                    EditNoteView()
                        .environmentObject(locationManager)
                        .environmentObject(dataManager)
                }
                .onChange(of: error) { newValue in
                    if newValue {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            error = false
                            message = ""
                        }
                    }
                }
            }
    }
    
    private func deleteNotes(at offsets: IndexSet) {
        dataManager.removeNotes(atOffsets: offsets)
    }
}
