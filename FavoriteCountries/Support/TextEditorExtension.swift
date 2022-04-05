//
//  TextEditorExtension.swift
//  FavoriteCountries
//
//  Created by Carlos Morales III on 4/2/22.
//

import SwiftUI

extension View {
	@ViewBuilder public func hidden(_ shouldHide: Bool) -> some View {
		// For custom use of TextEditor caption
		switch shouldHide {
		case true:
			self.hidden()
		case false:
			self
		}
	}
}
 
