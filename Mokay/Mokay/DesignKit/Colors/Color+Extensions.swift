//
//  Color+Extensions.swift
//  Mokay
//
//  Created by Єгор Привалов on 13.07.2025.
//

import Foundation
import SwiftUI
import UIKit

// MARK: - UIColor + Hex
public extension UIColor {
	/// Инициализация UIColor из hex-строки (#RRGGBB или #RRGGBBAA)
	convenience init?(hex: String) {
		var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
		if hexString.count == 6 { hexString = "FF" + hexString }
		guard let hexVal = UInt64(hexString, radix: 16) else { return nil }
		
		let a = CGFloat((hexVal & 0xFF000000) >> 24) / 255.0
		let r = CGFloat((hexVal & 0x00FF0000) >> 16) / 255.0
		let g = CGFloat((hexVal & 0x0000FF00) >> 8) / 255.0
		let b = CGFloat(hexVal & 0x000000FF) / 255.0
		
		self.init(red: r, green: g, blue: b, alpha: a)
	}
}

// MARK: - SwiftUI Color Extensions
@MainActor
public extension Color {
	/// Получить цвет из темы по группе и имени
	static func theme(_ group: ThemeGroupName, _ name: String) -> Color {
		guard let uiColor = AppTheme.shared.color(for: group, name: name) else {
			return .clear
		}
		return Color(uiColor)
	}
	
	/// Цвета акцента
	static func accent(_ name: AccentColorName) -> Color {
		theme(.accent, name.rawValue)
	}
	
	/// Фоновые цвета
	static func background(_ name: BackgroundColorName) -> Color {
		theme(.bg, name.rawValue)
	}
	
	/// Вторичный фон
	static func backgroundSecondary(_ name: AccentColorName) -> Color {
		theme(.bgSecondary, name.rawValue)
	}
	
	/// Текстовые цвета
	static func text(_ name: TextColorName) -> Color {
		theme(.text, name.rawValue)
	}
	
	/// Системные цвета
	static func system(_ name: SystemColorName) -> Color {
		theme(.system, name.rawValue)
	}
}
