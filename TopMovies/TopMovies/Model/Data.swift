//
//  Data.swift
//  TopMovies
//
//  Created by Никита on 31.03.2021.
//

import Foundation
import UIKit

class Movie {
    var imageOfMovie: UIImage?
    var numberOfRate: String?
    var nameOfMovie: String?
    var dateOfMovie: String?
    var dataOfMovie: String?
}

class DataOfMovies {
    var dataOfMovie: [Movie]?
}
