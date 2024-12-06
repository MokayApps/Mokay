//
//  Router.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

import SwiftUI
import MokayDI

@Observable final class Router: Sendable {

	let container: Container
	var path: NavigationPath = NavigationPath()
	
	init(
		container: Container
	) {
		self.container = container
	}
	
	// Builds the views
	@ViewBuilder func view(for route: Route) -> some View {
		switch route {
		case .todoList:
			container.resolve(TodoListView.self)
		case .todoItem:
			container.resolve(TodoItemView.self)
		}
	}
	
	func push(_ appRoute: Route) {
		path.append(appRoute)
	}
	
	func pop() {
		path.removeLast()
	}
	
	func popToRoot() {
		path.removeLast(path.count)
	}
}
