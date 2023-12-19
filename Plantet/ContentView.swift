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
    @Query private var items: [Item]
    var body: some View {
        NavigationView { // Add NavigationView here
            Grid{
                GridRow{
                    NavigationLink(destination: PlantPage(item: "Example")) {
                        PlantCard(name: "Example", len: 500, status: true)
                            .onTapGesture(count: 2) {
                                print("Double tapped!")
                            }
                    }
                    NavigationLink(destination: PlantPage(item: "Second")) {
                        PlantCard(name: "Second", len: 30, status: true)
                            .onTapGesture(count: 2) {
                                print("Double tapped!")
                            }
                    }
                }
                Spacer()
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Text("Plantet")
                        .font(.system(size: 32, weight: .bold))
                }
            }
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
