//
//  Database.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 4/12/24.
//

import SwiftData
import Foundation

@ModelActor
public actor Database {

	public init(versionedSchema: VersionedSchema.Type, configurations: ModelConfiguration) throws {
		let schema = Schema(versionedSchema: versionedSchema)
		let modelContainer = try ModelContainer(for: schema, configurations: configurations)
		let modelContext = ModelContext(modelContainer)
		modelContext.autosaveEnabled = false
		self.modelExecutor = DefaultSerialModelExecutor(modelContext: modelContext)
		self.modelContainer = modelContainer
	}

	public func fetch<Model: PersistentModel>(
		predicate: Predicate<Model>? = nil,
		sortBy descriptors: [SortDescriptor<Model>] = []
	) throws -> [Model] {
		let fetchDescriptor = FetchDescriptor<Model>(predicate: predicate, sortBy: descriptors)
		return try modelContext.fetch(fetchDescriptor)
	}

	public func insert(model: some PersistentModel) {
		modelContext.insert(model)
	}

	public func delete(model: some PersistentModel) {
		modelContext.delete(model)
	}

	public func delete<Model: PersistentModel>(type: Model.Type, predicate: Predicate<Model>, includeSubsclasses: Bool) throws {
		try modelContext.delete(model: type, where: predicate, includeSubclasses: includeSubsclasses)
	}

	/// Update properties of SwiftData models.
	///
	/// Use this to update models in any thread. Don't modify models without this method.
	public func update(updateBlock: () -> Void) {
		updateBlock()
	}

	public func save() throws {
		guard modelContext.hasChanges else { return }
		try modelContext.save()
	}

}
