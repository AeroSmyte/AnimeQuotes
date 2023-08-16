//
//  ContentView.swift
//  AnimeQuotes
//
//  Created by Lexi McQueen on 8/9/23.
//

import SwiftUI

struct QuoteListView: View {
    
    @State private var isPerformingTask = false
    
    var body: some View {
        NavigationView {
            VStack {
                QuoteView()
                    .cornerRadius(12)
                    .shadow(radius: 5)

                Spacer()
            }
            .padding()
            .navigationTitle("Anime Quotes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteListView()
    }
}

