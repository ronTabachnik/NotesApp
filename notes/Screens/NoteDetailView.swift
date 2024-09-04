//
//  NoteDetailView.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import SwiftUI

struct NoteDetailView: View {
    @State var note: Note
    @State private var edit: Bool = false
    @EnvironmentObject private var dataManager: DataManager
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        Form {
            if let imageName = note.image?.text, !imageName.isEmpty {
                Section(header: Text("Icon")) {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding()
                }
            }
            
            Section(header: Text("Title")) {
                Text(note.title)
                    .font(.headline)
            }
            
            Section(header: Text("Content")) {
                Text(note.content)
                    .font(.body)
                    .padding(.top)
            }
        }
        .navigationTitle("Note Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { edit = true }) {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $edit) {
            EditNoteView(note: Binding(get: {
                note
            }, set: { newNote in
                if let newNote = newNote {
                    note = newNote
                }
            }))
            .environmentObject(locationManager)
            .environmentObject(dataManager)
        }
    }
}




//#Preview {
//    NoteDetailView()
//}
