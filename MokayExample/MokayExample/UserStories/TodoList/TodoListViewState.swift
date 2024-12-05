//
//  TodoListViewState.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

enum TodoListViewState: Sendable {
	case idle
	case loading
	case loaded([TodoItemViewModel])
	case error
}
