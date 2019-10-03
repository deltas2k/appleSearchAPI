//
//  SearchResult.swift
//  AppleSearch
//
//  Created by Matthew O'Connor on 10/3/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import Foundation

struct MusicTopLevelDictionary: Decodable {
    let results: [MusicSearchResult]
}

struct MusicSearchResult: Decodable {
    let artistName: String
    let trackName: String
    let artworkUrl100: String?
}

struct AppTopLevelDictionary: Decodable {
    let results: [AppSearchResult]
}

struct AppSearchResult: Decodable {
    let artworkUrl100: String?
    let trackName: String
    let description: String
}
