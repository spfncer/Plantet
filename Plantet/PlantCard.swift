//
//  PlantCard.swift
//  Plantet
//
//  Created by Spencer Fasulo on 12/16/23.
//

import SwiftUI

struct PlantCard: View{
    let name: String
    let len: Int
    let status: Bool
    var body: some View{
        ZStack{
            Image("Plant Placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(LinearGradient(gradient: Gradient(stops: [
                    .init(color: .clear, location: 0),
                    .init(color: .clear, location: 0.8),
                    .init(color: .black, location: 1)
                ]), startPoint: .top, endPoint: .bottom))
            VStack(alignment: .leading){
                Spacer()
                Text(name)
                    .font(.headline)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(.leading)
                    .foregroundColor(.white)
                Text(String(len))
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding([.leading, .bottom])
                    .foregroundColor(.white)
            }
        }
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
        .frame(width:200, height: 200)
    }
}
