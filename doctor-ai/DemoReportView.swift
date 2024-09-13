//
//  DemoReportView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 26/07/2024.
//

import SwiftUI

struct DemoReportView: View {
    @State private var haematologyExpanded: Bool = true
    @State private var biochemistryExpanded: Bool = true
    @State private var serologyExpanded: Bool = true
    @State private var microbiologyExpanded: Bool = true
    @StateObject private var demomatchModel = DemomatchModel()
    @State private var navigationPath = NavigationPath()
    @State private var isShowingHistoryReport = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Text("Latest Medical Report")
                    .font(.largeTitle).foregroundColor(Color(red: 17 / 255, green: 24 / 255, blue: 39 / 255))
                    .padding(.top, 10)
                Spacer()
                List {
                    DisclosureGroup("Haematology", isExpanded: $haematologyExpanded) {
                        ForEach(demomatchModel.haematologyDemomatch, id: \.self) {
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
                        ForEach(demomatchModel.biochemistryDemomatch, id: \.self) {
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
                        ForEach(demomatchModel.serologyDemomatch, id: \.self) {
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
                        ForEach(demomatchModel.microbiologyDemomatch, id: \.self) {
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
                          isShowingHistoryReport = true
                      }
                    )
                )
#else
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            isShowingHistoryReport = true
                        }) {
                            Text("History Report")
                        }
                    }
                }
#endif
            }
            .onAppear {
                demomatchModel.fetchDemomatchMainBatch(withMain: "Haematology", Batch: 3)
                demomatchModel.fetchDemomatchMainBatch(withMain: "Biochemistry", Batch: 3)
                demomatchModel.fetchDemomatchMainBatch(withMain: "Serology", Batch: 3)
                demomatchModel.fetchDemomatchMainBatch(withMain: "Microbiology", Batch: 3)
            }
            .navigationDestination(for: Matched.self) { matched in
                DemoReportDetailView(sub: matched.sub)
            }
            .navigationDestination(isPresented: $isShowingHistoryReport) {
                DemoHistoryView()
            }
        }
        .tabViewStyle(DefaultTabViewStyle())
    }
}

#Preview {
    DemoReportView()
}
