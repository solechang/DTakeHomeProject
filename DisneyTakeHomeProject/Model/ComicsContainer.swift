//
//  ComicsContainer.swift
//  DisneyTakeHomeProject
//
//  Created by Chang Woo Choi on 9/21/22.
//

import Foundation

struct ComicsContainer: Codable {
    let data: Comics
}

struct Comics: Codable {
    let results: [Comic]
}

struct Comic: Codable, Equatable {
    static func == (lhs: Comic, rhs: Comic) -> Bool {
        if lhs.id == rhs.id,
           lhs.title == rhs.title,
           lhs.description == rhs.description,
           lhs.images == rhs.images {
            return true
        } else {
            return false
        }
    }
    
    let id: Int
    let title: String
    let description: String
    let images: [Image]?
}

struct Image: Codable, Equatable {
    let path: String
    let `extension`: String
    
}
