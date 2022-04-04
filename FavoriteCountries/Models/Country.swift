//
//  CountryModel.swift
//  FavoriteCountries
//
//  Created by Carlos Morales III on 4/1/22.
//

import Foundation

struct Country: Identifiable, Comparable, Codable {
	var id = UUID()
	var name: String
	var userFavoriteDetails: String = ""
	
	init(name: String, details: String) {
		self.name = name
		userFavoriteDetails = details
	}
	
	private enum CodingKeys: String, CodingKey {
		case name
	}
	
	static func < (lhs: Country, rhs: Country) -> Bool {
		if lhs.name < rhs.name {
			return true
		}
		
		return false
	}
}
