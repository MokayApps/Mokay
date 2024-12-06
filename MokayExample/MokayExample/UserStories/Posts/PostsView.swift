//
//  PostsView.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 6/12/24.
//

import SwiftUI

struct PostsView: View {
	
	@Environment(Router.self) var router
	let viewModel: PostsViewModel

	var body: some View {
		ZStack {
			switch viewModel.viewState {
			case .idle:
				Color.white
					.onAppear(perform: viewModel.onAppear)
			case .loading:
				Color.white
				ProgressView {
					Text("Load data...")
				}
				.progressViewStyle(.circular)
			case .loaded(let items):
				ScrollView {
					LazyVStack {
						ForEach(items) { item in
							Button {
								router.push(.todoItem)
							} label: {
								PostItemView(viewModel: item)
							}
						}
					}
					.padding(.horizontal, 8)
				}
			case .error:
				ContentUnavailableView {
					Label("No posts", systemImage: "newspaper")
				} description: {
					VStack {
						Text("New posts you receive will appear here.")
						Button {
							viewModel.onReloadButtonTap()
						} label: {
							Text("Reload")
						}
					}
				}
			}
		}
		.navigationTitle("Posts")
	}
}
