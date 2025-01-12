//
//  Typography.swift
//  Mokay
//
//  Created by Єгор Привалов on 14.12.2024.
//

import SwiftUI
import Foundation

public enum TypographyStyle {
	case h1
	case h2
	case h3
	case h4
	case smallLabel
	case mediumLabel
	case caption
	case subhead
	case body
	case description
	
	public var size: CGFloat {
		switch self {
		case .h1: 48
		case .h2: 32
		case .h3: 26
		case .h4: 20
		case .mediumLabel: 17
		case .caption: 11
		case .smallLabel: 11
		case .subhead: 15
		case .body: 17
		case .description: 13
		}
	}
	
	public var weight: Font.Weight {
		switch self {
		case .h1: .heavy
		case .h2: .heavy
		case .h3: .bold
		case .h4: .heavy
		case .smallLabel: .bold
		case .mediumLabel: .bold
		case .caption: .bold
		case .subhead:.semibold
		case .body: .semibold
		case .description: .semibold
		}
	}
	
	public var tracking: CGFloat {
		switch self {
		case .h1: 0
		case .h2: 1
		case .h3: 1
		case .h4: 0.5
		case .smallLabel: 1
		case .mediumLabel: 1
		case .caption: 1
		case .subhead: 0
		case .body: 0
		case .description: 0
		}
	}
	
	public var font: Font {
		switch self {
		case .h1:
			Font.system(size: 48, weight: .heavy)
		case .h2:
			Font.system(size: 32, weight: .heavy)
		case .h3:
			Font.system(size: 26, weight: .bold)
		case .h4:
			Font.system(size: 20, weight: .heavy)
		case .smallLabel:
			Font.caption2.weight(.bold).smallCaps()
		case .mediumLabel:
			Font.body.weight(.bold)
		case .caption:
			Font.caption2.weight(.bold)
		case .subhead:
			Font.subheadline.weight(.semibold)
		case .body:
			Font.body.weight(.semibold)
		case .description:
			Font.footnote.weight(.semibold)
		}
	}
}

struct BaseTypography: ViewModifier {
	let type: TypographyStyle
	func body(content: Content) -> some View {
		content
			.font(type.font)
			.tracking(type.tracking)
	}
}

public extension View {
	func typography(type: TypographyStyle) -> some View {
		return self.modifier(BaseTypography(type: type))
	}
}
