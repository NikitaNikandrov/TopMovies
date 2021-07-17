//
//  MainViewControllerData.swift
//  TopMovies
//
//  Created by Никита on 13.06.2021.
//

import Foundation

final class MainViewControllerData {
    static var shared = MainViewControllerData()
    private init() {
        listOfMovies = []
        filteredMovies = []
    }
    
    var listOfMovies: [MovieData]
    var filteredMovies: [MovieData]
}
