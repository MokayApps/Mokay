//
//  HTTPClient+RequestInterceptor.swift
//  Mokay
//
//  Created by Andrei Kozlov on 3/12/24.
//

import Foundation

extension HTTPClient {
	
	public protocol RequestInterceptor: Sendable {
		func intercept(request: URLRequest) async throws -> URLRequest
	}
	
}
