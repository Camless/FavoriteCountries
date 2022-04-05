//
//  CountryDetailsView.swift
//  FavoriteCountries
//
//  Created by Carlos Morales III on 4/1/22.
//

import SwiftUI

struct CountryDetailsView: View {
	@ObservedObject public var viewModel: CountryDetailsViewModel
	@State private var userFavoriteDetails: String = ""
	@Binding public var presentingSheet: Bool
    
	var body: some View {
		VStack {
			ZStack(alignment: .topLeading) {
				TextEditor(text: $userFavoriteDetails)
					.frame(height: 200)
					.border(Color(uiColor: .opaqueSeparator), width: 0.5)
					.foregroundColor(.primary)
					.disableAutocorrection(true)
				
				Text("My favorite things about \(viewModel.selectedCountry.name)")
					.fontWeight(.light)
					.foregroundColor(
						.gray.opacity(0.50))
					.padding()
					.hidden(!userFavoriteDetails.isEmpty)
			}
			.padding(.bottom, 50)
			
			Button(
				action: {
					viewModel.saveCountry(newCountry: &viewModel.selectedCountry, withDetails: userFavoriteDetails)
					presentingSheet.toggle()
				},
				label: {
					Text("Add")
						.frame(width: 100, height: 50, alignment: .center)
						.foregroundColor(.white)
						.background(Color.secondary)
						.cornerRadius(5)
				})
		}
		.navigationTitle(viewModel.selectedCountry.name)
		.navigationViewStyle(.stack)
    }
}

struct CountryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
		let newCountry = Country(name: "USA", details: "BBQ")
		CountryDetailsView(viewModel: CountryDetailsViewModel(selectedCountry: newCountry), presentingSheet: .constant(true))
    }
}
