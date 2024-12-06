//
//  PostItem.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 6/12/24.
//

struct PostItem: Sendable, Decodable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
}
