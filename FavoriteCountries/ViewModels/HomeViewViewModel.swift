//
//  HomeViewViewModel.swift
//  FavoriteCountries
//
//  Created by Carlos Morales III on 4/1/22.
//

import Foundation

class HomeViewViewModel: ObservableObject {
	@Published var currentLikedCountries = [Country]()
}
