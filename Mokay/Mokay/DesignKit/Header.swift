//
//  Header.swift
//  Mokay
//
//  Created by Дмитрий Бондаренко on 21.12.2024.
//

import SwiftUI

public struct HeaderView: View {
	
	let text: String
	let color: Color
	let style: TypographyStyle
    
    public init(
        text: String,
        color: Color,
        style: TypographyStyle
    ) {
        self.text = text
        self.color = color
        self.style = style
    }
	
    public var body: some View {
		Text(text)
			.typography(type: style)
			.foregroundStyle(color)
			.padding([.leading, .bottom], .x1)
	}
	
}

private struct ExampleContentView: View {
	var body: some View {
		VStack(alignment: .leading, spacing: .x2) {
			Spacer()
			HeaderView(
				text: "Capture",
				color: .blue,
				style: .caption
			)
			HeaderView(
				text: "Header 4",
				color: .blue,
				style: .h4
			)
			HeaderView(
				text: "Header 2",
				color: .blue,
				style: .h2
			)
			HeaderView(
				text: "Description",
				color: .blue,
				style: .description
			)
			Spacer()
		}
	}
}

struct ExampleContentView_Previews: PreviewProvider {
	static var previews: some View {
		ExampleContentView()
	}
}
