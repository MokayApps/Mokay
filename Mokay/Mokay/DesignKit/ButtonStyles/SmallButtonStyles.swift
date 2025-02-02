//
//  SmallButtonStyles.swift
//  Mokay
//
//  Created by Єгор Привалов on 23.12.2024.
//

import Foundation
import SwiftUI

public struct PrimarySmallButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.typography(.smallLabel)
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
    public static var primarySmall: Self { Self() }
}

public struct SecondarySmallButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.typography(.smallLabel)
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
    public static var secondarySmall: Self { Self() }
}

public struct GhostSmallButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.typography(.smallLabel)
			.padding(.x1)
			.frame(height: 40)
			.opacity(configuration.isPressed ? 0.5 : 1.0)
			.animation(.easeInOut, value: configuration.isPressed)
	}
}

extension ButtonStyle where Self == GhostSmallButtonStyle {
    public static var ghostSmall: Self { Self() }
}
