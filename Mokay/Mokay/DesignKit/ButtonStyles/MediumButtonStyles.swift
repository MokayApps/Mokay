//
//  MediumButtonStyles.swift
//  Mokay
//
//  Created by Єгор Привалов on 23.12.2024.
//

import Foundation
import SwiftUI

public struct PrimaryMediumButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.typography(type: .mediumLabel)
			.padding(.horizontal, .x3)
			.padding(.vertical, .x2)
			.frame(height: 56)
			.background {
				RoundedRectangle(cornerRadius: 24)
					.foregroundStyle(.primary)
			}
			.opacity(configuration.isPressed ? 0.5 : 1.0)
			.animation(.easeInOut, value: configuration.isPressed)
	}
}

extension ButtonStyle where Self == PrimaryMediumButtonStyle {

    public static var primary: Self { Self() }

}

public struct SecondaryMediumButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.typography(type: .mediumLabel)
			.padding(.horizontal, .x3)
			.padding(.vertical, .x2)
			.frame(height: 56)
			.background {
				RoundedRectangle(cornerRadius: 24)
					.foregroundStyle(.secondary)
			}
			.opacity(configuration.isPressed ? 0.5 : 1.0)
			.animation(.easeInOut, value: configuration.isPressed)
	}
}

extension ButtonStyle where Self == SecondaryMediumButtonStyle {
    public static var secondary: Self { Self() }
}

public struct GhostMediumButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.typography(type: .mediumLabel)
			.padding(.horizontal, .x3)
			.padding(.vertical, .x2)
			.frame(height: 56)
			.opacity(configuration.isPressed ? 0.5 : 1.0)
			.animation(.easeInOut, value: configuration.isPressed)
	}
}

extension ButtonStyle where Self == GhostMediumButtonStyle {
    public static var ghost: Self { Self() }
}
