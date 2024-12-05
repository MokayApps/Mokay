//
//  TodoListViewModel.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

import SwiftUI

@Observable final class TodoListViewModel {
	
	private(set) var viewState: TodoListViewState = .idle
	
	private let todoService: TodoServiceProtocol
	private let viewModelFactory: TodoItemViewModelFactoryProtocol
	
	init(
		todoService: TodoServiceProtocol,
		viewModelFactory: TodoItemViewModelFactoryProtocol
	) {
		self.todoService = todoService
		self.viewModelFactory = viewModelFactory
	}
	
	func onAppear() {
		loadItems()
	}
	
	func onReloadButtonTap() {
		loadItems()
	}
	
	private func loadItems() {
		viewState = .loading
		Task {
			do {
				let todoItems = try await todoService.fetchTodos(request: .todo)
				let todoItemViewModels = todoItems.map(viewModelFactory.makeItemViewModel)
				viewState = .loaded(todoItemViewModels)
			} catch {
				viewState = .error
			}
		}
	}
}
