//
//  AppAssembly.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

import MokayDI

struct AppAssembly {
	
	func assemble(container: Container) {
		PlaceholderServiceAssembly().assemble(container: container)
		TodoListAssembly().assemble(container: container)
		PostsAssembly().assemble(container: container)
	}
}
