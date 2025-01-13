//
//  PlaceholderRequest.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

import Foundation
import MokayNW

enum PlaceholderRequest {
	case todo
	case posts
}

extension PlaceholderRequest: HTTPClient.Request {
	
	var baseUrl: URL {
		URL(string: "https://jsonplaceholder.typicode.com/")!
	}
	
	var endpoint: String {
		switch self {
		case .todo:
			"todos"
		case .posts:
			"posts"
		}
	}
	
	var method: MokayNW.HTTPClient.Method {
		.get
	}
}
