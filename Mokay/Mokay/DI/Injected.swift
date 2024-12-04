//
//  Injected.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 4/12/24.
//

@propertyWrapper public final class Injected<T> {
		
	private let name: String?
	
	public var wrappedValue: T {
		if let value = Container.main.resolve(T.self, name: name) {
			return value
		}
		preconditionFailure("Unable to resolve service of type \(T.self) with identifier \(name ?? "nil")")
	}
	
	public init(_ name: String? = nil) {
		self.name = name
	}
}
