//
//  PlaceholderServiceAssembly.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 5/12/24.
//

import MokayDI
import MokayNW
import Foundation

struct PlaceholderServiceAssembly {
	
	func assemble(container: Container) {
		container.register(PlaceholderServiceProtocol.self) { resolver in
			let httpClient = HTTPClient(interceptors: [], decoder: JSONDecoder())
			return PlaceholderService(httpClient: httpClient)
		}
	}
}
