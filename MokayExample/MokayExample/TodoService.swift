//
//  TodoService.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 4/12/24.
//

import Mokay
//import MokayMacros

protocol TodoServiceProtocol: AnyObject, Sendable {
	
	func fetchTodos()
}

final class TodoService: TodoServiceProtocol {
	
	@Injected private var httpClient: HTTPClient
	
	
	func fetchTodos() {
		
	}

}
