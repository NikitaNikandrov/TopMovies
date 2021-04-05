//
//  ViewController.swift
//  TopMovies
//
//  Created by Никита on 30.03.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var listOfMovies: [MovieData] = []
    private var presenter: MainViewControllerPresenter!
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        
        presenter = MainViewControllerPresenter()
        presenter.delegate = self
        presenter.loadListOfMovies()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, MainVCPresenterProtocol, MainVCDelegateToCellProtocol {
    
    func presentCalendarVC(movieName: String) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let calendarVC = storyboard.instantiateViewController(identifier: "CalendarViewController") as? CalendarViewController else { return }
        calendarVC.movieNameForNotification = movieName
        show(calendarVC, sender: nil)
    }
    
    func updateVC() {
        self.moviesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = listOfMovies.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        let movie = listOfMovies[indexPath.row]
        cell.loadCell(movie: movie)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
