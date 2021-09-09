//
//  RoleFilterView.swift
//  RoleFilterView
//
//  Created by Владимир Муравьев on 26.08.2021.
//

import SwiftUI

struct RoleFilterView: View {
    @Binding var role: String
    @Environment(\.presentationMode) var presentationMode
    
    var roles: [String] {
        var allRoles = Player.possibleRoles
        allRoles.insert("All", at: 0)
        return allRoles
    }
    
    var body: some View {
        
        VStack {

            ForEach(roles, id: \.self) { item in
                
            Text(item)
                .padding()
                .background(Color.blue)
                .clipShape(Capsule())
                .onTapGesture {
                    print(item)
                    role = item
                    presentationMode.wrappedValue.dismiss()
                }
        }
        }
        
    }
}
