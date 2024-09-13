//
//  History.swift
//  doctor-ai
//
//  Created by Juiko Ong on 24/07/2024.
//

import Foundation
import SwiftData

struct History: Codable, Identifiable, Hashable {
    var id = UUID()
    var resultno: Int
    var resultname: String
    var resultvalue: Float
}
