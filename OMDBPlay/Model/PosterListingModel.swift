//
//  PosterListingModel.swift
//  OMDBPlay
//
//  Created by Rohit Saini on 11/01/20.
//  Copyright © 2020 Rohit Saini. All rights reserved.
//

import Foundation
// MARK: - PosterListModel
struct PosterListModel: Codable {
    let search: [Search]?
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search = try values.decodeIfPresent([Search].self, forKey: .search) ?? []
        totalResults = try values.decodeIfPresent(String.self, forKey: .totalResults) ?? DocumentDefaultValues.Empty.string
        response = try values.decodeIfPresent(String.self, forKey: .response) ?? DocumentDefaultValues.Empty.string
    }
}

// MARK: - Search
struct Search: Codable {
    let title, year, imdbID: String
    let type: TypeEnum?
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? DocumentDefaultValues.Empty.string
        year = try values.decodeIfPresent(String.self, forKey: .year) ?? DocumentDefaultValues.Empty.string
        imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID) ?? DocumentDefaultValues.Empty.string
        type = try values.decodeIfPresent(TypeEnum.self, forKey: .type) ?? nil
        poster = try values.decodeIfPresent(String.self, forKey: .poster) ?? DocumentDefaultValues.Empty.string
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}

