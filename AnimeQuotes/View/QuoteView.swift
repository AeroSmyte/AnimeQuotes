//
//  QuoteView.swift
//  AnimeQuotes
//
//  Created by Lexi McQueen on 8/9/23.
//

import SwiftUI

struct QuoteView: View {
    @State private var isPerformingTask = false
    
    @State private var animate = false

    @State private var quote : QuoteModel?
    
    var body: some View {
        VStack (spacing: 30) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(quote?.character ?? "The person who said this...")
                        .font(.title)
                        .bold()
                    Text(quote?.anime ?? "The anime it came from...")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text(quote?.quote ?? "The person who said this...")
                        .font(.title3)
                        .italic()
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding()
            
            Button {
                isPerformingTask.toggle()
                Task {
                    quote = try await getQuote()
                    isPerformingTask.toggle()
                }
                
            } label: {
                HStack(spacing: 10) {
                    Text("New Quote!")
                    Image(systemName: "arrow.clockwise")
                }
                .foregroundColor(.white)
                .font(.headline)
                .padding(20)
                .background(Color.indigo)
                .cornerRadius(10)

            }
            .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
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


struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}
