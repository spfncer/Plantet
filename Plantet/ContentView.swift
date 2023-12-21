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
    
    let grids = [GridItem(.adaptive(minimum: 175))]
    var body: some View {
        VStack{
            NavigationView {
                ScrollView(.vertical){
                    LazyVGrid(columns: grids){
                        ForEach(plants, id: \.self){ plant in
                            NavigationLink(destination: PlantPage(item: plant.name)) {
                                PlantCard(name: plant.name, len: 500)
                                    .onTapGesture(count: 2) {
                                        print("Double tapped!")
                                    }
                            }
                        }
                    }
                    .navigationTitle("Plantet")
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
