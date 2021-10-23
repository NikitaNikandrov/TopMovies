//
//  MovieTableViewCell.swift
//  TopMovies
//
//  Created by Никита on 30.03.2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    weak var delegate: MainVCDelegateToCellProtocol?
    
    @IBOutlet weak var posterOfMovie: UIImageView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleOfMovieLabel: UILabel!
    @IBOutlet weak var dateOfMovieLabel: UILabel!
    @IBOutlet weak var dataOfMovieLabel: UILabel!
    
    @IBOutlet weak var viewMoreButton: UIButton!
    
    @IBAction func viewMoreButtonIsPressed(_ sender: Any) {
        self.delegate?.presentDataOfMovieVC(movieName: self.titleOfMovieLabel.text!, moviePoster: self.posterOfMovie.image!, movieDate: self.dateOfMovieLabel.text!, movieRate: self.ratingLabel.text!, movieData: self.dataOfMovieLabel.text!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func loadCell(movie: MovieData) {
        
        self.posterOfMovie.loadPoster(posterURL: movie.posterURLOfMovie ?? "")
        
        self.ratingLabel.text = String(format: "%g", movie.numberOfRating!*10) + "%"
        setupRatingLabel(rating: Int((movie.numberOfRating!)*10))
        
        self.titleOfMovieLabel.text = movie.titleOfMovie
        setupTitleLabel()
        
        self.dataOfMovieLabel.text = movie.overviewOfMovie
        setupDataLabel()
        
        self.dateOfMovieLabel.text = movie.releaseDateOfMovie
        
        self.viewMoreButton.setTitle("View more", for: .normal)
        self.viewMoreButton.setTitleColor(.white, for: .normal)
        self.viewMoreButton.backgroundColor = .systemGray2
        self.viewMoreButton.layer.cornerRadius = 5
    }
    
    func loadCellWithCache(movie: MovieData, cachedImage: UIImage) {
        
        self.posterOfMovie.image = cachedImage
        
        self.ratingLabel.text = String(format: "%g", movie.numberOfRating!*10) + "%"
        setupRatingLabel(rating: Int((movie.numberOfRating!)*10))
        
        self.titleOfMovieLabel.text = movie.titleOfMovie
        setupTitleLabel()
        
        self.dataOfMovieLabel.text = movie.overviewOfMovie
        setupDataLabel()
        
        self.dateOfMovieLabel.text = movie.releaseDateOfMovie
        
        self.viewMoreButton.setTitle("View more", for: .normal)
        self.viewMoreButton.setTitleColor(.white, for: .normal)
        self.viewMoreButton.backgroundColor = .systemGray2
        self.viewMoreButton.layer.cornerRadius = 5
    }
    
    func setupRatingLabel(rating: Int) {
        self.ratingLabel.textColor = .white
        self.ratingLabel.backgroundColor = .black
        self.ratingLabel.layer.masksToBounds = true
        self.ratingLabel.layer.cornerRadius = self.ratingLabel.layer.bounds.width/2
        self.ratingLabel.layer.borderWidth = 3
        if rating >= 70 {
            self.ratingLabel.layer.borderColor = UIColor.systemGreen.cgColor
        } else {
            if rating < 70 && rating >= 50 {
                self.ratingLabel.layer.borderColor = UIColor.systemYellow.cgColor
            } else {
                self.ratingLabel.layer.borderColor = UIColor.systemRed.cgColor
            }
        }
        
    }
    
    func setupTitleLabel() {
        self.titleOfMovieLabel.lineBreakMode = .byWordWrapping
        self.titleOfMovieLabel.numberOfLines = 0
        self.titleOfMovieLabel.sizeToFit()
    }
    
    func setupDataLabel() {
        self.dataOfMovieLabel.adjustsFontSizeToFitWidth = false
        self.dataOfMovieLabel.lineBreakMode = .byTruncatingTail
        self.dataOfMovieLabel.numberOfLines = 0
    }
}

extension UIImageView {
    func loadPoster(posterURL: String) {
        let networkService = NetworkService()
        networkService.loadImageOfMovie(imageURL: posterURL) { (result) in
            guard let result = result else { return }
            DispatchQueue.main.async {
                self.image = result
                PosterOfMoviesCache.shared.setObject(result, forKey: posterURL as NSString)
            }
        }
    }
}
