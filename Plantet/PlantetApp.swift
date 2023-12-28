//
//  PlantetApp.swift
//  Plantet
//
//  Created by Spencer Fasulo on 12/16/23.
//

import SwiftUI
import SwiftData

@main
struct PlantetApp: App {
    var sharedModelContainer: ModelContainer
    @State private var addFormOpen: Bool = false
    
    init() {
        sharedModelContainer = {
            let schema = Schema([
                Plant.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(addFormOpen: $addFormOpen)
        }
        .modelContainer(sharedModelContainer)
        .commands{
            CommandGroup(replacing: .newItem) {
                Button("New Plant"){
                    addFormOpen = true
                }
            }
        }
    }
}
