//
//  PostsAssembly.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 6/12/24.
//

import MokayDI

struct PostsAssembly {
	
	func assemble(container: Container) {
		container.register(PostsView.self) { resolver in
			PostsView(
				viewModel: PostsViewModel(
					postsService: resolver.resolve(PostsServiceProtocol.self)!,
					viewModelFactory:PostItemViewModelFactory()
				)
			)
		}
	}
}
