//
//  TodoRequest.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

import Foundation
import MokayNW

enum TodoRequest {
	case todo
}

extension TodoRequest: HTTPClient.Request {
	
	var baseUrl: URL {
		URL(string: "https://jsonplaceholder.typicode.com/")!
	}
	
	var endpoint: String {
		return "todos"
	}
	
	var method: MokayNW.HTTPClient.Method {
		.get
	}
}
