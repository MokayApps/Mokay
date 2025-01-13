//
//  TodoListViewModel.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

import SwiftUI
import MokayDI

@Observable final class TodoListViewModel {
	
	private(set) var viewState: TodoListViewState = .idle
	
	private let placeholderService: PlaceholderServiceProtocol
	private let viewModelFactory: TodoItemViewModelFactoryProtocol
	
	init(
		placeholderService: PlaceholderServiceProtocol,
		viewModelFactory: TodoItemViewModelFactoryProtocol
	) {
		self.placeholderService = placeholderService
		self.viewModelFactory = viewModelFactory
	}
	
	func onAppear() {
		viewState = .error
//		loadItems()
	}
	
	func onReloadButtonTap() {
		loadItems()
	}
	
	private func loadItems() {
		viewState = .loading
		Task {
			do {
				let todoItems = try await placeholderService.fetchTodos(request: .todo)
				let todoItemViewModels = todoItems.map(viewModelFactory.makeItemViewModel)
				viewState = .loaded(todoItemViewModels)
			} catch {
				viewState = .error
			}
		}
	}
}
