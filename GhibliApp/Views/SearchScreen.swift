//
//  SearchScreen.swift
//  GhibliApp
//
//  Created by Daria Yatsyniuk on 25.11.2025.
//

import SwiftUI

struct SearchScreen: View {
    @State private var text = ""
    var body: some View {
        NavigationStack {
            Text("show search here")
                .searchable(text: $text)
        }
    }
}

#Preview {
    SearchScreen()
}
