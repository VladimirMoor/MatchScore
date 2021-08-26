//
//  NewPlayerView.swift
//  NewPlayerView
//
//  Created by Владимир Муравьев on 26.08.2021.
//

import SwiftUI

struct NewPlayerView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var team: Team
    @State private var fullName: String = ""
    @State private var age: String = ""
    @State private var role: String = ""
    @State private var number: String = ""

    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    Picker("Choose role", selection: $role) {
                        ForEach(Player.possibleRoles, id:\.self) { item in
                            Text(item)
                        }
                    }
                }
                
                TextField("Full name", text: $fullName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Age", text: $age)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                TextField("Number", text: $number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Rectangle()
                    .fill(Color.secondary)
                    .frame(maxWidth: .infinity, maxHeight: 2)

                Button {
                    let newPlayer = Player(context: moc)
                    
                    newPlayer.fullName = fullName
                    newPlayer.age = Int16(age)!
                    newPlayer.role = role
                    newPlayer.number = Int16(number)!
                    newPlayer.team = team
                    
                    try? moc.save()
                    
                    presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1))
                }
                .disabled(Int16(age) == nil || Int16(number) == nil || fullName == "" || role == "")
                
            }
            .navigationTitle("Add new player")
        }
    }
}

