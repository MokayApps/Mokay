//
//  Container.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 4/12/24.
//

import Foundation
import os

public final class Container: Sendable {

	/// The main service container.
	public static let main = Container()
	
	private let parent: Container?
	private let store = OSAllocatedUnfairLock<[Key: Resolver]>(uncheckedState: [:])

	public init(parent: Container? = nil) {
		self.parent = parent
	}
	
	public func register<T: Sendable>(
		_ scope: Scope = .transient,
		to type: T.Type = T.self,
		name: String? = nil,
		factory: @escaping @Sendable (Container) -> T
	) {
		store.withLock { storage in
			storage[Key(type: type, name: name)] = Resolver(scope: scope, factory: factory)
		}
	}
	
	public func resolve<T: Sendable>(
		_ type: T.Type = T.self,
		name: String? = nil
	) -> T? {
		return store.withLock { storage in
			let value: T? = storage[Key(type: type, name: name)]?.resolve(in: self)
			return value ?? parent?.resolve(name: name)
		}
	}
	
}

extension Container {
	
	fileprivate struct Key: Hashable, Sendable {
		let type: String
		let name: String?
		
		init(type: Any.Type, name: String?) {
			self.type = String(describing: type)
			self.name = name
		}
	}
	
}

