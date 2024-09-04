//
//  DataManager.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import Foundation
import FirebaseAuth

class DataManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var hasLoggedInBefore: Bool = false
    @Published var notes = [Note]()
    @Published var users = [User]()
    
    init() {
        let loggedInBefore = UserDefaults.standard.bool(forKey: "hasLoggedInBefore")
        self.hasLoggedInBefore = loggedInBefore
        self.isLoggedIn = Auth.auth().currentUser != nil
        self.setupAuthListener()
        self.notes = loadNotes() ?? []
    }
}
