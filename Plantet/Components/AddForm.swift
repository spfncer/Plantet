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
    @State private var showCancelAlert: Bool = false
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
    
    func attemptDismiss(){
        showCancelAlert = true
    }
    
    func cancelClose(){
        showCancelAlert = false
    }
    
    func closeForm(){
        formShown = false
    }
    
    func save(){
        let newPlant = Plant(datePlanted: newDatePlanted, frequency: newWaterFrequency, name: newName, species: newSpecies, light: newLighting, lastPruned: Date(), lastFertilized: Date())
        modelContext.insert(newPlant)
        closeForm()
    }
    
    var body: some View{
        NavigationStack {
            Form{
                Section(header:Text("Basics")){
                    TextField("Plant Name",text: $newName)
                    TextField("Plant Species",text: $newSpecies)
                    DatePicker("Date Planted",selection: $newDatePlanted, displayedComponents: [.date])
                }
                
                Section(header:Text("Care")){
                    let xMessage: String = "Every " + ((newX==0) ? "X" : String(newX))
                    Picker("Watering Frequency", selection: $newWaterFrequency){
                        Text(xMessage  + " Days").tag(Frequency.xDays(newX))
                        Text(xMessage + " Weeks").tag(Frequency.xWeeks(newX))
                        Text(xMessage  + " Months").tag(Frequency.xMonths(newX))
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
            .alert("Proceed?", isPresented: $showCancelAlert, actions:{
                Button(role: .destructive, action: closeForm, label: {
                    Text("Yes")
                })
                Button(role: .cancel, action: cancelClose, label:{
                    Text("No")
                })
            }, message: {Text("Changes made to this plant will be lost!")})
            .navigationTitle("New Plant")
            .toolbar{
                ToolbarItem(placement:.topBarLeading){
                    Button(action:attemptDismiss){
                        Text("Cancel")
                            .foregroundStyle(Color(.red))
                    }
                }
            }
        }
    }
}
