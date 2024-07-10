//
//  Match.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI
import SwiftData

struct Matched: Codable, Identifiable, Hashable {
    var id = UUID()
    var main: String
    var sub: String
    var result: String
}
