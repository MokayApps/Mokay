//
//  HTTPClient+Error.swift
//  Mokay
//
//  Created by Andrei Kozlov on 3/12/24.
//

extension HTTPClient {
	
	public enum Error: Swift.Error, Sendable {
		case badRequest
		case invalidResponse
		case failedResponse(statusCode: Int)
	}
	
}
