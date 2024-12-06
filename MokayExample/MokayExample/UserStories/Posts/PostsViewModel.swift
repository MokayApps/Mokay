//
//  PostsViewModel.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 6/12/24.
//

import SwiftUI

@Observable final class PostsViewModel {
	
	private(set) var viewState: PostsViewState = .idle
	
	private let postsService: PostsServiceProtocol
	private let viewModelFactory: PostItemViewModelFactoryProtocol
	
	init(
		postsService: PostsServiceProtocol,
		viewModelFactory: PostItemViewModelFactoryProtocol
	) {
		self.postsService = postsService
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
				let posts = try await postsService.fetchPosts(request: .posts)
				let postViewModels = posts.map(viewModelFactory.makePostItemViewModel)
				viewState = .loaded(postViewModels)
			} catch {
				viewState = .error
			}
		}
	}
}
