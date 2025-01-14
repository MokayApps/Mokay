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
			MainActor.assumeIsolated {
				TodoListView(
					viewModel: TodoListViewModel(
						placeholderService: resolver.resolve(PlaceholderServiceProtocol.self)!,
						viewModelFactory: TodoItemViewModelFactory()
					)
				)
			}
		}
	}
}
