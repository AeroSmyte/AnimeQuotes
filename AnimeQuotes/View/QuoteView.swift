//
//  QuoteView.swift
//  AnimeQuotes
//
//  Created by Lexi McQueen on 8/9/23.
//

import SwiftUI

struct QuoteView: View {
    var body: some View {
        VStack (spacing: 30) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Character Name")
                        .font(.title)
                        .bold()
                    Text("The name of this anime is...")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("This is a very long quote. A very long quote indeed.")
                        .font(.title3)
                        .italic()
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding()
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
        
        
    }
}


struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}
