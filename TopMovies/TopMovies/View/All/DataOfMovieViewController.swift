//
//  DataOfMovieViewController.swift
//  TopMovies
//
//  Created by Никита on 27.06.2021.
//

import UIKit

class DataOfMovieViewController: UIViewController {
    
    private var presenter: DataOfMovieVCPresenter!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var posterOfMovie: UIImageView!
    @IBOutlet weak var dateOfMovieLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dataOfMovieLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var remindeButton: UIButton!
    
    @IBAction func remindeMeButtonIsPressed(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let calendarVC = storyboard.instantiateViewController(identifier: "CalendarViewController") as? CalendarViewController else { return }
        CalendarViewControllerData.shared.movieNameForNotification = self.title
        show(calendarVC, sender: nil)
    }
    
    @IBAction func addButtonIsPressed(_ sender: Any) {
        presenter.addButtonIsPressed(title: self.title!)
        setAddButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = DataOfMovieVCPresenter()
        presenter.delegate = self
        
        self.tabBarController?.tabBar.isHidden = true
        
        self.posterOfMovie.image = DataViewControllerData.shared.posterPicture
        self.dateOfMovieLabel.text = DataViewControllerData.shared.dateOfMovieLabelText
        self.ratingLabel.text = DataViewControllerData.shared.ratingLabelText
        setupRatingLabel(ratingValue: self.presenter.getRatingInInt(string: self.ratingLabel.text!))
        
        self.dataOfMovieLabel.text = DataViewControllerData.shared.dataOfMovieLabelTtext
        setupDataLabel()
        setAddButton()
        setRemindButton()
    }
    
    func setupDataLabel() {
        self.dataOfMovieLabel.lineBreakMode = .byWordWrapping
        self.dataOfMovieLabel.numberOfLines = 0
        self.dataOfMovieLabel.sizeToFit()
    }
    
    func setupRatingLabel(ratingValue: Int) {
        self.ratingLabel.textColor = .white
        self.ratingLabel.backgroundColor = .black
        self.ratingLabel.layer.masksToBounds = true
        self.ratingLabel.layer.cornerRadius = self.ratingLabel.layer.bounds.width/2
        self.ratingLabel.layer.borderWidth = 3
        if ratingValue >= 70 {
            self.ratingLabel.layer.borderColor = UIColor.systemGreen.cgColor
        } else {
            if ratingValue < 70 && ratingValue >= 50 {
                self.ratingLabel.layer.borderColor = UIColor.systemYellow.cgColor
            } else {
                self.ratingLabel.layer.borderColor = UIColor.systemRed.cgColor
            }
        }
        
        
    }
    
    func setAddButton() {
        if movieIsFavourite() {
            self.addButton.setTitle("Remove from favourite", for: .normal)
            self.addButton.setTitleColor(.white, for: .normal)
            self.addButton.backgroundColor = .systemRed
            self.addButton.layer.cornerRadius = 5
        } else {
            self.addButton.setTitle("Add to favourite", for: .normal)
            self.addButton.setTitleColor(.white, for: .normal)
            self.addButton.backgroundColor = .systemGreen
            self.addButton.layer.cornerRadius = 5
        }
    }
    
    func setRemindButton() {
        self.remindeButton.setTitle("Remind me", for: .normal)
        self.remindeButton.setTitleColor(.white, for: .normal)
        self.remindeButton.backgroundColor = .systemGray2
        self.remindeButton.layer.cornerRadius = 5
    }
    
}

extension DataOfMovieViewController: DataOfMovieVCPresenterProtocol {
    
    func movieIsFavourite() -> Bool {
        var answer = false
        for movie in FavouritViewControllerData.shared.favouriteMovies ?? [] {
            if movie == self.title {
                answer = true
                break
            }
        }
        return answer
    }
}
