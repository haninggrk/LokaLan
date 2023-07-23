//
//  Surabaya.swift
//  LokaLan
//
//  Created by Andreas Lim on 16/07/23.
//

import Foundation

class Surabaya {
    let words: [] = [
        WidgetWord(name: "Ngoyo", meaning: "Berusaha Keras"),
        WidgetWord(name: "Ngoyo2", meaning: "Berusaha Keras2"),
        WidgetWord(name: "Ngoyo3", meaning: "Berusaha Keras3")
    ]
    
    func getRandom() -> WidgetWord {
        let number = Int.random(in: 0..<words.count)
        return words[number]
    }
    
    func getAll() -> [WidgetWord] {
        return words
    }
}
