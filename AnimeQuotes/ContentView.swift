//
//  ContentView.swift
//  AnimeQuotes
//
//  Created by Lexi McQueen on 8/9/23.
//

import SwiftUI

struct ContentView: View {
    
    
    
    @State private var quote : QuoteModel?
    var body: some View {
        NavigationView {
            VStack (spacing: 30) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(quote?.character ?? "Character Name")
                            .font(.title)
                            .bold()
                        Text(quote?.anime ?? "The name of this anime is...")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(quote?.quote ?? "This is an anime quote. A very long anime quote indeed.")
                            .font(.body)
                            .italic()
                    }
                    Spacer()
                }.padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
                .padding()
            .navigationBarTitle("Anime Quotes")

        }
        .padding()
        .task {
            do {
                // set quote equal to the result of the network call
                quote = try await getQuote()
            } catch QuoteError.invalidURL {
                print("Invalid URL")
            } catch QuoteError.invalidData {
                print("Invalid Data")
            } catch QuoteError.invalidResponse {
                print("Invalid Response")
            } catch {
                print("Unexpected Error")
            }
        }
        
    }
    
    
    // throws because there are so many things that could go wrong during a network call
    
    // use URLSession
    // four main types of requests you can make, GET/POST/PUT(editing)/DELETE
    func getQuote() async throws -> QuoteModel {
        let endpoint = "https://animechan.xyz/api/random"
        
        // URL object
        
        guard let url = URL(string: endpoint) else {
            throw QuoteError.invalidURL
        }
        // returns data and the response
        // check the response and then
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // if you didn't get a 200 you can have specific errors
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw QuoteError.invalidResponse
        }
        
        // work with data after 200 to convert data to model
        do {
            let decoder = JSONDecoder()
            // keyDecoder strategy
            return try decoder.decode(QuoteModel.self, from: data)
        } catch {
            // if this fails you get invalidData after decoding
            // most decoding fails because it can't match property names directyl
            throw QuoteError.invalidData
        }

    }
    // 1. calling function, mark it async/throws
    // 2. need to know the endpoint we need to pass it to
    // 3. create a URL object from the string
    // 4. use the URLSession to get tuple data/response from the URL, downloads data
    // 5. check response for 200
    // 6. if it's good we can create a JSonDecoder and decode our JSON to our data model from the data
    // 7. if that works return it
}

// .task is good for asynchronous code

struct QuoteView: View {
    var body: some View {
        // container to add background and corner radius to
        VStack (spacing: 30) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Character Name")
                        .font(.title)
                        .bold()
                    Text("This is a very long quote. A very long quote indeed.")
                        .font(.title3)
                        .italic()
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// mainly doing this for decodablel
struct QuoteModel : Codable {
    let character : String
    let anime : String
    let quote : String
}

enum QuoteError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
