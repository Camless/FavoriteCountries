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
		self.userFavoriteDetails = details
	}
	
	private enum CodingKeys: CodingKey {
		case name
	}
	
	mutating public func addDetails(_ details: String) {
		userFavoriteDetails = details
	}
	
	static func < (lhs: Country, rhs: Country) -> Bool {
		if lhs.name < rhs.name {
			return true
		} else {
			return false
		}
	}
	
}
