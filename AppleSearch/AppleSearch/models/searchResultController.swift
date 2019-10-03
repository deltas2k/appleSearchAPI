//
//  searchResultController.swift
//  AppleSearch
//
//  Created by Matthew O'Connor on 10/3/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import Foundation

struct stringConstants {
    fileprivate static let baseURL = "https://itunes.apple.com/"
    fileprivate static let searchComponent = "search"
    fileprivate static let termKey = "term"
    fileprivate static let entityKey = "entity"
    fileprivate static let entityMusicValue = "musicTrack"
    fileprivate static let entityAppValue = "software"
}

class searchResultController {
    
    static func getMusicItems(searchText: String, completion: @escaping ([MusicSearchResult]) -> Void) {
        
        guard var baseURL = URL(string: stringConstants.baseURL),
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            else { completion([]); return }
        baseURL.appendPathComponent(stringConstants.searchComponent)
        let searchTermQuery = URLQueryItem(name: stringConstants.termKey, value: searchText)
        let entityQuery = URLQueryItem(name: stringConstants.entityKey, value: stringConstants.entityMusicValue)
        components.queryItems = [searchTermQuery,entityQuery]
        
        guard let finalURL = components.url else {
            print("Error in query")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return
            }
            guard let data = data  else {
                print("no data recieved")
                completion([])
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let topLevelDict = try jsonDecoder.decode(MusicTopLevelDictionary.self, from: data)
                completion(topLevelDict.results)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    .resume()
    }
    
    static func getAppItems(searchText: String, completion: @escaping ([AppSearchResult]) -> Void) {
        
        guard var baseURL = URL(string: stringConstants.baseURL),
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            else {completion([]); return}
        baseURL.appendPathComponent(stringConstants.searchComponent)
        let searchTermQuery = URLQueryItem(name: stringConstants.termKey, value: searchText)
        let entityQuery = URLQueryItem(name: stringConstants.entityKey, value: stringConstants.entityAppValue)
        components.queryItems = [searchTermQuery,entityQuery]
        
        guard let finalURL = components.url else {
            print("error in app query")
            completion([])
            return
        }
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return
            }
            guard let data = data else {
                print("no app data recieved")
                completion([])
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let topLevelDict = try jsonDecoder.decode(AppTopLevelDictionary.self, from: data)
                completion(topLevelDict.results)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    .resume()
    }
}
