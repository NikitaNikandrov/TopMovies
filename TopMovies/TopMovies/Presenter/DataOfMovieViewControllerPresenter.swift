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
        } else {
            FavouritViewControllerData.shared.favouritMovies?.append(title)
        }
    }
    
    func getRatingInInt(string: String) -> Int {
        let ratingInText = string.dropLast()
        guard let ratingInInt = Int(ratingInText) else { return 0 }
        return ratingInInt
    }
}
