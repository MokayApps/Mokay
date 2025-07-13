//
//  TokenGroup.swift
//  Mokay
//
//  Created by Єгор Привалов on 13.07.2025.
//

import Foundation

public struct TokenGroup: Decodable {
	let tokens: [String: [String: DesignToken]]
}
