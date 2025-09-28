//
//  TextFieldRepresentable.swift
//  Mokay
//
//  Created by Andrei Kozlov on 02.02.2025.
//

import SwiftUI
//
//@MainActor struct TextFieldRepresentable: UIViewRepresentable {
//	
//	@Binding var text: String
//	private var placeholder: String
//	private let shouldChange: (String) -> Bool
//	private let tintColor: UIColor?
//
//	init(
//		text: Binding<String>,
//		placeholder: String,
//		tintColor: UIColor? = nil,
//		shouldChange: @escaping @MainActor (String) -> Bool
//	) {
//		_text = text
//		self.placeholder = placeholder
//		self.shouldChange = shouldChange
//		self.tintColor = tintColor
//	}
//	
//	public func makeUIView(context: Context) -> UITextField {
//		let textField = UITextField()
//		textField.delegate = context.coordinator
//		textField.placeholder = placeholder
//		textField.textColor = Color.textPrimary.uiColor
//		textField.textAlignment = .left
//		textField.tintColor = tintColor ?? .black
//		textField.attributedPlaceholder = NSAttributedString(
//			string: placeholder,
//			attributes: [
//				.foregroundColor: Color.textSecondary.uiColor
//			]
//		)
//		switch context.environment.inputViewStyle {
//		case .medium:
//			textField.font = .typography(.body)
//		case .large:
//			textField.font = .typography(.h3)
//		}
//		textField.addTarget(
//			context.coordinator,
//			action: #selector(Coordinator.textFieldEditingChanged),
//			for: .editingChanged
//		)
//		textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//		return textField
//	}
//	
//	public func updateUIView(_ uiView: UITextField, context: Context) {
//		uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//		uiView.text = text
//		uiView.tintColor = tintColor ?? .black
//	}
//	
//	public func makeCoordinator() -> Coordinator {
//		return Coordinator(
//			text: $text,
//			shouldChange: shouldChange
//		)
//	}
//	
//	@MainActor public final class Coordinator: NSObject {
//		
//		@Binding private var text: String
//		private let shouldChange: (String) -> Bool
//		private let textTransform: [StringTransform]
//		
//		init(
//			text: Binding<String>,
//			textTransform: [StringTransform] = [.toLatin, .stripCombiningMarks],
//			shouldChange: @escaping (String) -> Bool
//		) {
//			self._text = text
//			self.textTransform = textTransform
//			self.shouldChange = shouldChange
//		}
//		
//		@objc func textFieldEditingChanged(textField: UITextField) {
//			text = textField.text ?? ""
//		}
//	}
//	
//}
//
//extension TextFieldRepresentable.Coordinator: UITextFieldDelegate {
//	
//	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//		guard let text = textField.text,
//			  let replacedRange = Range(range, in: text) else {
//			return false
//		}
//		
//		let replacement = transform(text: string, textTransform: textTransform)
//		let displayedText = text.replacingCharacters(in: replacedRange, with: replacement)
//		
//		let shouldChangeCharacters = shouldChange(displayedText)
//		let needsForceReplace = shouldChangeCharacters && replacement != string
//		
//		if needsForceReplace,
//		   let replaceStart = textField.position(from: textField.beginningOfDocument, offset: range.location),
//		   let replaceEnd = textField.position(from: replaceStart, offset: range.length),
//		   let textRange = textField.textRange(from: replaceStart, to: replaceEnd) {
//			textField.replace(textRange, withText: replacement)
//			
//			return false
//		}
//		
//		return shouldChangeCharacters
//	}
//	
//	private func transform(text: String, textTransform: [StringTransform]) -> String {
//		return textTransform.reduce(text) { partialResult, transform in
//			partialResult.applyingTransform(transform, reverse: false) ?? partialResult
//		}
//	}
//}
