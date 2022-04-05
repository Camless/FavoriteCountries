//
//  ContentView.swift
//  FavoriteCountries
//
//  Created by Carlos Morales III on 4/1/22.
//

import SwiftUI

struct HomeView: View {
	@StateObject private var viewModel = HomeViewViewModel()
	@State private var presentingSheet: Bool = false
	
    var body: some View {
		NavigationView {
			List {
				ForEach(viewModel.currentLikedCountries) { country in
					HomeViewCell(country: country)
				}
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(
						action: {
							presentingSheet.toggle()
						},
						label: {
							Text("Add Country")
								.foregroundColor(.primary)
						})
					}
			}
			.fullScreenCover(isPresented: $presentingSheet) {
				viewModel.addNewCountry()
			} content: {
				SearchCountryView(presentingSheet: $presentingSheet)
			}
			.navigationTitle("Favorite Countries")
		}
		.navigationViewStyle(.stack)
	}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
		HomeView()
    }
}
