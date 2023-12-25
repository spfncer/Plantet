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
    @State private var newName: String = ""
    @State private var newSpecies: String = ""
    @State private var newDatePlanted: Date = Date()
    @State private var newX: Int = 0
    @State private var newWaterFrequency: Frequency = Frequency.xWeeks(0)
    @State private var newLastWatered: Date = Date()
    @State private var newLighting: Lighting = Lighting.brightIndirect
    
    init(formShown: Binding<Bool>, animateGradient: Binding<Bool>){
        self._formShown = formShown
        self._animateGradient = animateGradient
    }
    
    func dismiss(){
        formShown = false
    }
    
    func save(){
        let newPlant = Plant(datePlanted: newDatePlanted, frequency: newWaterFrequency, name: newName, species: newSpecies, light: newLighting, lastPruned: Date(), lastFertilized: Date())
        modelContext.insert(newPlant)
        dismiss()
    }
    
    var body: some View{
        NavigationStack {
            Form{
                Section{
                    Text("New Plant")
                        .font(.headline)
                }
                .listRowBackground(Color.clear)
                Section(header:Text("Basics")){
                    TextField("Plant Name",text: $newName)
                    TextField("Plant Species",text: $newSpecies)
                    DatePicker("Date Planted",selection: $newDatePlanted, displayedComponents: [.date])
                }
                
                Section(header:Text("Care")){
                    Picker("Watering Frequency", selection: $newWaterFrequency){
                            Text("Every " + ((newX==0) ? "X" : String(newX))  + " Days").tag(Frequency.xDays(newX))
                            Text("Every " + ((newX==0) ? "X" : String(newX))  + " Weeks").tag(Frequency.xWeeks(newX))
                            Text("Every " + ((newX==0) ? "X" : String(newX))  + " Months").tag(Frequency.xMonths(newX))
                        Stepper(("X = " + ((newX==0) ? "?" : String(newX))), value: $newX)
                    }
                    .pickerStyle(.navigationLink)
                    DatePicker("Date Last Watered",selection: $newLastWatered, displayedComponents: [.date])
                    Picker("Lighting", selection: $newLighting){
                        Text("Low").tag(Lighting.low)
                        Text("Moderate").tag(Lighting.moderate)
                        Text("Direct").tag(Lighting.direct)
                        Text("Bright Indirect").tag(Lighting.brightIndirect)
                        Text("Low to Medium").tag(Lighting.lowToMedium)
                    }
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
            .navigationTitle("New Plant")
    }
}
