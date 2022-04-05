//
//  PersistenceController.swift
//  FavoriteCountries
//
//  Created by Carlos Morales III on 4/3/22.
//

import Foundation
import CoreData

class PersistenceController: ObservableObject {
	var savedData: [CountryModel] = []
	static let shared = PersistenceController()
	let container: NSPersistentContainer
	
	init() {
		container = NSPersistentContainer(name: "Model")
		container.loadPersistentStores { description, error in
			if let error = error {
				fatalError("Core Data failed to load: \(String(describing: error))")
			}
		}
		
		// Pre-populate the saved data so that view models do not have to invoke this function, thereby keeping separation of model and VM.
		fetchData()
	}
	
	func saveData() {
		let context = container.viewContext
		
		if context.hasChanges {
			do {
				try context.save()
				fetchData()
			} catch {
				fatalError("View Context could not save changes: \(String(describing: error))")
			}
		}
	}
	
	func fetchData() {
		/*
		 The View Models which rely on Core Data model fetching should be performing sorting for their respective views. Adding Sort
		 Descriptors to NSFetchRequest will cause undefined behavior in the addition of new models to the UI within the user session.
		 */
		let request = NSFetchRequest<CountryModel>(entityName: "CountryModel")
		
		do {
			try savedData = container.viewContext.fetch(request)
		} catch {
			print("Error getting data: \(String(describing: error))")
		}
	}
	
	func addData(_ dataToSave: Country) {
		let newCountryModel = CountryModel(context: container.viewContext)
		newCountryModel.name = dataToSave.name
		newCountryModel.userFavoriteDetails = dataToSave.userFavoriteDetails
		newCountryModel.id = dataToSave.id
		
		saveData()
	}
}
