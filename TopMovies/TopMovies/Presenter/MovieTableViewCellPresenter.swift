//
//  MovieTableViewCellPresenter.swift
//  TopMovies
//
//  Created by Никита on 04.04.2021.
//

import Foundation
import UIKit

protocol MovieTableViewCellPresenterProtocol: AnyObject {
    var posterImage: UIImage? { get set }
    func updateImage()
}

class MovieTableViewCellPresenter {
    
    private let networkService = NetworkService()
    weak var delegate: MovieTableViewCellPresenterProtocol?
    
    func loadPoster(posterURL: String) {
        self.networkService.loadImageOfMovie(imageURL: posterURL) { (result) in
            guard let result = result else { return }
            DispatchQueue.main.sync {
                self.delegate?.posterImage = result
                self.delegate?.updateImage()
            }
        }
    }
}
