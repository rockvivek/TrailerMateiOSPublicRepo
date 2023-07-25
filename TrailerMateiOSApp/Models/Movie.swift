
//

//
//  Movie.swift
//  TrailerMateiOSApp
//
//  Created by Amr Hossam on 08/12/2021.
//

import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}




//struct Welcome: Codable {
//    let page: Int
//    let results: [MovieResponse]
//    let totalPages, totalResults: Int
//
//    enum CodingKeys: String, CodingKey {
//        case page, results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
//    }
//}
//
//
//struct MovieResponse: Codable {
////    let adult: Bool?
////    let backdropPath: String
////    let genreIDS: [Int]
////    let originalLanguage: OriginalLanguage
//    let originalTitle: String? //
//    let posterPath: String //
//    let voteCount, id: Int //
//    let voteAverage: Double //
////    let video: Bool?
//    let overview: String //
//    let releaseDate: String//
////    let title: String?
////    let popularity: Double
//    let mediaType: MediaType //
//    let originalName: String? //
////    let originCountry: [String]?
////    let name
////    let firstAirDate: String?
//
//    enum CodingKeys: String, CodingKey {
////        case adult
////        case backdropPath = "backdrop_path"
////        case genreIDS = "genre_ids"
////        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case posterPath = "poster_path"
//        case voteCount = "vote_count"
//        case id
//        case voteAverage = "vote_average"
////        case video
//        case overview
//        case releaseDate = "release_date"
////        case title, popularity
//        case mediaType = "media_type"
//        case originalName = "original_name"
////        case originCountry = "origin_country"
////        case name
////        case firstAirDate = "first_air_date"
//    }
//}
//
//enum MediaType: String, Codable {
//    case movie = "movie"
//    case tv = "tv"
//}
//
//enum OriginalLanguage: String, Codable {
//    case en = "en"
//}
