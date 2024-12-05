//
//  DatabaseSchemaV2_0_0.swift
//  MokayExample
//
//  Created by Andrei Kozlov on 4/12/24.
//

import SwiftData

enum DatabaseSchemaV2_0_0: VersionedSchema {
	static var versionIdentifier = Schema.Version(2, 0, 0)
	
	static var models: [any PersistentModel.Type] {
		[Item.self]
	}
}
