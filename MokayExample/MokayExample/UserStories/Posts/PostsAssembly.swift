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
			MainActor.assumeIsolated {
				PostsView(
					viewModel: PostsViewModel(
						placeholderService: resolver.resolve(PlaceholderServiceProtocol.self)!,
						viewModelFactory:PostItemViewModelFactory()
					)
				)
			}
		}
	}
}
