//
//  PostsService.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 6/12/24.
//

import MokayNW

protocol PostsServiceProtocol: Sendable {
	
	func fetchPosts(request: PostRequest) async throws -> [PostItem]
}

struct PostsService: PostsServiceProtocol {
	
	private let httpClient: HTTPClient
	
	init(httpClient: HTTPClient) {
		self.httpClient = httpClient
	}
	
	func fetchPosts(request: PostRequest) async throws -> [PostItem] {
		try await httpClient.data(for: request)
	}

}
