//
//  OnboardingView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI

struct OnboardingView: View {
    @State private var selectedTab = 0
    @State private var navigateToMainContent = false
    
    var body: some View {
        if navigateToMainContent {
            ContentView()
        } else {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
#if os(iOS)
                TabView(selection: $selectedTab) {
                    OnboardingItemView(imageName: "medical.thermometer",
                                       title: "Title 1",
                                       description: "Description 1.")
                    .tag(0)
                    
                    OnboardingItemView(imageName: "medical.thermometer",
                                       title: "Title 2",
                                       description: "Description 2.")
                    .tag(1)
                    
                    OnboardingItemView(imageName: "medical.thermometer",
                                       title: "Title 3",
                                       description: "Description 3.")
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
#else
                TabView(selection: $selectedTab) {
                    OnboardingItemView(imageName: "medical.thermometer",
                                       title: "Title 1",
                                       description: "Description 1.")
                    .tag(0)
                    
                    OnboardingItemView(imageName: "medical.thermometer",
                                       title: "Title 2",
                                       description: "Description 2.")
                    .tag(1)
                    
                    OnboardingItemView(imageName: "medical.thermometer",
                                       title: "Title 3",
                                       description: "Description 3.")
                    .tag(2)
                }
#endif
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            switch selectedTab {
                            case 0:
                                selectedTab = 1
                            case 1:
                                selectedTab = 2
                            case 2:
                                navigateToMainContent = true
                            default:
                                break
                            }
                        }) {
                            Text(selectedTab == 2 ? "Continue" : "Next")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}

