//
//  ReportItemView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//
//  Deprecated replaced by NavigationStack

import SwiftUI

struct ReportItemView: View {
    var sub: String
    var result: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(sub)
                    .font(.subheadline)
                Spacer()
                Text(result)
                    .font(.title3)
            }
        }
    }
}

#Preview {
    ReportItemView(sub: "Haemoglobin", result: "14.3")
}
