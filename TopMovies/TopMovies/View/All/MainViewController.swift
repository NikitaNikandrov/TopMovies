//
//  ViewController.swift
//  TopMovies
//
//  Created by Никита on 30.03.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private var presenter: MainViewControllerPresenter!
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoButton: UIBarButtonItem!
    @IBOutlet weak var settingsOfListButton: UIBarButtonItem!
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    @IBAction func infoButtonIsPressed(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let InfoVC = storyboard.instantiateViewController(identifier: "InfoViewController") as? InfoViewController else { return }
        show(InfoVC, sender: nil)
    }
    @IBAction func settingsButtonIsPressed(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let settingOfListVC = storyboard.instantiateViewController(identifier: "SettingsOfListViewController") as? SettingsOfListViewController else { return }
        settingOfListVC.mainVCdelegate = self
        show(settingOfListVC, sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MainViewControllerPresenter()
        presenter.delegate = self
        
        self.moviesTableView.isHidden = true
        loadVC()
        self.moviesTableView.isHidden = false
        self.moviesTableView.tableHeaderView = movieSearchBar
        self.moviesTableView.keyboardDismissMode = .onDrag
        
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
        self.moviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
       
        setTitleVC()
        
        self.movieSearchBar.delegate = self
        
        self.infoButton.title = "Info"
        self.settingsOfListButton.title = "Settings"
        
        self.tabBarController?.tabBar.items?[1].title = "Favourit movies"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.filteringMovies(searchText: searchText)
    }
    
    func setTitleVC() {
        var year = SettingsOfListData.shared.choosedYear
        if year == nil {
            year = presenter.getCurrentYear()
        }
        self.title = "Top Movies \(year ?? "")"
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, MainVCPresenterProtocol, MainVCDelegateToCellProtocol, UISearchBarDelegate {
    // MainVCdelegateProtocol
    func presentDataOfMovieVC(movieName: String, moviePoster: UIImage, movieDate: String, movieRate: String, movieData: String) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let dataOfMovieVC = storyboard.instantiateViewController(identifier: "DataOfMovieViewController") as? DataOfMovieViewController else { return }
        dataOfMovieVC.title = movieName
        DataViewControllerData.shared.posterPicture = moviePoster
        DataViewControllerData.shared.dateOfMovieLabelText = movieDate
        DataViewControllerData.shared.ratingLabelText = movieRate
        DataViewControllerData.shared.dataOfMovieLabelTtext = movieData
        show(dataOfMovieVC, sender: nil)
    }
    //MainVCPresenterProtocol
    func loadVC() {
        presenter.loadListOfMovies()
    }
    
    func updateVC() {
        self.setTitleVC()
        self.moviesTableView.reloadData()
    }
    
    func startActivityIndicator() {
        self.view.addSubview(loadingActivityIndicator)
        self.loadingActivityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        self.loadingActivityIndicator.stopAnimating()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = MainViewControllerData.shared.filteredMovies.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        var movie: MovieData!
        if movieSearchBar.searchTextField.text != nil {
            movie = MainViewControllerData.shared.filteredMovies[indexPath.row]
        } else {
            movie = MainViewControllerData.shared.listOfMovies[indexPath.row]
        }
        cell.loadCell(movie: movie)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
