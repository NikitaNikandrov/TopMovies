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
    @IBOutlet weak var nameOfMovieLabel: UILabel!
    @IBOutlet weak var dateOfMovieLabel: UILabel!
    @IBOutlet weak var dataOfMovieLabel: UILabel!
    
    @IBOutlet weak var sheduleButton: UIButton!
    @IBAction func sheduleButtonIsPressed(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func loadCell(movie: Movie) {
        self.imageOfMovie.image = movie.imageOfMovie
        self.numberOfRateLabel.text = movie.numberOfRate
        self.nameOfMovieLabel.text = movie.nameOfMovie
        self.dataOfMovieLabel.text = movie.dataOfMovie
        self.dateOfMovieLabel.text = movie.dateOfMovie
    }
}
