//
//  InputViewStyle.swift
//  Mokay
//
//  Created by Andrei Kozlov on 02.02.2025.
//

import SwiftUI

public enum InputViewStyle: Sendable {
    case medium
    case large
    
    var height: CGFloat {
        switch self {
        case .medium:
            return 56
        case .large:
            return 64
        }
    }
}

struct InputViewStyleKey: EnvironmentKey {
    static let defaultValue: InputViewStyle = .medium
}

extension EnvironmentValues {
    var inputViewStyle: InputViewStyle {
        get { self[InputViewStyleKey.self] }
        set { self[InputViewStyleKey.self] = newValue }
    }
}

extension View {
    public func inputViewStyle(_ style: InputViewStyle) -> some View {
        environment(\.inputViewStyle, style)
    }
}
