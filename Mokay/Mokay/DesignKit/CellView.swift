//
//  ListCellView.swift
//  Mokay
//
//  Created by Roman Apanasevich on 29.12.2024.
//

import Foundation
import SwiftUI

public struct CellView<LeadingContent: View, TrailingContent: View>: View {
	
	let leadingItem: (() -> LeadingContent)?
	let trailingItem: (() -> TrailingContent)?
	let text: String
	let description: String?
	let showRedDot: Bool
	
    public init(
		@ViewBuilder leadingItem: @escaping () -> LeadingContent,
		@ViewBuilder trailingItem: @escaping () -> TrailingContent,
		text: String,
		description: String?,
		showRedDot: Bool
	) {
		self.leadingItem = leadingItem
		self.trailingItem = trailingItem
		self.text = text
		self.description = description
		self.showRedDot = showRedDot
	}
	
	public var body: some View {
		HStack(spacing: .zero) {
			leadingItem?()
			
			VStack(alignment: .leading, spacing: .zero) {
				HStack(spacing: .x2) {
					Text(text)
						.typography(type: .mediumLabel)
					if showRedDot {
						Circle()
							.frame(width: 8, height: 8)
							.foregroundColor(.red)
					}
				}
				if let description {
					Text(description)
						.typography(type: .description)
						.foregroundStyle(.secondary)
				}
			}
			.padding(.leading, leadingItem == nil ? .zero : .x2)
			
			Spacer()
			
			trailingItem?()
				.padding(.leading, .x1)
		}
		.padding(.init(top: .x2, leading: .x3, bottom: .x2, trailing: .x2))
	}
}

extension CellView where LeadingContent == EmptyView, TrailingContent == EmptyView {
	
    public init(text: String, description: String? = nil, showRedDot: Bool = false) {
		self.leadingItem = nil
		self.trailingItem = nil
		self.text = text
		self.description = description
		self.showRedDot = showRedDot
	}
}

extension CellView where TrailingContent == EmptyView {
	
    public init(@ViewBuilder leadingItem: @escaping () -> LeadingContent, text: String, description: String? = nil, showRedDot: Bool = false) {
		self.leadingItem = leadingItem
		self.trailingItem = nil
		self.text = text
		self.description = description
		self.showRedDot = showRedDot
	}
}

extension CellView where LeadingContent == EmptyView {
	
    public init(@ViewBuilder trailingItem: @escaping () -> TrailingContent, text: String, description: String? = nil, showRedDot: Bool = false) {
		self.trailingItem = trailingItem
		self.leadingItem = nil
		self.text = text
		self.description = description
		self.showRedDot = showRedDot
	}
}

struct CellViewPreview: View {
	var body: some View {
		List {
			CellView(
				text: "Hueta",
				description: nil,
				showRedDot: false
			)
			.frame(width: .infinity, height: 72, alignment: .center)
			.listRowInsets(EdgeInsets())
			
			CellView(
				text: "Hueta",
				description: nil,
				showRedDot: true
			)
			.frame(width: .infinity, height: 72, alignment: .center)
			.listRowInsets(EdgeInsets())
			
			CellView(
				trailingItem: {
					Image(systemName: "iphone")
						.foregroundStyle(.orange)
				},
				text: "Hueta",
				description: nil,
				showRedDot: false
			)
			.frame(width: .infinity, height: 72, alignment: .center)
			.listRowInsets(EdgeInsets())
			
			CellView(
				trailingItem: {
					Image(systemName: "iphone")
						.foregroundStyle(.orange)
				},
				text: "Hueta",
				description: nil,
				showRedDot: true
			)
			.frame(width: .infinity, height: 72, alignment: .center)
			.listRowInsets(EdgeInsets())
			
			CellView(
				text: "Hueta",
				description: "Eshe huetaaaaa",
				showRedDot: false
			)
			.frame(width: .infinity, height: 72, alignment: .center)
			.listRowInsets(EdgeInsets())
			
			CellView(
				text: "Hueta",
				description: "Eshe huetaaaaa",
				showRedDot: true
			)
			.frame(width: .infinity, height: 72, alignment: .center)
			.listRowInsets(EdgeInsets())
			
			CellView(
				trailingItem: {
					Image(systemName: "iphone")
						.foregroundStyle(.orange)
				},
				text: "Hueta",
				description: "Eshe huetaaaaa",
				showRedDot: true
			)
			.frame(width: .infinity, height: 72, alignment: .center)
			.listRowInsets(EdgeInsets())
			
			CellView(
				leadingItem: {
					Image(systemName: "globe")
						.foregroundStyle(.red)
				},
				trailingItem: {
					Image(systemName: "iphone")
						.foregroundStyle(.orange)
				},
				text: "Hueta",
				description: "Eshe huetaaaaa",
				showRedDot: true
			)
			.frame(width: .infinity, height: 72, alignment: .center)
			.listRowInsets(EdgeInsets())
			
			CellView(
				leadingItem: {
					Image(systemName: "globe")
						.foregroundStyle(.red)
				},
				trailingItem: {
					Image(systemName: "iphone")
						.foregroundStyle(.orange)
				},
				text: "Hueta",
				description: nil,
				showRedDot: true
			)
			.frame(width: .infinity, height: 72, alignment: .center)
			.listRowInsets(EdgeInsets())
		}
		.listStyle(.grouped)
	}
}

#Preview {
	CellViewPreview()
}
