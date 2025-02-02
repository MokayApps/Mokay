//
//  MediumButtonStyles.swift
//  Mokay
//
//  Created by Єгор Привалов on 23.12.2024.
//

import Foundation
import SwiftUI

public struct PrimaryMediumButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.typography(.mediumLabel)
			.padding(.horizontal, .x3)
			.padding(.vertical, .x2)
			.frame(height: 56)
            .background(.background, in: RoundedRectangle(cornerRadius: 24))
			.opacity(configuration.isPressed ? 0.5 : 1.0)
			.animation(.easeInOut, value: configuration.isPressed)
	}
}

extension ButtonStyle where Self == PrimaryMediumButtonStyle {
    public static var primaryMedium: Self { Self() }
}

public struct SecondaryMediumButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.typography(.mediumLabel)
			.padding(.horizontal, .x3)
			.padding(.vertical, .x2)
			.frame(height: 56)
            .background(.background.secondary, in: RoundedRectangle(cornerRadius: 24))
			.opacity(configuration.isPressed ? 0.5 : 1.0)
			.animation(.easeInOut, value: configuration.isPressed)
	}
}

extension ButtonStyle where Self == SecondaryMediumButtonStyle {
    public static var secondaryMedium: Self { Self() }
}

public struct GhostMediumButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.typography(.mediumLabel)
			.padding(.horizontal, .x3)
			.padding(.vertical, .x2)
			.frame(height: 56)
			.opacity(configuration.isPressed ? 0.5 : 1.0)
			.animation(.easeInOut, value: configuration.isPressed)
	}
}

extension ButtonStyle where Self == GhostMediumButtonStyle {
    public static var ghostMedium: Self { Self() }
}
