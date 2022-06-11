//
//  Books.swift
//  BookFinder
//
//  Created by Василий Буланов on 11.06.2022.
//

import Foundation

struct Book: Codable {
    struct volumeInfo: Codable {
        var title: String
        var authors: [String]
    }
    
    var volumeInfo: volumeInfo
}

struct Books: Codable {
    var items: [Book]
}
