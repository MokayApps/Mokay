//
//  PostsServiceAssembly.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 6/12/24.
//

import MokayDI
import MokayNW
import Foundation

struct PostsServiceAssembly {
	
	func assemble(container: Container) {
		container.register(PostsServiceProtocol.self) { resolver in
			let httpClient = HTTPClient(interceptors: [], decoder: JSONDecoder())
			return PostsService(httpClient: httpClient)
		}
	}
}
