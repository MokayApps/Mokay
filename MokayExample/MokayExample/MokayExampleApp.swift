//
//  MokayExampleApp.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 4/12/24.
//

import SwiftUI
import SwiftData

@main
struct MokayExampleApp: App {
    var sharedModelContainer: ModelContainer = {
		let schema = Schema(versionedSchema: DatabaseSchemaV2_0_0.self)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
			return try ModelContainer(
				for: schema,
				migrationPlan: DatabaseMigrationPlan.self,
				configurations: [modelConfiguration]
			)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
