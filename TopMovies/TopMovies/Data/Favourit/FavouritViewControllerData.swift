//
//  FavouritViewControllerData.swift
//  TopMovies
//
//  Created by Никита on 05.07.2021.
//

import Foundation

final class FavouritViewControllerData {
    static var shared = FavouritViewControllerData()
    private init() {
        favouriteMovies = []
    }
    
    var favouriteMovies: [String]?
}
