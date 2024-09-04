//
//  UserDetailView.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import Foundation
import SwiftUI
import Kingfisher

struct DetailUserView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                KFImage(URL(string: user.avatar))
                    .resizable()
                    .placeholder({
                        ProgressView()
                    })
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .shadow(radius: 10)
                    .padding(.top, 16)
                
                Text("\(user.firstName) \(user.lastName)")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Gender: \(user.gender)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .navigationTitle("User Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
