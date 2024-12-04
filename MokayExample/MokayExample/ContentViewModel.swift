//
//  ContentViewModel.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 4/12/24.
//

import SwiftUI
import Mokay

@Observable final class ContentViewModel {
	
	@ObservationIgnored var todoService: TodoServiceProtocol
	
	init(todoService: TodoServiceProtocol) {
		self.todoService = todoService
	}
}
