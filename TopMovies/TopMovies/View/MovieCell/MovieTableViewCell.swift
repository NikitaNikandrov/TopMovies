//
//  MovieTableViewCell.swift
//  TopMovies
//
//  Created by Никита on 30.03.2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOfMovie: UIImageView!
    
    @IBOutlet weak var numberOfRateLabel: UILabel!
    @IBOutlet weak var titleOfMovieLabel: UILabel!
    @IBOutlet weak var releaseDateOfMovieLabel: UILabel!
    @IBOutlet weak var overviewOfMovieLabel: UILabel!
    
    @IBOutlet weak var sheduleButton: UIButton!
    @IBAction func sheduleButtonIsPressed(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func loadCell(movie: MovieData) {
        self.numberOfRateLabel.text = String(format: "%f", movie.numberOfRating!)
        self.titleOfMovieLabel.text = movie.titleOfMovie
        self.overviewOfMovieLabel.text = movie.overviewOfMovie
        self.releaseDateOfMovieLabel.text = movie.releaseDateOfMovie
    }
}
