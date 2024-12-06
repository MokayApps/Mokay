//
//  TodoListView.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

import SwiftUI

struct TodoListView: View {
	
	@Environment(Router.self) var router
	let viewModel: TodoListViewModel
	
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
				List {
					ForEach(items) { item in
						Button {
							router.push(.todoItem)
						} label: {
							TodoItemView(viewModel: item)
						}
					}
					.onDelete(perform: deleteItems)
				}
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						EditButton()
					}
					ToolbarItem {
						Button(action: addItem) {
							Label("Add Item", systemImage: "plus")
						}
					}
				}
			case .error:
				ContentUnavailableView {
					Label("No items", systemImage: "arrow.2.circlepath")
				} description: {
					VStack {
						Text("New items you receive will appear here.")
						Button {
							viewModel.onReloadButtonTap()
						} label: {
							Text("Reload")
						}
					}
				}
			}
		}
		.navigationTitle("Todo list")
	}
	
	private func addItem() {
		withAnimation {
			
		}
	}

	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			
		}
	}
}
