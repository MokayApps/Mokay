//
//  AppAssembly.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

import MokayDI

struct AppAssembly {
	
	func assemble(container: Container) {
		TodoServiceAssembly().assemble(container: container)
		TodoListAssembly().assemble(container: container)
		PostsServiceAssembly().assemble(container: container)
		PostsAssembly().assemble(container: container)
	}
}
