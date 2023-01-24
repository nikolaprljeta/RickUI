//
//  Favorites.swift
//  RickAndMortyCharacters
//
//  Created by Nikola Prljeta on 16.11.22..
//

import Foundation

final class FavoritesManager {
    private let FAV_KEY = "fav_key"
    
    func save(items: Set<Int>) {
        let array = Array(items)
        UserDefaults.standard.set(array, forKey: FAV_KEY)
    }
    
    func load() -> Set<Int> {
        let array = UserDefaults.standard.array(forKey: FAV_KEY) as? [Int] ?? [Int]()
        return Set(array)
    }
}
