//
//  SearchCountryViewModel.swift
//  FavoriteCountries
//
//  Created by Carlos Morales III on 4/1/22.
//

import Foundation

class SearchCountryViewModel: ObservableObject {
	@Published var currentCountries = [Country]()
	
	init() {
		makeNetworkRequest()
	}
	
	public func getSearchResults(from searchText: String) -> [Country] {
		if searchText.isEmpty {
			return currentCountries.sorted()
		} else {
			return currentCountries.filter { $0.name.contains(searchText) }.sorted()
		}
	}
	
	private func makeNetworkRequest() {
		// Documentation for general structuring of queries found here: https://datahelpdesk.worldbank.org/knowledgebase/articles/898581-api-basic-call-structures
		// Documentation for API country queries found here: https://datahelpdesk.worldbank.org/knowledgebase/articles/898590-country-api-queries
		
		for page in 1...6 {
			if let url = URL(string: "https://api.worldbank.org/v2/countries?format=json&page=" + String(page)) {
				var request = URLRequest(url: url)
				request.httpMethod = "GET"
				
				URLSession.shared.dataTask(with: request) { data, response, error in
					guard error == nil else {
						print("Error downloading data: " + String(describing: error))
						return
					}
					
					guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
						print("Error with HTTP Response: " + String(describing: error))
						return
					}
					
					if let data = data {
						do {
							if let jsonData = try JSONSerialization.jsonObject(with: data) as? [Any] {
								if let countries = jsonData[1] as? [[String: Any]] {
									for country in countries {
										if let capitalCity = country["capitalCity"] as? String, !capitalCity.isEmpty {
											if let countryData = try? JSONSerialization.data(withJSONObject: country) {
												if let countryDecodable = try? JSONDecoder().decode(Country.self, from: countryData) {
													DispatchQueue.main.async {
														self.currentCountries.append(countryDecodable)
													}
												}
											}
										}
									}
								}
							}
						} catch {
							print("JSON Serialization failed: " + String(describing: error))
							return
						}
					} else {
						print("Unable to unwrap data from dataTask: " + String(describing: error))
						return
					}
				}.resume()
			}
		}
	}
}
