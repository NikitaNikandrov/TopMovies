//
//  MainViewControllerPresenter.swift
//  TopMovies
//
//  Created by Никита on 03.04.2021.
//

import Foundation
import UIKit

protocol MainVCPresenterProtocol: AnyObject {
    func loadVC()
    func updateVC()
    func startActivityIndicator()
    func stopActivityIndicator()
}

protocol MainVCDelegateToCellProtocol: AnyObject {
    func presentDataOfMovieVC(movieName: String, moviePoster: UIImage, movieDate: String, movieRate: String, movieData: String)
}

class MainViewControllerPresenter {
    
    private let networkService = NetworkService()
    weak var delegate: MainVCPresenterProtocol?
    
    func getCurrentYear() -> String {
        let date = Date()
        let calendar = Calendar.current
        return "\(calendar.component(.year, from: date))"
    }
    
    func loadListOfMovies() {
        self.delegate?.startActivityIndicator()
        networkService.loadDataOfMovies() { (result) in
            guard let result = result else { return }
            MainViewControllerData.shared.listOfMovies = result
            DispatchQueue.main.sync {
                MainViewControllerData.shared.filteredMovies = MainViewControllerData.shared.listOfMovies
                self.sortList(withOption: SettingsOfListData.shared.ChoosedSortRow)
                self.delegate?.updateVC()
                self.delegate?.stopActivityIndicator()
            }
        }
    }
    
    func filteringMovies(searchText: String) {
        if searchText.isEmpty == false {
            var filteredMovies: [MovieData] = []
            for movie in MainViewControllerData.shared.listOfMovies {
                if movie.titleOfMovie!.contains(searchText) {
                    filteredMovies.append(movie)
                }
            }
            MainViewControllerData.shared.filteredMovies = filteredMovies
        } else {
            MainViewControllerData.shared.filteredMovies = MainViewControllerData.shared.listOfMovies
        }
        self.sortList(withOption: SettingsOfListData.shared.ChoosedSortRow)
        self.delegate?.updateVC()
    }
    
    func sortList(withOption: Int) {
        switch withOption {
        case 0:
            var array = MainViewControllerData.shared.filteredMovies
            if array.count != 0 {
                array.sort(by: {Float($0.numberOfRating!) > Float($1.numberOfRating!)})
            }
            MainViewControllerData.shared.filteredMovies = array
        case 1:
            var array = MainViewControllerData.shared.filteredMovies
            if array.count != 0 {
                array.sort(by: { Float($0.numberOfRating!) < Float($1.numberOfRating!) })
            }
            MainViewControllerData.shared.filteredMovies = array
        case 2:
            var array = MainViewControllerData.shared.filteredMovies
            if array.count != 0 {
                array.sort(by: { $0.releaseDateOfMovie! > $1.releaseDateOfMovie! })
            }
            MainViewControllerData.shared.filteredMovies = array
        case 3:
            var array = MainViewControllerData.shared.filteredMovies
            if array.count != 0 {
                array.sort(by: { $0.releaseDateOfMovie! < $1.releaseDateOfMovie! })
            }
            MainViewControllerData.shared.filteredMovies = array
        default: break
        }
    }
}
