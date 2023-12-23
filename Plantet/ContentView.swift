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
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            Home()
            AddButton()
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Plant.self, inMemory: true)
}
