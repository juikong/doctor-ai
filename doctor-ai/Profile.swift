//
//  Profilelink.swift
//  doctor-ai
//
//  Created by Juiko Ong on 09/07/2024.
//

import SwiftUI
import SwiftData

struct Profile: Codable, Identifiable, Hashable {
    var id = UUID()
    var linkname: String
    var detail: String
}
