//
//  InputView.swift
//  Mokay
//
//  Created by Andrei Kozlov on 14/12/24.
//

import SwiftUI

public struct InputView<LeadingContent: View, TrailingContent: View>: View {
	
	@Environment(\.inputViewStyle) var inputViewStyle
	
	@Binding var text: String
	let placeholder: String
	let shouldChange: @MainActor (String) -> Bool
	let leadingItem: LeadingContent
	let trailingItem: TrailingContent
	
	@Binding private var caretColor: UIColor
	
	public init(
		text: Binding<String>,
		placeholder: String,
		caretColor: Binding<UIColor> = .constant(.systemBlue),
		@ViewBuilder leadingItem: () -> LeadingContent,
		@ViewBuilder trailingItem: () -> TrailingContent
	) {
		self._text = text
		self.placeholder = placeholder
		self.shouldChange =  { _ in true }
		self.leadingItem = leadingItem()
		self.trailingItem = trailingItem()
		self._caretColor = caretColor
	}
	
	public init(
		text: Binding<String>,
		placeholder: String,
		caretColor: Binding<UIColor> = .constant(.systemBlue),
		@ViewBuilder leadingItem: () -> LeadingContent
	) where TrailingContent == EmptyView {
		self._text = text
		self.placeholder = placeholder
		self.shouldChange =  { _ in true }
		self.leadingItem = leadingItem()
		self.trailingItem = EmptyView()
		self._caretColor = caretColor
	}
	
	public init(
		text: Binding<String>,
		placeholder: String,
		caretColor: Binding<UIColor> = .constant(.systemBlue),
		@ViewBuilder trailingItem: () -> TrailingContent
	) where LeadingContent == EmptyView {
		self._text = text
		self.placeholder = placeholder
		self.shouldChange =  { _ in true }
		self.leadingItem = EmptyView()
		self.trailingItem = trailingItem()
		self._caretColor = caretColor
	}
	
	public init(
		text: Binding<String>,
		placeholder: String,
		caretColor: Binding<UIColor> = .constant(.systemBlue),
		shouldChange: @escaping @Sendable @MainActor (String) -> Bool,
		@ViewBuilder leadingItem: () -> LeadingContent,
		@ViewBuilder trailingItem: () -> TrailingContent
	) {
		self._text = text
		self.placeholder = placeholder
		self.shouldChange = shouldChange
		self.leadingItem = leadingItem()
		self.trailingItem = trailingItem()
		self._caretColor = caretColor
	}
	
	public init(
		text: Binding<String>,
		placeholder: String,
		caretColor: Binding<UIColor> = .constant(.systemBlue)
	) where LeadingContent == EmptyView, TrailingContent == EmptyView {
		self._text = text
		self.placeholder = placeholder
		self.shouldChange =  { _ in true }
		self.leadingItem = EmptyView()
		self.trailingItem = EmptyView()
		self._caretColor = caretColor
	}
	
	public var body: some View {
		HStack(alignment: .center, spacing: .x1) {
			leadingItem
			TextFieldRepresentable(
				text: $text,
				placeholder: placeholder,
				tintColor: $caretColor,
				shouldChange: shouldChange
			)
			.frame(height: inputViewStyle.height)
			
			trailingItem
			if !text.isEmpty {
				Button {
					text = ""
				} label: {
					Image(systemName: "xmark.app.fill")
						.symbolRenderingMode(.palette)
						.foregroundStyle(.black, .background.secondary)
						.font(.body)
				}
			}
		}
		.padding(.horizontal, .x2)
		.background(in: RoundedRectangle(cornerRadius: 24))
		.backgroundStyle(Color.secondaryGray)
	}
}

