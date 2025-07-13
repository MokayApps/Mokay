//
//  AppTheme.swift
//  Mokay
//
//  Created by Єгор Привалов on 13.07.2025.
//

import Foundation
import SwiftUI

// MARK: - Протокол ThemeProvider
@MainActor
public protocol ThemeProvider {
	func color(for group: ThemeGroupName, name: String) -> UIColor?
}

/// Провайдер темы приложения с поддержкой светлой и тёмной темы
final class AppTheme: ObservableObject, ThemeProvider {
	
	public enum TokensFile: String {
		case tokensLightTheme, tokensDarkTheme
	}
	
	public static let shared = AppTheme()
	
	@Published private(set) var theme: Theme
	
	private init() {
		// Загружаем палитру (общая для всех тем)
		guard
			let paletteURL = Bundle.main.url(forResource: "colorPalette", withExtension: "json"),
			let paletteData = try? Data(contentsOf: paletteURL),
			let palette = try? JSONDecoder().decode(ColorPalette.self, from: paletteData)
		else {
			fatalError("Не удалось загрузить colorPalette.json")
		}
		
		// Определяем, какую тему загружать
		let isDark = UITraitCollection.current.userInterfaceStyle == .dark
		let tokensFile: TokensFile = isDark ? .tokensDarkTheme : .tokensLightTheme
		
		guard
			let tokensURL = Bundle.main.url(forResource: tokensFile.rawValue, withExtension: "json"),
			let tokensData = try? Data(contentsOf: tokensURL),
			let tokens = try? JSONDecoder().decode(TokenGroup.self, from: tokensData)
		else {
			fatalError("Не удалось загрузить \(tokensFile).json")
		}
		
		theme = Theme(tokens: tokens.tokens, palette: palette)
	}
	
	/// Получить цвет по группе и имени
	public func color(for group: ThemeGroupName, name: String) -> UIColor? {
		theme.color(for: group, name: name)
	}
	
	/// Позволяет вручную обновить тему (например, при смене цветовой схемы)
	public func updateTheme(for colorScheme: ColorScheme) {
		let tokensFile: TokensFile = colorScheme == .dark ? .tokensDarkTheme : .tokensLightTheme
		
		guard
			let tokensURL = Bundle.main.url(forResource: tokensFile.rawValue, withExtension: "json"),
			let tokensData = try? Data(contentsOf: tokensURL),
			let tokens = try? JSONDecoder().decode(TokenGroup.self, from: tokensData)
		else {
			return
		}
		
		theme = Theme(tokens: tokens.tokens, palette: self.theme.palette)
	}
}
