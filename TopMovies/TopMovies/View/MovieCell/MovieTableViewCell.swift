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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