#Preview {
	@Previewable @State var text: String = ""
	InputView(
		text: .constant(""),
		placeholder: "LOL",
		leadingItem: {
			Image(systemName: "rectangle.3.offgrid")
		}
	)
	
	InputView(
		text: .constant(""),
		placeholder: "LOL",
		caretColor: .constant(.red),
		trailingItem: {
			Image(systemName: "rectangle.3.offgrid")
		}
	)
	
	InputView(
		text: .constant("some text..."),
		placeholder: "LOL",
		leadingItem: {
			Image(systemName: "rectangle.3.offgrid")
		},
		trailingItem: {
			Image(systemName: "rectangle.3.offgrid")
		}
	)
	
	InputView(
		text: $text,
		placeholder: "LOL",
		leadingItem: {
			Image(systemName: "rectangle.3.offgrid")
		},
		trailingItem: {
			Image(systemName: "rectangle.3.offgrid")
		}
	)
	.inputViewStyle(.large)
}

@MainActor struct TextFieldRepresentable: UIViewRepresentable {
	
	@Binding var text: String
	@Binding var tintColor: UIColor
	private var placeholder: String
	private let shouldChange: (String) -> Bool

	init(
		text: Binding<String>,
		placeholder: String,
		tintColor: Binding<UIColor>,
		shouldChange: @escaping @MainActor (String) -> Bool
	) {
		_text = text
		self.placeholder = placeholder
		self.shouldChange = shouldChange
		_tintColor = tintColor
	}
	
	public func makeUIView(context: Context) -> UITextField {
		let textField = UITextField()
		textField.delegate = context.coordinator
		textField.placeholder = placeholder
		textField.textColor = Color.textPrimary.uiColor
		textField.textAlignment = .left
		textField.tintColor = tintColor
		textField.attributedPlaceholder = NSAttributedString(
			string: placeholder,
			attributes: [
				.foregroundColor: Color.textSecondary.uiColor
			]
		)
		switch context.environment.inputViewStyle {
		case .medium:
			textField.font = .typography(.body)
		case .large:
			textField.font = .typography(.h3)
		}
		textField.addTarget(
			context.coordinator,
			action: #selector(Coordinator.textFieldEditingChanged),
			for: .editingChanged
		)
		textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		return textField
	}
	
	public func updateUIView(_ uiView: UITextField, context: Context) {
		uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		uiView.text = text
		uiView.tintColor = tintColor ?? .black
	}
	
	public func makeCoordinator() -> Coordinator {
		return Coordinator(
			text: $text,
			shouldChange: shouldChange
		)
	}
	
	@MainActor public final class Coordinator: NSObject {
		
		@Binding private var text: String
		private let shouldChange: (String) -> Bool
		private let textTransform: [StringTransform]
		
		init(
			text: Binding<String>,
			textTransform: [StringTransform] = [.toLatin, .stripCombiningMarks],
			shouldChange: @escaping (String) -> Bool
		) {
			self._text = text
			self.textTransform = textTransform
			self.shouldChange = shouldChange
		}
		
		@objc func textFieldEditingChanged(textField: UITextField) {
			text = textField.text ?? ""
		}
	}
	
}

extension TextFieldRepresentable.Coordinator: UITextFieldDelegate {
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard let text = textField.text,
			  let replacedRange = Range(range, in: text) else {
			return false
		}
		
		let replacement = transform(text: string, textTransform: textTransform)
		let displayedText = text.replacingCharacters(in: replacedRange, with: replacement)
		
		let shouldChangeCharacters = shouldChange(displayedText)
		let needsForceReplace = shouldChangeCharacters && replacement != string
		
		if needsForceReplace,
		   let replaceStart = textField.position(from: textField.beginningOfDocument, offset: range.location),
		   let replaceEnd = textField.position(from: replaceStart, offset: range.length),
		   let textRange = textField.textRange(from: replaceStart, to: replaceEnd) {
			textField.replace(textRange, withText: replacement)
			
			return false
		}
		
		return shouldChangeCharacters
	}
	
	private func transform(text: String, textTransform: [StringTransform]) -> String {
		return textTransform.reduce(text) { partialResult, transform in
			partialResult.applyingTransform(transform, reverse: false) ?? partialResult
		}
	}
}
