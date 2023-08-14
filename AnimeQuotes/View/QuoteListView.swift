//
//  ContentView.swift
//  AnimeQuotes
//
//  Created by Lexi McQueen on 8/9/23.
//

import SwiftUI

struct QuoteListView: View {
    
    @State private var isPerformingTask = false
    
    @State private var quote : QuoteModel?
    var body: some View {
            VStack {
                VStack (spacing: 30) {
                    Text("Anime Quote")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    QuoteView()
                    
                }
                .padding()
                
                Button {
                    isPerformingTask = true
                    Task {
                        quote = try await getQuote()
                        isPerformingTask = false
                    }
                } label: {
                    Text("Generate a new quote!")
                        .padding()
                    Image(systemName: "hand.thumbsup.fill")
                        .padding()
                    
                }
                .cornerRadius(12)
            }
            
    }

    func getQuote() async throws -> QuoteModel {
        let endpoint = "https://animechan.xyz/api/random"
        
        guard let url = URL(string: endpoint) else {
            throw QuoteError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw QuoteError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(QuoteModel.self, from: data)
        } catch {
            throw QuoteError.invalidData
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteListView()
    }
}

