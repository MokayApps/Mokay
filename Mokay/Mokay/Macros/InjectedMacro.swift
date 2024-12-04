//
//  InjectedMacro.swift
//  Mokay
//
//  Created by Andrei Kozlov on 4/12/24.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftDiagnostics
import SwiftSyntaxMacros

@main
struct InjectedMacroPlugin: CompilerPlugin {
	var providingMacros: [any Macro.Type] {
		[InjectedMacro.self]
	}
}

public struct InjectedMacro: Macro {
	
	public static func expand(_ definition: MacroExpansionContext, _ declaration: DeclSyntax) -> DeclSyntax {
		guard let variableDecl = declaration.as(VariableDeclSyntax.self),
			  let binding = variableDecl.bindings.first,
			  let type = binding.typeAnnotation?.type.as(IdentifierTypeSyntax.self)?.name.text else {
			fatalError("Invalid use of @Injected. It must be applied to a let property with a specific type.")
		}
		
		let dependencyResolution = "Container.main.resolve(\(type).self)"
		
		// Генерация нового свойства с инициализацией из DIContainer
		return "\(variableDecl.bindingSpecifier) \(binding.pattern): \(raw: type) = \(raw: dependencyResolution)"
	}
}
