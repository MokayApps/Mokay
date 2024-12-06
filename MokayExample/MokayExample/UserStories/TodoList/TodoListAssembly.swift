//
//  TodoListAssembly.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

import MokayDI

struct TodoListAssembly {
	
	func assemble(container: Container) {
		container.register(TodoListView.self) { resolver in
			TodoListView(
				viewModel: TodoListViewModel(
					todoService: resolver.resolve(TodoServiceProtocol.self)!,
					viewModelFactory: TodoItemViewModelFactory()
				)
			)
		}
	}
}
