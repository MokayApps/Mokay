//
//  TodoServiceAssembly.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

import MokayDI
import MokayNW
import Foundation

struct TodoServiceAssembly {
	
	func assemble(container: Container) {
		container.register(TodoServiceProtocol.self) { resolver in
			let httpClient = HTTPClient(interceptors: [], decoder: JSONDecoder())
			return TodoService(httpClient: httpClient)
		}
	}
}
