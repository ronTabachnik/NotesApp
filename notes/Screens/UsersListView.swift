//
//  UsersView.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import SwiftUI
import Kingfisher

struct UsersListView: View {
    @State private var isLoading = false
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    if dataManager.users.isEmpty {
                        VStack {
                            Text("No users found")
                                .font(.title)
                                .foregroundColor(.gray)
                            Button {
                                dataManager.fetchData()
                            } label: {
                                Text("Try to fetch again.")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                    } else {
                        ForEach(dataManager.users) { user in
                            NavigationLink {
                                DetailUserView(user: user)
                            } label: {
                                HStack(alignment: .bottom) {
                                    KFImage(URL(string: user.avatar))
                                        .resizable()
                                        .cacheMemoryOnly()
                                        .placeholder({
                                            ProgressView()
                                        })
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading) {
                                        Text("\(user.firstName) \(user.lastName)")
                                            .font(.headline)
                                        Text(user.email)
                                            .font(.subheadline)
                                    }
                                    Spacer()
                                }
                                .frame(height: 80)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
                .onAppear {
                    dataManager.fetchData(load: !dataManager.isFirstLaunch())
                }
                .navigationTitle("Users")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dataManager.signOut()
                        } label: {
                            Text("Logout")
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    UsersView()
//}
