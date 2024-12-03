//
//  LoggingRequestInterceptor.swift
//  Mokay
//
//  Created by Andrei Kozlov on 3/12/24.
//

import Foundation
import os

public struct LoggingRequestInterceptor: HTTPClient.RequestInterceptor {
	
	private let logger: Logger
	
	public init(logger: Logger) {
		self.logger = logger
	}
	
	public func intercept(request: URLRequest) async throws -> URLRequest {
		logger.log(level: .debug, "\(request.debugDescription)")
		return request
	}
	
}
