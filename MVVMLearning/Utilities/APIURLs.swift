//
//  APIURLs.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 14.10.2022.
//

import Foundation

enum APIURLs {
    static func movies(page: Int) -> String {
        "https://api.themoviedb.org/3/movie/popular?api_key=92b3e524814af29da6c3fd3e6d04ae6e&language=en-US&page=\(page)"
    }
    
    static func imageURL(posterPath: String) -> String {
        "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
    
    static func details(id: Int) -> String {
        "https://api.themoviedb.org/3/movie/\(id)?api_key=92b3e524814af29da6c3fd3e6d04ae6e&language=en-US"
    }
    
    static func similar(id: Int) -> String {
        "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=92b3e524814af29da6c3fd3e6d04ae6e&language=en-US&page=1"
    }
}
