//
//  NewTeamView.swift
//  NewTeamView
//
//  Created by Владимир Муравьев on 26.08.2021.
//

import SwiftUI

struct NewTeamView: View {
    
    @State private var city: String = ""
    @State private var name: String = ""
    @State private var regDate: Date = Date()
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        Form {
            VStack(spacing: 20) {
            
            TextField("Enter team name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 40)
                .disableAutocorrection(true)
                
            TextField("Enter team city", text: $city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
            
            Button {
                let newTeam = Team(context: moc)
                newTeam.name = name
                newTeam.city = city
                newTeam.regDate = Date()
                
                try? moc.save()
                self.presentationMode.wrappedValue.dismiss()
                
            } label: {
                Text("Save Team")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                    Capsule()
                        .stroke(lineWidth: 2)
                    )
            }
            .buttonStyle(BorderlessButtonStyle())
            .disabled(city == "" || name == "")

            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(Color.gray.opacity(0.3))
                    )

                    }
        }
        .buttonStyle(BorderlessButtonStyle())
        .navigationTitle("Add New Team")
        
        }
        
    }
}

struct NewTeamView_Previews: PreviewProvider {
    static var previews: some View {
        NewTeamView()
    }
}
