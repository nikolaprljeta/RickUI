//
//  Result.swift
//  RickAndMortyCharacters
//
//  Created by Nikola Prljeta on 22.11.22..
//

import Foundation

struct Result: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    var isFaved: Bool?
}
