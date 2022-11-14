//
//  Movie.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 14.10.2022.
//

import Foundation

struct Movie: Decodable {
    let results: [MovieResults]?
}

struct MovieResults: Decodable {
    let id: Int?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let title: String?
    let popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case title
        case popularity
    }
    
    var _posterPath: String {
        posterPath ?? ""
    }
    
    var _id: Int {
        id ?? Int.min
    }
    
    var _title: String {
        title ?? "N/A"
    }
    
    var _overview: String {
        overview ?? "There is no overview."
    }
    
    var _releaseDate: String {
        releaseDate ?? "N/A"
    }
    
    var _popularity: Double {
        popularity ?? 0
    }
}
