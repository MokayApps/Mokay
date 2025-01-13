//
//  PostsViewState.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 6/12/24.
//

enum PostsViewState {
	case idle
	case loading
	case loaded([PostItemViewModel])
	case error
}
