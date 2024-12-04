//
//  Scope.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 4/12/24.
//

extension Container {
	
	public enum Scope: String, Sendable {
		/// A new instance should be created at every `.resolve(...)`.
		case transient
		/// A new instance should be created once per container.
		case container
	}
	
}

