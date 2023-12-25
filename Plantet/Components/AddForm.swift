//
//  AddForm.swift
//  Plantet
//
//  Created by Spencer Fasulo on 12/24/23.
//

import Foundation
import SwiftUI

struct AddForm: View{
    @Environment(\.modelContext) private var modelContext
    @Binding private var formShown: Bool
    @Binding private var animateGradient: Bool
    @Binding private var newName: String
    @Binding private var newSpecies: String
    
    init(formShown: Binding<Bool>, animateGradient: Binding<Bool>){
        _formShown = formShown
        _animateGradient = animateGradient
        _newName = .constant("")
        _newSpecies = .constant("")
    }
    
    func dismiss(){
        formShown = false
    }
    
    func save(){
        let newPlant = Plant(datePlanted: Date(), frequency: Frequency.xDays(2), name: newName, species: newSpecies, light: Lighting.brightIndirect, lastPruned: Date(), lastFertilized: Date())
        modelContext.insert(newPlant)
        dismiss()
    }
    
    var body: some View{
        VStack{
            Form{
                Section(header:Text("Basics")){
                    TextField("Plant Name",text: $newName)
                    TextField("Plant Species",text: $newSpecies)
                }
                Section{
                    Button(action: save){
                        Text("Save Plant!")
                            .foregroundStyle(Color.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .cornerRadius(8)
                }
                .listRowBackground(LinearGradient.linearGradient(colors: [Color("PlantetPrimary"), Color("PlantetSecondary")], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing))
            }
            
        }
    }
}
#Preview {
    ContentView()
        .modelContainer(for: Plant.self, inMemory: true)
}
