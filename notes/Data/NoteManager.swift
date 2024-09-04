//
//  NoteManagement.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import Foundation
// MARK: - Note Management
extension DataManager {
    func addNote(note: Note) {
        notes.append(note)
        saveNotes() // Manually save after adding a note
    }
    
    func updateNote(note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
            saveNotes() // Manually save after updating a note
        }
    }
    
    func removeNotes(atOffsets offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        saveNotes() // Manually save after removing notes
    }
    
    func removeNote(note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes.remove(at: index)
            saveNotes()
        }
    }
}

// MARK: - Caching Notes
extension DataManager {
    private func saveNotes() {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(notes)
            UserDefaults.standard.set(encodedData, forKey: "savedNotes")
        } catch {
            // Handle Error
            print("Failed to encode notes: \(error.localizedDescription)")
        }
    }
    
    func loadNotes() -> [Note]? {
        guard let savedNotesData = UserDefaults.standard.data(forKey: "savedNotes") else {
            return nil
        }
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode([Note].self, from: savedNotesData)
        } catch {
            print("Failed to decode notes: \(error.localizedDescription)")
            return nil
        }
    }
}
