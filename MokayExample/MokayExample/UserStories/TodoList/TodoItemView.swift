//
//  TodoItemView.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

import SwiftUI

struct TodoItemView: View {
	
	let viewModel: TodoItemViewModel
	
	var body: some View {
		HStack {
			Text(viewModel.title)
			Spacer()
			if viewModel.isCompleted {
				Image(systemName: "checkmark.circle.fill")
					.foregroundStyle(.green)
			} else {
				Image(systemName: "circle")
			}
		}
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 16)
				.fill(Color.white)
				.strokeBorder(.black, lineWidth: 1.0, antialiased: true)
		}
	}
}

#Preview {
	TodoItemView(viewModel: TodoItemViewModel(id: 0, title: "Mock title", isCompleted: true))
	TodoItemView(viewModel: TodoItemViewModel(id: 1, title: "Mock title", isCompleted: false))
}
