//
//  UserManager.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import Foundation

// MARK: Users Manager
extension DataManager {
    func fetchData(load: Bool = false) {
        if let loadedUsers = self.loadData(), load {
            self.users = loadedUsers
        } else {
            guard let url = URL(string: "https://api.mockaroo.com/api/729a5c80?count=120&key=947b40d0") else {
                // Error handle here!
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Failed to fetch data: \(error)")
                    // Error handle here!
                    return
                }
                
                guard let data = data else {
                    // error hanlde here!
                    return
                }
                
                do {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    self.saveData(users)
                    self.setFirstLaunch()
                    DispatchQueue.main.async {
                        self.users = users
                    }
                } catch {
                    print("Failed to decode data: \(error)")
                    // error handle here!
                }
            }.resume()
        }
    }
}

// MARK: Caching User
extension DataManager {
    func saveData(_ users: [User]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(users) {
            UserDefaults.standard.set(encoded, forKey: "savedUsers")
        }
    }
    
    func loadData() -> [User]? {
        if let savedUsers = UserDefaults.standard.object(forKey: "savedUsers") as? Data {
            let decoder = JSONDecoder()
            return try? decoder.decode([User].self, from: savedUsers)
        }
        return nil
    }
    
    func isFirstLaunch() -> Bool {
        return !UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
    }
    
    func setFirstLaunch() {
        UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
    }
}


