//
//  ReportView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI

struct ReportView: View {
    @State private var haematologyExpanded: Bool = true
    @State private var biochemistryExpanded: Bool = true
    @State private var serologyExpanded: Bool = true
    @State private var microbiologyExpanded: Bool = true
    @StateObject private var itemModel = ItemModel()
    @StateObject private var testmatchModel = TestmatchModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Text("Latest Medical Report")
                    .font(.largeTitle).foregroundColor(Color(red: 17 / 255, green: 24 / 255, blue: 39 / 255))
                    .padding(.top, 10)
                Spacer()
                List {
                    DisclosureGroup("Haematology", isExpanded: $haematologyExpanded) {
                        ForEach(testmatchModel.haematologyTestmatch, id: \.self) {
                            haematology in
                            HStack {
                                Text(haematology.sub ?? "No name")
                                    .font(.subheadline)
                                Spacer()
                                Text(haematology.result ?? "No result")
                                    .font(.title3)
                            }
                            .contentShape(Rectangle())
                            .listRowBackground(Color.white)
                            .onTapGesture {
                                navigationPath.append(Matched(main: haematology.main ?? "No category", sub: haematology.sub ?? "No name", result: haematology.result ?? "No result"))
                            }
                        }
                    }
                    DisclosureGroup("Biochemistry", isExpanded: $biochemistryExpanded) {
                        ForEach(testmatchModel.biochemistryTestmatch, id: \.self) {
                            biochemistry in
                            HStack {
                                Text(biochemistry.sub ?? "No name")
                                    .font(.subheadline)
                                Spacer()
                                Text(biochemistry.result ?? "No result")
                                    .font(.title3)
                            }
                            .contentShape(Rectangle())
                            .listRowBackground(Color.white)
                            .onTapGesture {
                                navigationPath.append(Matched(main: biochemistry.main ?? "No category", sub: biochemistry.sub ?? "No name", result: biochemistry.result ?? "No result"))
                            }
                        }
                    }
                    DisclosureGroup("Serology", isExpanded: $serologyExpanded) {
                        ForEach(testmatchModel.serologyTestmatch, id: \.self) {
                            serology in
                            HStack {
                                Text(serology.sub ?? "No name")
                                    .font(.subheadline)
                                Spacer()
                                Text(serology.result ?? "No result")
                                    .font(.title3)
                            }
                            .contentShape(Rectangle())
                            .listRowBackground(Color.white)
                            .onTapGesture {
                                navigationPath.append(Matched(main: serology.main ?? "No category", sub: serology.sub ?? "No name", result: serology.result ?? "No result"))
                            }
                        }
                    }
                    DisclosureGroup("Microbiology", isExpanded: $microbiologyExpanded) {
                        ForEach(testmatchModel.microbiologyTestmatch, id: \.self) {
                            microbiology in
                            HStack {
                                Text(microbiology.sub ?? "No name")
                                    .font(.subheadline)
                                Spacer()
                                Text(microbiology.result ?? "No result")
                                    .font(.title3)
                            }
                            .contentShape(Rectangle())
                            .listRowBackground(Color.white)
                            .onTapGesture {
                                navigationPath.append(Matched(main: microbiology.main ?? "No category", sub: microbiology.sub ?? "No name", result: microbiology.result ?? "No result"))
                            }
                        }
                    }
                }
                .padding(.top, 5)
                .listStyle(SidebarListStyle())
#if os(iOS)
                .navigationBarItems(trailing:
                    Button(
                      "History Report",
                      action: {
                          print("History Report")
                      }
                    )
                )
#else
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            print("History Report")
                        }) {
                            Text("History Report")
                        }
                    }
                }
#endif
            }
            .onAppear {
                itemModel.fetchLastBatch()
                testmatchModel.fetchTestmatchMainBatch(withMain: "Haematology", Batch: Int16(itemModel.lastbatch) ?? 1)
                testmatchModel.fetchTestmatchMainBatch(withMain: "Biochemistry", Batch: Int16(itemModel.lastbatch) ?? 1)
                testmatchModel.fetchTestmatchMainBatch(withMain: "Serology", Batch: Int16(itemModel.lastbatch) ?? 1)
                testmatchModel.fetchTestmatchMainBatch(withMain: "Microbiology", Batch: Int16(itemModel.lastbatch) ?? 1)
            }
            .navigationDestination(for: Matched.self) { matched in
                ReportDetailView(sub: matched.sub, result: matched.result)
            }
        }
        .tabViewStyle(DefaultTabViewStyle())
    }
}
    
#Preview {
    ReportView()
}
