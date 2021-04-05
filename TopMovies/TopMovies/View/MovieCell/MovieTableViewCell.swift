//
//  MovieTableViewCell.swift
//  TopMovies
//
//  Created by Никита on 30.03.2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    weak var delegate: MainVCDelegateToCellProtocol?
    private var presenter: MovieTableViewCellPresenter!
    var posterImage: UIImage? = nil
    
    @IBOutlet weak var posterOfMovie: UIImageView!
    
    @IBOutlet weak var numberOfRateLabel: UILabel!
    @IBOutlet weak var titleOfMovieLabel: UILabel!
    @IBOutlet weak var releaseDateOfMovieLabel: UILabel!
    @IBOutlet weak var overviewOfMovieLabel: UILabel!
    
    @IBOutlet weak var sheduleButton: UIButton!
    
    @IBAction func sheduleButtonIsPressed(_ sender: Any) {
        self.delegate?.presentCalendarVC(movieName: self.titleOfMovieLabel.text!)
    }
 
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func loadCell(movie: MovieData) {
        
        presenter = MovieTableViewCellPresenter()
        presenter.delegate = self
        presenter.loadPoster(posterURL: movie.posterURLOfMovie!)
        
        self.numberOfRateLabel.text = String(format: "%g", movie.numberOfRating!*10)
        
        self.titleOfMovieLabel.text = movie.titleOfMovie
        setupLabel(label: self.titleOfMovieLabel)
        
        self.overviewOfMovieLabel.text = movie.overviewOfMovie
        setupLabel(label: self.overviewOfMovieLabel)
        
        self.releaseDateOfMovieLabel.text = movie.releaseDateOfMovie
        
        self.sheduleButton.setTitle("Shedule viewing", for: .normal)
    }
    
    func setupLabel(label: UILabel) {
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
    }
}

extension MovieTableViewCell: MovieTableViewCellPresenterProtocol {
    func updateImage() {
        self.posterOfMovie.image = self.posterImage
    }
}
