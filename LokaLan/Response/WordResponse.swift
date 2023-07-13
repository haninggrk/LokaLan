//
//  WordResponse.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 03/07/23.
//

import Foundation

struct WordData: Codable, Hashable {
    var id: Int
    var word: String
    var meaning: String
    var description: String?
    var audio_path: String?
    var upvote: Int
    var downvote: Int
    var user_id: Int
    var created_at: String
    var updated_at: String
    var usage_examples: String?
}

struct WordAPIResponse: Codable {
    let success: Bool
    let data: [WordData]
}

struct WordCreateAPIResponse: Codable {
    let success: Bool
    let data: WordData
}


struct ErrorAPIResponse: Codable {
    let success: Bool
    let errors: [String]
}

struct WordDeleteAPIResponse: Codable {
    let success: Bool
    let message: String
}
