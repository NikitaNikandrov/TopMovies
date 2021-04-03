//
//  MainViewControllerPresenter.swift
//  TopMovies
//
//  Created by Никита on 03.04.2021.
//

import Foundation

protocol MainVCPresenterProtocol {
    func loadData(data: [MovieData])
}

class MainViewControllerPresenter {
    
    let networkService = NetworkService()
    var presenterVC: MainVCPresenterProtocol?
    
    
    
}
