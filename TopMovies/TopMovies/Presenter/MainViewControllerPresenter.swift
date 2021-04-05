//
//  MainViewControllerPresenter.swift
//  TopMovies
//
//  Created by Никита on 03.04.2021.
//

import Foundation

protocol MainVCPresenterProtocol: AnyObject {
    var listOfMovies: [MovieData] { get set }
    func updateVC()
}

protocol MainVCDelegateToCellProtocol: AnyObject {
    func presentCalendarVC(movieName: String)
}

class MainViewControllerPresenter {
    
    private let networkService = NetworkService()
    weak var delegate: MainVCPresenterProtocol?
    
    func loadListOfMovies(){
        networkService.loadDataOfMovies() { (result) in
            guard let result = result else { return }
            self.delegate?.listOfMovies = result
            DispatchQueue.main.sync {
                self.delegate?.updateVC()
            }
        }
    }
}
