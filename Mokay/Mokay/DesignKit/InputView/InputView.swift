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
    
    public init(
        text: Binding<String>,
        placeholder: String,
        @ViewBuilder leadingItem: () -> LeadingContent,
        @ViewBuilder trailingItem: () -> TrailingContent
    ) {
        self._text = text
        self.placeholder = placeholder
        self.shouldChange =  { _ in true }
        self.leadingItem = leadingItem()
        self.trailingItem = trailingItem()
    }
    
    public init(
        text: Binding<String>,
        placeholder: String,
        @ViewBuilder leadingItem: () -> LeadingContent
    ) where TrailingContent == EmptyView {
        self._text = text
        self.placeholder = placeholder
        self.shouldChange =  { _ in true }
        self.leadingItem = leadingItem()
        self.trailingItem = EmptyView()
    }
    
    public init(
        text: Binding<String>,
        placeholder: String,
        @ViewBuilder trailingItem: () -> TrailingContent
    ) where LeadingContent == EmptyView {
        self._text = text
        self.placeholder = placeholder
        self.shouldChange =  { _ in true }
        self.leadingItem = EmptyView()
        self.trailingItem = trailingItem()
    }
    
    public init(
        text: Binding<String>,
        placeholder: String,
        shouldChange: @escaping @Sendable @MainActor (String) -> Bool,
        @ViewBuilder leadingItem: () -> LeadingContent,
        @ViewBuilder trailingItem: () -> TrailingContent
    ) {
        self._text = text
        self.placeholder = placeholder
        self.shouldChange = shouldChange
        self.leadingItem = leadingItem()
        self.trailingItem = trailingItem()
    }
    
    public init(
        text: Binding<String>,
        placeholder: String
    ) where LeadingContent == EmptyView, TrailingContent == EmptyView {
        self._text = text
        self.placeholder = placeholder
        self.shouldChange =  { _ in true }
        self.leadingItem = EmptyView()
        self.trailingItem = EmptyView()
    }
	
	public var body: some View {
        HStack(alignment: .center, spacing: .x1) {
            leadingItem
			TextFieldRepresentable(
				text: $text,
				placeholder: placeholder,
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
		.backgroundStyle(.black.opacity(0.04))
        .foregroundStyle(.primary)
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
