//
//  ProfileDetailThreeView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 27/07/2024.
//

import SwiftUI

struct ProfileDetailThreeView: View {
    var profile: Profile
    @State private var textSub: String = ""
    @State private var textMain: String = "Haematology"
    @State private var textUnit: String = ""
    @State private var textMax: String = ""
    let mains = ["Haematology", "Biochemistry", "Serology", "Microbiology", "Others"]
    @State private var showAlert = false
    @StateObject private var testnameModel = TestnameModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Testname")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                TextEditor(text: $textSub)
                    .frame(height: 50)
                    .border(Color.gray, width: 1)
                    .padding()
                Picker("Category", selection: $textMain) {
                    ForEach(mains, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .padding()
                Text("Unit")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                TextEditor(text: $textUnit)
                    .frame(height: 50)
                    .border(Color.gray, width: 1)
                    .padding()
                Text("Max value")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                TextEditor(text: $textMax)
                    .frame(height: 50)
                    .border(Color.gray, width: 1)
                    .padding()
                Button(action: {
                    testnameModel.addTestname(withMain: textMain, sub: textSub, unit: textUnit, maxvalue: textMax, revision: 1)
                    showAlert = true
                }) {
                    Text("Add Medical Report Name")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: 300)
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(30)
                .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Add Completed"),
                    message: Text("New Medical Report Name added successfully."),
                    dismissButton: .default(Text("OK")) {
                        textSub = ""
                        textMain = "Haematology"
                        textUnit = ""
                        textMax = ""
                    }
                )
            }
            .navigationTitle(profile.linkname)
        }
    }
}

#Preview {
    ProfileDetailThreeView(profile: Profile(linkname: "Add-on Medical Report Name", detail: ""))
}
