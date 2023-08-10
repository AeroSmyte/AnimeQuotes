////
////  QuoteView.swift
////  AnimeQuotes
////
////  Created by Lexi McQueen on 8/9/23.
////
//
//import SwiftUI
//
//struct QuoteView: View {
//    var body: some View {
//        
//        // container to add background and corner radius to
//        GeometryReader { geometry in
//            
//            HStack {
//                VStack(alignment: .leading, spacing: 6) {
//                    Text("Character Name")
//                        .font(.title)
//                        .bold()
//                    Text("This is a very long quote. A very long quote indeed.")
//                        .font(.title3)
//                        .italic()
//                        .foregroundColor(.gray)
//                }
//            }
//            .padding(.horizontal)
//            .background(Color.white)
//            .cornerRadius(10)
//            .shadow(radius: 5)
//        }
//        
//        Spacer()
//
//        
//    }
//    
//}
//
//// 4
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteView().padding()
//    }
//}
