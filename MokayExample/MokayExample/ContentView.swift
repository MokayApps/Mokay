//
//  ContentView.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 4/12/24.
//

import SwiftUI
import SwiftData
import MokayNW

struct ContentView: View {
    
    var body: some View {
		TodoListView(
			viewModel: TodoListViewModel(
				todoService: TodoService(httpClient: HTTPClient(interceptors: [], decoder: JSONDecoder())),
				viewModelFactory: TodoItemViewModelFactory()
			)
		)
    }

}

#Preview {
    ContentView()
}
