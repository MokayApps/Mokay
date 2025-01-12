//
//  MediumButtonStyles.swift
//  Mokay
//
//  Created by Єгор Привалов on 23.12.2024.
//

import Foundation
import SwiftUI

struct PrimaryMediumButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
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
	static var primary: PrimaryMediumButtonStyle {
		PrimaryMediumButtonStyle()
	}
}

struct SecondaryMediumButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
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
	static var secondary: SecondaryMediumButtonStyle {
		SecondaryMediumButtonStyle()
	}
}

struct GhostMediumButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
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
	static var ghost: GhostMediumButtonStyle {
		GhostMediumButtonStyle()
	}
}
