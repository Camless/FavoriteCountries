//
//  HomeViewViewModel.swift
//  FavoriteCountries
//
//  Created by Carlos Morales III on 4/1/22.
//

import UIKit

class HomeViewViewModel: ObservableObject {
	@Published var currentLikedCountries = [Country]()
	private let sharedPersistenceController = PersistenceController.shared
	
	init() {
		fetchSavedCountries()
	}
	
	public func fetchSavedCountries() {
		let fetchedCountryModels = sharedPersistenceController.savedData
		var savedCountries = [Country]()
		
		for fetchedCountry in fetchedCountryModels {
			let newCountry = Country(name: fetchedCountry.name!, details: fetchedCountry.userFavoriteDetails!)
			savedCountries.append(newCountry)
		}
		
		currentLikedCountries = savedCountries.sorted()
	}
	
	public func addNewCountry() {
		let lastAddedCountryModel = sharedPersistenceController.savedData.last!
		let newCountry = Country(name: lastAddedCountryModel.name!, details: lastAddedCountryModel.userFavoriteDetails!)
		currentLikedCountries.append(newCountry)
		currentLikedCountries.sort()
	}
}
