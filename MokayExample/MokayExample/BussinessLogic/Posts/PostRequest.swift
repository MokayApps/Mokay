//
//  PostRequest.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 6/12/24.
//

import MokayNW
import Foundation

enum PostRequest: Sendable {
	case posts
}

extension PostRequest: HTTPClient.Request {
	
	var baseUrl: URL {
		URL(string: "https://jsonplaceholder.typicode.com/")!
	}
	
	var endpoint: String {
		return "posts"
	}
	
	var method: MokayNW.HTTPClient.Method {
		.get
	}
	
}
