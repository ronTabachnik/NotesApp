//
//  Popup.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import Foundation
import SwiftUI

struct PopView: View {
    var type: AlertType
    var text: String
    let withBackground: Bool
    let visible: Bool
    
    public var body: some View {
        if visible {
            HStack(alignment: .center, spacing: 8) {
                if type == .loading {
                    ProgressView()
                        .frame(width: 30, height: 30)
                        .tint(type.color())
                } else {
                    Image(systemName: type.image())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(type.color())
                }
                Text(type == .loading ? type.text() : text)
                    .font(.system(size: 16, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(type.color())
            }
            .padding()
            .background(withBackground ? Color.white : Color.clear)
            .cornerRadius(8)
            .shadow(radius: withBackground ? 5 : 0)
            .overlay(
                Group {
                    if withBackground {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(type.color(), lineWidth: 2)
                    }
                }
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
        }
    }
    
    init(type: AlertType = .error, text: String = "", withBackground: Bool = false, visible: Bool = true) {
        self.type = type
        self.text = text
        self.withBackground = withBackground
        self.visible = visible
    }
}

enum AlertType {
    case error
    case warning
    case success
    case loading
    
    func image() -> String {
        switch self {
        case .error: return "exclamationmark.triangle"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .loading: return ""
        }
    }
    
    func text() -> String {
        switch self {
        case .error: return "Error"
        case .warning: return "Warning"
        case .success: return "Success"
        case .loading: return "Loading..."
        }
    }
    
    func color() -> Color {
        switch self {
        case .error: return .red
        case .warning: return .orange
        case .success: return .green
        case .loading: return .blue
        }
    }
}

// MARK: - Popup View Extension
extension View {
    func presentPopup(_ text: String, type: AlertType, isPresented: Bool, withBackground: Bool = true) -> some View {
        self.overlay(
            Group {
                if isPresented {
                    PopView(type: type, text: text, withBackground: withBackground, visible: isPresented)
                        .transition(.slide)
                        .animation(.easeInOut, value: isPresented)
                }
            }, alignment: .top
        )
    }
}

