//
//  NewNoteView.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import SwiftUI

struct EditNoteView: View {
    @Binding var note: Note?
    @State private var title: String
    @State private var content: String
    @State private var image: Icon?
    @State private var showingDeleteConfirmation = false
    
    @State private var error: Bool = false
    @State private var message: String = ""
    
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                
                Section(header: Text("Content")) {
                    TextEditor(text: $content)
                        .frame(height: 200)
                }
                
                Section(header: Text("Image")) {
                    Picker("Select an Icon", selection: $image) {
                        Text("None").tag(Icon?.none) // Allow the user to choose no icon
                        ForEach(Icon.allCases, id: \.self) { icon in
                            Text(icon.text).tag(icon as Icon?)
                        }
                    }
                }
            }
            .presentPopup(message, type: .error, isPresented: error)
            .navigationTitle(note == nil ? "New Note" : "Edit Note")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if title.isEmpty {
                            error = true
                            message = "Please fill out title"
                        } else if content.isEmpty {
                            error = true
                            message = "Please fill out content"
                        } else {
                            if let existingNote = note {
                                let updatedNote = Note(
                                    id: existingNote.id,
                                    title: title,
                                    content: content,
                                    date: existingNote.date,
                                    image: image ?? existingNote.image,
                                    latitude: existingNote.latitude,
                                    longitude: existingNote.longitude
                                )
                                dataManager.updateNote(note: updatedNote)
                                note = updatedNote
                            } else {
                                let newNote = Note(
                                    id: UUID(),
                                    title: title,
                                    content: content,
                                    date: Date(),
                                    image: image,
                                    latitude: locationManager.latitude,
                                    longitude: locationManager.longitude
                                )
                                dataManager.addNote(note: newNote)
                            }
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text(note != nil ? "Update" : "Save")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                if note != nil {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showingDeleteConfirmation = true
                        } label: {
                            Text("Delete")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .confirmationDialog("Are you sure you want to delete this note?", isPresented: $showingDeleteConfirmation) {
                Button("Delete", role: .destructive) {
                    if let noteToDelete = note {
                        dataManager.removeNote(note: noteToDelete)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                Button("Cancel", role: .cancel) {}
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
    
    init(note: Binding<Note?> = .constant(nil)) {
        _note = note
        _title = State(initialValue: note.wrappedValue?.title ?? "")
        _content = State(initialValue: note.wrappedValue?.content ?? "")
        _image = State(initialValue: note.wrappedValue?.image)
    }
}




