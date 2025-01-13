//
//  PostsViewModel.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 6/12/24.
//

import SwiftUI

@Observable final class PostsViewModel {
	
	private(set) var viewState: PostsViewState = .idle
	
	private let placeholderService: PlaceholderServiceProtocol
	private let viewModelFactory: PostItemViewModelFactoryProtocol
	
	init(
		placeholderService: PlaceholderServiceProtocol,
		viewModelFactory: PostItemViewModelFactoryProtocol
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
				let posts = try await placeholderService.fetchPosts(request: .posts)
				let postViewModels = posts.map(viewModelFactory.makePostItemViewModel)
				viewState = .loaded(postViewModels)
			} catch {
				viewState = .error
			}
		}
	}
}
