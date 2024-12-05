//
//  TodoItemViewModelFactory.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

protocol TodoItemViewModelFactoryProtocol: AnyObject, Sendable {
	
	func makeItemViewModel(from item: TodoItem) -> TodoItemViewModel
	
}

final class TodoItemViewModelFactory: TodoItemViewModelFactoryProtocol {
	
	func makeItemViewModel(from item: TodoItem) -> TodoItemViewModel {
		return TodoItemViewModel(
			id: item.id,
			title: item.title,
			isCompleted: item.completed
		)
	}
}
