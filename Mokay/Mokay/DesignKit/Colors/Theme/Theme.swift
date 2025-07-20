//
//  Theme.swift
//  Mokay
//
//  Created by Єгор Привалов on 13.07.2025.
//

import Foundation
import UIKit

public final class Theme {
	private let tokens: [String: [String: DesignToken]]
	private(set) var palette: ColorPalette
	
	public init(tokens: [String: [String: DesignToken]], palette: ColorPalette) {
		self.tokens = tokens
		self.palette = palette
	}
	
	public func color(for group: ThemeGroupName, name: String) -> UIColor? {
		guard let token = tokens[group.rawValue]?[name] else { return nil }
		return resolveColor(from: token.value)
	}
	
	public func paletteColor(name: String, shade: String) -> UIColor? {
		guard let shades = palette.colors[name],
					let hex = shades[shade]?.value else { return nil }
		return UIColor(hex: hex)
	}
	
	private func resolveColor(from tokenValue: String) -> UIColor? {
		if tokenValue.hasPrefix("{colors.") {
			let path = tokenValue
				.replacingOccurrences(of: "{colors.", with: "")
				.replacingOccurrences(of: "}", with: "")
				.split(separator: ".")
			
			if path.count == 2,
				 let shades = palette.colors[String(path[0])],
				 let hex = shades[String(path[1])]?.value {
				return UIColor(hex: hex)
			}
		} else {
			return UIColor(hex: tokenValue)
		}
		return nil
	}
}
