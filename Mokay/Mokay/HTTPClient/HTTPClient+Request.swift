//
//  HTTPClient+Request.swift
//  Mokay
//
//  Created by Andrei Kozlov on 3/12/24.
//
import Foundation

extension HTTPClient {
	
	public protocol Request: Sendable {
		var baseUrl: URL { get }
		var endpoint: String { get }
		var method: Method { get }
		var body: Data? { get }
		var headers: [String: String]? { get }
	}
	
	public enum Method: String, CaseIterable, Sendable {
		case get = "GET"
		case post = "POST"
		case patch = "PATCH"
		case put = "PUT"
		case delete = "DELETE"
		case head = "HEAD"
		case options = "OPTIONS"
	}
	
}

extension HTTPClient.Request {
	
	var body: Data? { nil }
	var headers: [String: String]? { nil }
	
}
