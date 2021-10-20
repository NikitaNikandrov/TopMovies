//
//  DataOfMovieViewControllerPresenter.swift
//  TopMovies
//
//  Created by Никита on 10.07.2021.
//

import Foundation

protocol DataOfMovieVCPresenterProtocol: AnyObject {
    func movieIsFavourite() -> Bool
}

class DataOfMovieVCPresenter {
    
    private let defaultsService = UserDefaultsService()
    weak var delegate: DataOfMovieVCPresenterProtocol?
    
    func addButtonIsPressed(title: String){
        if delegate?.movieIsFavourite() == true {
            let index = FavouritViewControllerData.shared.favouriteMovies?.firstIndex(of: title)
            FavouritViewControllerData.shared.favouriteMovies?.remove(at: index!)
            defaultsService.clearDefaults()
            defaultsService.saveDataToDefaults()
        } else {
            FavouritViewControllerData.shared.favouriteMovies?.append(title)
            defaultsService.clearDefaults()
            defaultsService.saveDataToDefaults()
        }
    }
    
    func getRatingInInt(string: String) -> Int {
        let ratingInText = string.dropLast()
        guard let ratingInInt = Int(ratingInText) else { return 0 }
        return ratingInInt
    }
}
