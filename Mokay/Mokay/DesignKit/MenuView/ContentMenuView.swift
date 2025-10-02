//
//  ContentMenuView.swift
//  Mokay
//
//  Created by Єгор Привалов on 02.10.2025.
//

import Foundation
import SwiftUI

@available(iOS 26.0, *)
public struct ContentMenuView<Label: View, Style: PrimitiveButtonStyle, Content: View>: View {
	
	@ViewBuilder private var label: Label
	@ViewBuilder private var content: Content
	
	@Namespace private var namespace
	
	@State private var isExpanded: Bool = false
	@State private var isHapticEnabled: Bool = true
	@State private var haptic: Bool = false
	
	private let style: Style
	
	public init(
		@ViewBuilder label: () -> Label,
		style: Style,
		@ViewBuilder content: () -> Content,
		isHapticEnabled: Bool = true
	) {
		self.label = label()
		self.style = style
		self.content = content()
		self.isHapticEnabled = isHapticEnabled
	}
	
	public var body: some View {
		Button {
			if isHapticEnabled { haptic.toggle() }
			isExpanded.toggle()
		} label: {
			label
				.matchedTransitionSource(id: AnimationID.content.rawValue, in: namespace)
		}
		.buttonStyle(style)
		.popover(isPresented: $isExpanded) {
			PopoverContentHelper {
				content
			}
			.navigationTransition(.zoom(sourceID: AnimationID.content.rawValue, in: namespace))
		}
		.sensoryFeedback(.selection, trigger: haptic)
	}
}

@available(iOS 26.0, *)
private extension ContentMenuView {
	enum AnimationID: String {
		case content = "Content"
	}
}

fileprivate struct PopoverContentHelper<Content: View>: View {
	
	@ViewBuilder var content: Content
	
	@State private var isVisible: Bool = false
	
	var body: some View {
		content
			.opacity(isVisible ? 1 : 0)
			.task {
				try? await Task.sleep(for: .seconds(0.1))
				withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
					isVisible = true
				}
			}
			.presentationCompactAdaptation(.popover)
	}
}
