//
//  FavouritsViewControllerPresenter.swift
//  TopMovies
//
//  Created by Никита on 14.07.2021.
//

import Foundation

class FavouritsViewControllerPresenter {
    func saveData() {
        var data: [Int : String] = [ : ]
        for movie in FavouritViewControllerData.shared.favouritMovies! {
            data[(FavouritViewControllerData.shared.favouritMovies?.firstIndex(of: movie))!] = movie
        }
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: "favourits")
    }
    
    func loadData() {
        
    }
}
