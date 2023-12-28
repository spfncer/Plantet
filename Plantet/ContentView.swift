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
    @Binding var addFormOpen: Bool
    
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            Home()
            AddButton(addFormOpen: $addFormOpen)
        }
    }
}

//#Preview
struct AddContainer_Previews: PreviewProvider {
    @State static var isShowing = false
    static var previews: some View {
        ContentView(addFormOpen: $isShowing)
    }
}
