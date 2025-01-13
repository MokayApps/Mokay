//
//  PostItemViewModelFactory.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 6/12/24.
//

protocol PostItemViewModelFactoryProtocol: Sendable {
	
	func makePostItemViewModel(from post: PostItem) -> PostItemViewModel
}

struct PostItemViewModelFactory: PostItemViewModelFactoryProtocol {
	
	func makePostItemViewModel(from post: PostItem) -> PostItemViewModel {
		PostItemViewModel(id: post.id, title: post.title, body: post.body)
	}
}
