//
//  WidgetWords.swift
//  LokaLan
//
//  Created by Andreas Lim on 16/07/23.
//

import Foundation

struct WidgetWord : Identifiable, Codable {
    let name: String
    let meaning: String
    
    var id: String { name }
}
