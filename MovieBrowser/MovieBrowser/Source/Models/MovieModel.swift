//
//  Movie.swift
//  SampleProject
//
//  Created by Arun on 28/10/21.
//  Copyright © 2021 Arun. All rights reserved.
//

import UIKit

struct MovieResults: Codable {
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct Movie: Codable {
    let identifier: Int
    let title: String
    let releaseDate: String?
    let voteAverage: Float
    let overview: String?
    let backdrop: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case overview
        case backdrop = "backdrop_path"
    }
}
