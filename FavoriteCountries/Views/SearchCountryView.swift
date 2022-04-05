//
//  SearchCountryView.swift
//  FavoriteCountries
//
//  Created by Carlos Morales III on 4/1/22.
//

import SwiftUI

struct SearchCountryView: View {
	@StateObject private var viewModel = SearchCountryViewModel()
	@Binding public var presentingSheet: Bool
	@State private var searchText: String = ""
	
    var body: some View {
		NavigationView {
			List {
				ForEach(viewModel.getSearchResults(from: searchText)) { country in
					NavigationLink(
						destination:
							CountryDetailsView(viewModel: CountryDetailsViewModel(selectedCountry: country),
								presentingSheet: $presentingSheet
							),
						label: {
							Text(country.name)
						})
				}
			}
			.searchable(text: $searchText)
			.disableAutocorrection(true)
			.toolbar {
				ToolbarItem(
					placement: .navigationBarLeading) {
						Button(
							action: {
								presentingSheet.toggle()
							},
							label: {
								Text("Cancel")
									.padding(.top, 10)
									.foregroundColor(.primary)
							}
						)
				}
			}
		}
		.navigationViewStyle(.stack)
    }
}

struct SearchCountryView_Previews: PreviewProvider {
    static var previews: some View {
		SearchCountryView(presentingSheet: .constant(true))
    }
}
