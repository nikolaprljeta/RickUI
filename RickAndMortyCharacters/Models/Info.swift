//
//  Info.swift
//  RickAndMortyCharacters
//
//  Created by Nikola Prljeta on 22.11.22..
//

import Foundation

struct Info: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}
