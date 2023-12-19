//
//  PlantCard.swift
//  Plantet
//
//  Created by Spencer Fasulo on 12/16/23.
//

import SwiftUI

struct PlantCard: View{
    @State var expanded = false
    static var id = 0
    let name: String
    let len: Int
    let status: Bool
    var localID = 0
    
    mutating func PlantCard(){
        localID = Plantet.PlantCard.id
        Plantet.PlantCard.id+=1
    }
    
    var body: some View{
            VStack{
                Image("Plant Placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .shadow(radius: 5)
                VStack(alignment: .leading){
                    Spacer()
                    Text(name)
                        .font(.headline)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .padding(.leading)
                        .foregroundColor(Color("TextColor"))
                    Text(String(len))
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .padding([.leading, .bottom])
                        .foregroundColor(Color("TextColor"))
                }
            }
            .frame(width:175, height: 250)
            .id(localID)
            .transition(.scale)
    }
}
