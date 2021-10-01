//
//  DataOfMovieViewControllerPresenter.swift
//  TopMovies
//
//  Created by Никита on 10.07.2021.
//

import Foundation

protocol DataOfMovieVCPresenterProtocol: AnyObject {
    func movieIsFavourit() -> Bool
}

class DataOfMovieVCPresenter {
    
    weak var delegate: DataOfMovieVCPresenterProtocol?
    
    func addButtonIsPressed(title: String){
        if delegate?.movieIsFavourit() == true {
            let index = FavouritViewControllerData.shared.favouritMovies?.firstIndex(of: title)
            FavouritViewControllerData.shared.favouritMovies?.remove(at: index!)
            clearDefaults()
            saveDataToDefaults()
        } else {
            FavouritViewControllerData.shared.favouritMovies?.append(title)
            clearDefaults()
            saveDataToDefaults()
        }
    }
    
    func getRatingInInt(string: String) -> Int {
        let ratingInText = string.dropLast()
        guard let ratingInInt = Int(ratingInText) else { return 0 }
        return ratingInInt
    }
    
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
    
    private func saveDataToDefaults() {
        var data: [String] = []
        for movie in FavouritViewControllerData.shared.favouritMovies! {
            data.append(movie)
        }
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: "favourits")
    }
    
    private func clearDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
