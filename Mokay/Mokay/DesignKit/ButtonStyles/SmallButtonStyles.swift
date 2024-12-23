//
//  SmallButtonStyles.swift
//  Mokay
//
//  Created by Єгор Привалов on 23.12.2024.
//

import Foundation
import SwiftUI

struct PrimarySmallButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.typography(type: .smallLabel)
			.padding(.x1)
			.frame(height: 40)
			.background {
				RoundedRectangle(cornerRadius: 17)
					.foregroundStyle(.primary)
			}
			.opacity(configuration.isPressed ? 0.5 : 1.0)
			.animation(.easeInOut, value: configuration.isPressed)
	}
}

extension ButtonStyle where Self == PrimarySmallButtonStyle {
	static var primary: PrimarySmallButtonStyle {
		PrimarySmallButtonStyle()
	}
}

struct SecondarySmallButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.typography(type: .smallLabel)
			.padding(.x1)
			.frame(height: 40)
			.background {
				RoundedRectangle(cornerRadius: 17)
					.foregroundStyle(.secondary)
			}
			.opacity(configuration.isPressed ? 0.5 : 1.0)
			.animation(.easeInOut, value: configuration.isPressed)
	}
}

extension ButtonStyle where Self == SecondarySmallButtonStyle {
	static var secondary: SecondarySmallButtonStyle {
		SecondarySmallButtonStyle()
	}
}

struct GhostSmallButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.typography(type: .smallLabel)
			.padding(.x1)
			.frame(height: 40)
			.opacity(configuration.isPressed ? 0.5 : 1.0)
			.animation(.easeInOut, value: configuration.isPressed)
	}
}

extension ButtonStyle where Self == GhostSmallButtonStyle {
	static var ghost: GhostSmallButtonStyle {
		GhostSmallButtonStyle()
	}
}
