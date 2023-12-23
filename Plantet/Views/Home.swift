//
//  Home.swift
//  Plantet
//
//  Created by Spencer Fasulo on 12/21/23.
//

import SwiftUI
import SwiftData

struct Home: View{
    @Environment(\.modelContext) private var modelContext
    @Query private var plants: [Plant]
    @State private var navpath: [Plant] = []
    let grids = [GridItem(.adaptive(minimum: 175))]
    @State private var editing = false
    
    func remove(_ item: Plant){
        modelContext.delete(item)
    }
    
    func goHome(){
        navpath = .init()
    }
    
    var body: some View{
        VStack{
            NavigationStack(path: $navpath) {
                ScrollView(.vertical){
                    LazyVGrid(columns: grids){
                        ForEach(plants, id: \.self){ plant in
                            NavigationLink(value: plant){
                                PlantCard(item:plant, editing: $editing, remove:remove)
                                    .onTapGesture(count:2){
                                        print("Double Tapped!")
                                    }
                            }
                        }
                    }
                    .navigationDestination(for:Plant.self){ plant in
                        PlantPage(item: plant, all: modelContext, remove: remove, goHome: goHome)
                    }
                    .navigationTitle("Plantet")
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing){
                            Button(editing ? "Done" : "Edit"){
                                editing.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
}
