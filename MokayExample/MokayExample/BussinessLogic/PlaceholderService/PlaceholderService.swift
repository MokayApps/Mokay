//
//  PlaceholderService.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 6/12/24.
//

import MokayNW

protocol PlaceholderServiceProtocol: Sendable {
	
	func fetchTodos(request: PlaceholderRequest) async throws -> [TodoItem]
	func fetchPosts(request: PlaceholderRequest) async throws -> [PostItem]

}

struct PlaceholderService: PlaceholderServiceProtocol {
	
	private let httpClient: HTTPClient
	
	init(httpClient: HTTPClient) {
		self.httpClient = httpClient
	}
	
	func fetchTodos(request: PlaceholderRequest) async throws -> [TodoItem] {
		try await httpClient.data(for: request)
	}
	
	func fetchPosts(request: PlaceholderRequest) async throws -> [PostItem] {
		try await httpClient.data(for: request)
	}

}
