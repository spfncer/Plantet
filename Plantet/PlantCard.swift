//
//  PlantCard.swift
//  Plantet
//
//  Created by Spencer Fasulo on 12/16/23.
//

import SwiftUI

struct PlantCard: View{
    static var id = 0
    var localID = 0
    var item: Plant
    var remove: (Plant)->Void
    @Binding var editing: Bool
    
    init(item: Plant, editing: Binding<Bool>, remove: @escaping (Plant)->Void) {
        self.item = item
        self.localID = Plantet.PlantCard.id
        Plantet.PlantCard.id+=1
        self._editing = editing
        self.remove = remove
    }
    
    var body: some View{
        ZStack(alignment:Alignment(horizontal: .leading, vertical: .top)){
            VStack{
                Image("Plant Placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .shadow(radius: 5)
                VStack(alignment: .leading){
                    Spacer()
                    Text(item.name)
                        .font(.headline)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .padding(.leading)
                        .foregroundColor(Color("TextColor"))
                    Text(String(item.species))
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
            
                if(editing){
                        ZStack{
                            Circle()
                                .foregroundStyle(Color(.red))
                                .frame(width: 50)
                                .shadow(radius: 20)
                            Button(action: {()->Void in remove(item)}){
                                Image(systemName: "minus")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .bold))
                                    .frame(width: 50, height: 50)
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Plant.self, inMemory: true)
}
