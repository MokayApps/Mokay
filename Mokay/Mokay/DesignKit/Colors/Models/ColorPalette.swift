//
//  ColorPalette.swift
//  Mokay
//
//  Created by Єгор Привалов on 13.07.2025.
//

import Foundation

public struct ColorPalette: Decodable {
	let colors: [String: [String: DesignToken]]
}
