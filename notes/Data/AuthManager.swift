//
//  AuthManager.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import Foundation
import FirebaseAuth

// MARK: Authentication Manager
extension DataManager {
    func setupAuthListener() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            self.isLoggedIn = user != nil
            
            if user != nil && !UserDefaults.standard.bool(forKey: "hasLoggedInBefore") {
                UserDefaults.standard.set(true, forKey: "hasLoggedInBefore")
                self.hasLoggedInBefore = true
                print("This device has logged in at least once.")
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func authenticate(email: String, password: String, isLogin: Bool , completion: @escaping (String?) -> Void) {
        if isLogin {
            DispatchQueue.main.async {
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    guard let result = result else {
                        guard let error = error else {
                            completion("Couldn't find account with this credentials")
                            return
                        }
                        completion(error.localizedDescription)
                        return
                    }
                    completion(nil)
                }
            }
        } else {
            DispatchQueue.main.async {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let authResult = authResult {
                        completion(nil)
                    } else if let error = error {
                        completion(error.localizedDescription)
                    }
                }
            }
        }
        
    }
}
