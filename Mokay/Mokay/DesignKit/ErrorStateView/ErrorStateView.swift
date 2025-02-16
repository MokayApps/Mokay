//
//  ErrorStateView.swift
//  Mokay
//
//  Created by Єгор Привалов on 15.02.2025.
//

import SwiftUI

public struct ErrorStateView<ButtonContent: View>: View {
	
	let icon: Image?
	let title: LocalizedStringKey?
	let subtitle: LocalizedStringKey?
	let button: ButtonContent
	
	public init(
		icon: Image? = nil,
		title: LocalizedStringKey? = nil,
		subtitle: LocalizedStringKey? = nil,
		@ViewBuilder button: () -> ButtonContent = { EmptyView() }
	) {
		self.icon = icon
		self.title = title
		self.subtitle = subtitle
		self.button = button()
	}
	
	public var body: some View {
		VStack(alignment: .center, spacing: .x05) {
			imageView
			titleLabel
			subtitleLabel
			buttonView
		}
		.padding(.x2)
	}
	
	@ViewBuilder
	var imageView: some View {
		if let icon {
			icon
				.typography(.sfSymbolXL)
				.frame(width: 40, height: 40)
				.foregroundStyle(.secondary)
		}
	}
	
	@ViewBuilder
	var titleLabel: some View {
		if let title {
			Text(title)
				.typography(.mediumLabel)
				.frame(height: 24)
				.foregroundStyle(.primary)
		}
	}
	
	@ViewBuilder
	var subtitleLabel: some View {
		if let subtitle {
			Text(subtitle)
				.typography(.subhead)
				.frame(height: 18)
				.foregroundStyle(.secondary)
		}
	}
	
	@ViewBuilder
	var buttonView: some View {
		if ButtonContent.self != EmptyView.self {
			button.padding(.top, .x2 - .x05)
		}
	}
}
