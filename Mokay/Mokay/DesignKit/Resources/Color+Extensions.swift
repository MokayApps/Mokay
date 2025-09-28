//
//  Color+Extensions.swift
//  Shiva
//
//  Created by Єгор Привалов on 12.09.2025.
//

import Foundation
import SwiftUI
import UIKit

public extension UIColor {
	public convenience init(
		light lightModeColor: @escaping @autoclosure () -> UIColor,
		dark darkModeColor: @escaping @autoclosure () -> UIColor
	) {
		self.init { traitCollection in
			switch traitCollection.userInterfaceStyle {
			case .light:
				return lightModeColor()
			case .dark:
				return darkModeColor()
			case .unspecified:
				return lightModeColor()
			@unknown default:
				return lightModeColor()
			}
		}
	}
}

public extension Color {
	public init(
		light lightModeColor: @escaping @autoclosure () -> Color,
		dark darkModeColor: @escaping @autoclosure () -> Color
	) {
		self.init(UIColor(
			light: UIColor(lightModeColor()),
			dark: UIColor(darkModeColor())
		))
	}
}

fileprivate extension UIColor {
	func toColor() -> Color { return Color(self) }
}

public extension UIColor {
	public convenience init(_ rgbValue: UInt,_ alpha: CGFloat = 1.0) {
		self.init(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(alpha)
		)
	}
}

public extension Color {
	public init(_ hex: UInt, alpha: Double = 1) {
		self.init(
			.sRGB,
			red: Double((hex >> 16) & 0xff) / 255,
			green: Double((hex >> 08) & 0xff) / 255,
			blue: Double((hex >> 00) & 0xff) / 255,
			opacity: alpha
		)
	}
}

public extension Color {
	public init(hexString: String, alpha: Double = 1) {
		if let number = UInt(hexString, radix: 16) {
			self.init(number, alpha: alpha)
		} else {
			self.init(0x000000, alpha: 0)
		}
	}
}


public extension UInt {
	public var toColor: Color {
		return Color(self)
	}
}

public extension Color {
	public var uiColor: UIColor {
		return UIColor(self)
	}
}

public extension Color {
	public func toHex() -> String? {
		// Convert Color to UIColor
		let uiColor = UIColor(self)
		
		// Extract the components
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0
		
		guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
			return nil
		}
		
		// Format the components as a hex string
		let redHex = String(format: "%02X", Int(red * 255))
		let greenHex = String(format: "%02X", Int(green * 255))
		let blueHex = String(format: "%02X", Int(blue * 255))
		
		// Combine and return the hex string
		return "\(redHex)\(greenHex)\(blueHex)"
	}
}
