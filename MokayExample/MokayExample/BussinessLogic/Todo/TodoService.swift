//
//  TodoService.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 4/12/24.
//

import MokayNW

protocol TodoServiceProtocol: AnyObject, Sendable {
	
	func fetchTodos(request: TodoRequest) async throws -> [TodoItem]
}

final class TodoService: TodoServiceProtocol {
	
	private let httpClient: HTTPClient
	
	init(httpClient: HTTPClient) {
		self.httpClient = httpClient
	}
	
	func fetchTodos(request: TodoRequest) async throws -> [TodoItem] {
		try await httpClient.data(for: request)
	}

}
