//
//  MainView.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 6/12/24.
//

import SwiftUI
import MokayDI

enum MainTab: Int {
	case todoList
	case posts
	case albums
}

struct MainView: View {

	@State var todoListRouter: Router = Router(container: Container.main)
	@State var postsRouter: Router = Router(container: Container.main)
	@State var albumsRouter: Router = Router(container: Container.main)
	
	@State var selectedTab: MainTab = .todoList
	
	var body: some View {
		TabView(selection: $selectedTab) {
			Tab("Todo", systemImage: "list.bullet.circle", value: .todoList) {
				NavigationStack(path: $todoListRouter.path) {
					todoListRouter.view(for: .todoList)
						.navigationDestination(for: Route.self) { route in
							todoListRouter.view(for: route)
						}
				}
				.environment(todoListRouter)
			}

			Tab("Posts", systemImage: "newspaper", value: .posts) {
				NavigationStack(path: $todoListRouter.path) {
					todoListRouter.view(for: .posts)
						.navigationDestination(for: Route.self) { route in
							todoListRouter.view(for: route)
						}
				}
				.environment(postsRouter)
			}
			.badge(2)

			Tab("Albums", systemImage: "person.2.crop.square.stack", value: .albums) {
				NavigationStack(path: $todoListRouter.path) {
					todoListRouter.view(for: .todoList)
						.navigationDestination(for: Route.self) { route in
							todoListRouter.view(for: route)
						}
				}
				.environment(albumsRouter)
			}
			.badge("!")
		}
	}
}
