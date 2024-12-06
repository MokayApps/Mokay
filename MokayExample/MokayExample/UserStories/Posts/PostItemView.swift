//
//  PostItemView.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 6/12/24.
//

import SwiftUI

struct PostItemView: View {
	
	let viewModel: PostItemViewModel
	
	var body: some View {
		VStack(alignment: .leading) {
			Text(viewModel.title)
				.font(.title3.bold())
			Text(viewModel.body)
				.font(.body)
		}
		.multilineTextAlignment(.leading)
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 8)
				.fill(Color.gray.opacity(0.1))
		}
	}
}

#Preview {
	PostItemView(viewModel: PostItemViewModel(id: 0, title: "Some title", body: "Lorem ipsum"))
	PostItemView(viewModel: PostItemViewModel(id: 1, title: "Some large title bla bla bla bla", body: "Lorem ipsum"))
	PostItemView(viewModel: PostItemViewModel(id: 2, title: "Some title", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
}
