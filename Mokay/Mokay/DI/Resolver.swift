//
//  Resolver.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 4/12/24.
//

final class Resolver {
	
	let scope: Container.Scope
	let factory: (Container) -> Any
	var cachedValue: Any?
	
	init(scope: Container.Scope, factory: @escaping (Container) -> Any) {
		self.scope = scope
		self.factory = factory
		self.cachedValue = nil
	}
	
	func resolve<T>(in container: Container) -> T {
		switch scope {
		case .transient:
			let value = factory(container)
			return typecast(value)
		case .container:
			if let cachedValue {
				return typecast(cachedValue)
			} else {
				cachedValue = factory(container)
				return typecast(cachedValue)
			}
		}
	}
	
	private func typecast<T>(_ value: Any?) -> T {
		if let value = value as? T {
			return value
		}
		preconditionFailure("Internal storage type (\(T.self) mismatch.")
	}
	
}
