//
//  RickAndMortyData.swift
//  testProject_rickAndMorty
//
//  Created by Евгений Л on 08.11.2023.
//

import Foundation

// MARK: - Welcome
struct Episode: Codable {
    let name, gender, status, species, type: String
    let origin, location: Location
    let image: String
}

struct Location: Codable {
    let name: String
    let url: String
}

//MARK: - Character
struct Character: Codable {
    let results: [CharacterModel]
}

struct CharacterModel: Codable {
    let name, episode: String
    let characters: [String]

    enum CodingKeys: String, CodingKey {
        case name, episode, characters
    }
}
