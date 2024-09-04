//
//  AuthView.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import SwiftUI

struct AuthScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State private var rePassword = ""
    @State private var isLogin: Bool
    
    @State private var warning: Bool = false
    @State private var error: Bool = false
    @State private var message: String = ""
    @State private var loading: Bool = false
    
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Email")) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Section(header: Text("Password")) {
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                if !isLogin {
                    Section(header: Text("Verify Password")) {
                        SecureField("Verify Password", text: $rePassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                
                Section {
                    Button {
                        isAllowed ? authenticate() : triggerWarning()
                    } label: {
                        if loading {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        } else {
                            Text(isLogin ? "Login" : "Register")
                                .frame(maxWidth: .infinity)
                            }
                    }
                }
                Section {
                    Button(isLogin ? "Need to register?" : "Already have an account?") {
                        isLogin.toggle()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle(isLogin ? "Login" : "Register")
            .presentPopup(message, type: .error, isPresented: error)
            .presentPopup(validationMessage, type: .warning, isPresented: warning)
            .onChange(of: warning) {
                if warning {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            warning = false
                        }
                    }
                }
            }
            .onChange(of: error) {
                if error {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            error = false
                        }
                    }
                }
            }
        }
    }
    
    init(hasLoggedIn: Bool = true) {
        _isLogin = State(initialValue: hasLoggedIn)
    }
    
    func authenticate() {
        self.loading = true
        dataManager.authenticate(email: email, password: password, isLogin: isLogin) { error in
            if let error = error {
                self.loading = false
                self.error = true
                self.message = error
                print(error)
            } else {
                self.loading = false
            }
        }
    }
    
    func triggerWarning() {
        warning = true
    }
    
    var validationMessage: String {
        if email.isEmpty {
            return "Email cannot be empty."
        }
        
        if password.isEmpty {
            return "Password cannot be empty."
        }
        
        if !isLogin && password != rePassword {
            return "Passwords do not match."
        }
        
        return ""
    }

    var isAllowed: Bool {
        return validationMessage.isEmpty
    }
}
