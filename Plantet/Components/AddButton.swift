//
//  AddButton.swift
//  Plantet
//
//  Created by Spencer Fasulo on 12/23/23.
//

import SwiftUI

struct AddButton: View{
    @State private var animateGradient = false
    @Binding var addFormOpen: Bool
    @Environment(\.modelContext) private var modelContext
    
    func add(){
        addFormOpen = true
    }
    
    func dismiss(){
        addFormOpen = false
    }
    
    var body: some View{
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
        .sheet(isPresented: $addFormOpen, onDismiss: dismiss){
            AddForm(formShown: $addFormOpen, animateGradient: $animateGradient)
        }
    }
}
