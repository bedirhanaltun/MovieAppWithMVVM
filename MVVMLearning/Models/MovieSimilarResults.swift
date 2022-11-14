//
//  MovieSimilar.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 19.10.2022.
//

import Foundation


struct MovieSimilar: Decodable {
    let results: [MovieSimilarResults]?
}

struct MovieSimilarResults: Decodable {
    let id: Int?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
    }
    
    var _id: Int {
        id ?? 0
    }
    
    var _posterPath: String {
        posterPath ?? ""
    }
}
