//
//  PlantPage.swift
//  Plantet
//
//  Created by Spencer Fasulo on 12/18/23.
//

import SwiftUI
import SwiftData

struct PlantPage: View {
    var item: Plant
    var all: ModelContext
    var cv : ContentView

    var body: some View {
        VStack{
            Text("Details for \(item.name)")
            Text("This is #\(item.id)")
            Button("Delete"){
                cv.remove(item)
                cv.goHome()
            }
            .foregroundColor(.red)
        }
    }
}
