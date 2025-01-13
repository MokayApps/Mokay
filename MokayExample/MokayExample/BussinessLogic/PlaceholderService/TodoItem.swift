//
//  TodoItem.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

struct TodoItem: Sendable, Decodable {
	let userId: Int
	let id: Int
	let title: String
	let completed: Bool
}
