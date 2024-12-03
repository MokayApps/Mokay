//
//  Network.swift
//  Mokay
//
//  Created by akozlov on 18.11.2024.
//

import Foundation

public final class HTTPClient: Sendable {
	
	private let session: URLSession
	private let interceptors: [any RequestInterceptor]
	private let decoder: JSONDecoder
	
	public init(
		session: URLSession = .shared,
		interceptors: [any RequestInterceptor],
		decoder: JSONDecoder
	) {
		self.session = session
		self.interceptors = interceptors
		self.decoder = decoder
	}
	
	public func data<Response: Decodable>(for request: Request) async throws -> Response {
		guard let url = URL(string: request.baseUrl.absoluteString + request.endpoint) else {
			throw Error.badRequest
		}
		var urlRequest = URLRequest(
			url: url,
			cachePolicy: .useProtocolCachePolicy,
			timeoutInterval: TimeInterval(floatLiteral: 30.0)
		)
		urlRequest.httpMethod = request.method.rawValue
		urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.headers?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
		urlRequest.httpBody = request.body
		
		for interceptor in interceptors {
			urlRequest = try await interceptor.intercept(request: urlRequest)
		}
		
		let (data, response) = try await session.data(for: urlRequest)
		guard let httpResponse = response as? HTTPURLResponse else {
			throw Error.invalidResponse
		}
		guard (200...299).contains(httpResponse.statusCode) else {
			throw Error.failedResponse(statusCode: httpResponse.statusCode)
		}
		return try decoder.decode(Response.self, from: data)
	}

}
