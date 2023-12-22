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
    var remove: (Plant)->Void
    var goHome: ()->Void

    var body: some View {
        VStack{
            Text("Details for \(item.name)")
            Text("This is #\(item.id)")
            Button("Delete"){
                remove(item)
                goHome()
            }
            .foregroundColor(.red)
        }
    }
}
