//
//  QuoteModel.swift
//  AnimeQuotes
//
//  Created by Lexi McQueen on 8/14/23.
//

import Foundation

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
