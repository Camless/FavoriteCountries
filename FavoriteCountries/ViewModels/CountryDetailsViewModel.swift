//
//  CountryDetailsViewModel.swift
//  FavoriteCountries
//
//  Created by Carlos Morales III on 4/4/22.
//

import Foundation

class CountryDetailsViewModel: ObservableObject {
	private let sharedPersistenceController = PersistenceController.shared
	var selectedCountry: Country
	
	init(selectedCountry: Country) {
		self.selectedCountry = selectedCountry
	}
	
	public func saveCountry(newCountry: inout Country, withDetails details: String) {
		newCountry.addDetails(details)
		sharedPersistenceController.addData(newCountry)
	}
	
}
