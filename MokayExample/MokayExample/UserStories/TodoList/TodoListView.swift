//
//  TodoListView.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

import SwiftUI

struct TodoListView: View {
	
	let viewModel: TodoListViewModel
	
	var body: some View {
		NavigationSplitView {
			switch viewModel.viewState {
			case .idle:
				Color.primary
			case .loading:
				ZStack {
					Color.primary
					ProgressView {
						Text("Load data...")
					}
					.progressViewStyle(.circular)
				}
			case .loaded(let items):
				List {
					ForEach(items) { item in
						NavigationLink {
							TodoItemView(viewModel: item)
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
				ContentUnavailableView.search
				ContentUnavailableView {
					Label("No items", systemImage: "tray.fill")
				} description: {
					Text("New items you receive will appear here.")
				}
			}
			
		} detail: {
			Text("Select an item")
		}
		.onAppear(perform: viewModel.onAppear)
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
