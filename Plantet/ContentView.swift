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
    @State private var animateGradient = false
    @State private var editing = false
    let grids = [GridItem(.adaptive(minimum: 175))]
    
    func goHome(){
        navpath = .init()
    }
    
    func remove(_ item: Plant){
        modelContext.delete(item)
    }
    
    func add(){
        let newPlant = Plant(datePlanted: Date(), frequency: Frequency.xDays(3), name: "Planty", species: "The Potted Plant", light: Lighting.direct, lastPruned: Date(), lastFertilized: Date())
        modelContext.insert(newPlant)
    }
    
    var body: some View {
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
            ZStack{
                Circle()
                    .frame(width: 80)
                    .foregroundStyle(LinearGradient.linearGradient(colors: [Color("PlantetPrimary"), Color("PlantetSecondary")], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing))
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .onAppear{
                        withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
                Button(action: add){
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold))
                        .frame(width: 50, height: 50)
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Plant.self, inMemory: true)
}
