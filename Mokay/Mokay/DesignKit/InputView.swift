//
//  InputView.swift
//  Mokay
//
//  Created by Andrei Kozlov on 14/12/24.
//

import SwiftUI

@main struct SomeApp: App {
	
	var body: some Scene {
		WindowGroup {
			InputView(text: .constant(""), placeholder: "", shouldChange: { _ in true})
		}
	}
	
}

public struct InputView: View {
	
	@Binding var text: String
	let placeholder: String
	let shouldChange: @MainActor (String) -> Bool
	@State private var isSecure: Bool = false
	
	public var body: some View {
		HStack(alignment: .center, spacing: 8) {
			Image(systemName: "magnifyingglass")
				.resizable()
				.frame(width: 24, height: 24)
			
			TextFieldRepresentable(
				text: $text,
				isSecure: $isSecure,
				placeholder: placeholder,
				shouldChange: shouldChange
			)
				.frame(maxHeight: .infinity)

			HStack(spacing: 16) {
				Button {
					isSecure.toggle()
				} label: {
					Image(systemName: "eye.fill")
				}
				if !text.isEmpty {
					Button {
						text = ""
					} label: {
						Image(systemName: "xmark")
					}
				}
			}
		}
		.padding(.horizontal, 16)
		.background(in: RoundedRectangle(cornerRadius: 24))
		.backgroundStyle(.gray)
		.tint(.black)

	}
}

@MainActor public struct TextFieldRepresentable: UIViewRepresentable {
	
	@Binding var text: String
	@Binding var isSecure: Bool
	private var placeholder: String
	private let shouldChange: (String) -> Bool

	init(
		text: Binding<String>,
		isSecure: Binding<Bool>,
		placeholder: String,
		shouldChange: @escaping @MainActor (String) -> Bool
	) {
		_text = text
		_isSecure = isSecure
		self.placeholder = placeholder
		self.shouldChange = shouldChange
	}
	
	public func makeUIView(context: Context) -> UITextField {
		let textField = UITextField()
		textField.delegate = context.coordinator
		textField.placeholder = placeholder
		textField.textAlignment = .left
		textField.font = .preferredFont(forTextStyle: .body)
		textField.keyboardType = .decimalPad
		textField.tintColor = .black
		textField.isSecureTextEntry = isSecure
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
		uiView.isSecureTextEntry = isSecure
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
	
	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
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

struct SomeView: View {
	
	@State var text: String = ""
	var body: some View {
		InputView(
			text: $text,
			placeholder: "LOL",
			shouldChange: { _ in true }
		)
		.frame(height: 56)
	}
}


#Preview {
	SomeView()
//	InputView(
//		text: .constant("some text"),
//		placeholder: "LOL",
//		shouldChange: { _ in true }
//	)
//	.frame(height: 56)

}
