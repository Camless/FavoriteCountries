//
//  HomeViewCell.swift
//  FavoriteCountries
//
//  Created by Carlos Morales III on 4/1/22.
//

import SwiftUI

struct HomeViewCell: View {
	@State var country: Country
	
    var body: some View {
		VStack {
			HStack {
				Text(country.name)
				Spacer()
			}
			HStack {
				Text("Details: \(country.userFavoriteDetails)")
				Spacer()
			}
		}
		
		
    }
}

struct HomeViewCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewCell(country: Country(name: "USA", details: "BBQ"))
    }
}
