//
//  ContentView.swift
//  Plantet
//
//  Created by Spencer Fasulo on 12/16/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var plants: [Plant]
    @State private var navpath: [Plant] = []
    let grids = [GridItem(.adaptive(minimum: 175))]
    
    func goHome(){
        navpath = .init()
    }
    
    func remove(_ item: Plant){
        modelContext.delete(item)
    }
    
    var body: some View {
        VStack{
            NavigationStack(path: $navpath) {
                ScrollView(.vertical){
                    LazyVGrid(columns: grids){
                        ForEach(plants, id: \.self){ plant in
                            NavigationLink(value: plant){
                                PlantCard(name: plant.name, len: 30)
                            }
                        }
                    }
                    .navigationDestination(for:Plant.self){ plant in
                        PlantPage(item: plant, all: modelContext, cv: self)
                    }
                    .navigationTitle("Plantet")
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing){
                            Button("Edit"){
                                //code
                            }
                        }
                    }
                }
            }
            Button("Add Plant"){
                let newPlant = Plant(datePlanted: Date(), frequency: Frequency.xDays(3), name: "Planty", species: "JJ", light: Lighting.direct, lastPruned: Date(), lastFertilized: Date())
                modelContext.insert(newPlant)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Plant.self, inMemory: true)
}
