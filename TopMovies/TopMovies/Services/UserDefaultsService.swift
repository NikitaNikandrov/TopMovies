//
//  UserDefaultsService.swift
//  TopMovies
//
//  Created by Никита on 02.10.2021.
//

import Foundation

class UserDefaultsService {
    
    func loadDataFromDefaults() {
        if FavouritViewControllerData.shared.favouritMovies?.count == 0 {
            let defaults = UserDefaults.standard
            let data = defaults.array(forKey: "favourits")
            if data != nil {
                for movie in data! {
                    FavouritViewControllerData.shared.favouritMovies?.append(movie as! String)
                }
            } else { return }
        } else { return }
    }
    
    func saveDataToDefaults() {
        var data: [String] = []
        for movie in FavouritViewControllerData.shared.favouritMovies! {
            data.append(movie)
        }
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: "favourits")
    }
    
    func clearDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
