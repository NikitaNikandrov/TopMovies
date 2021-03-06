//
//  ViewController.swift
//  TopMovies
//
//  Created by Никита on 30.03.2021.
//

import UIKit
import Network

class MainViewController: UIViewController {
    
    //Mark: variables
    
    private var presenter: MainViewControllerPresenter!
    private var internetIsAvailble: Bool?
    
    //Mark: const
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
    //Mark: outlets
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoButton: UIBarButtonItem!
    @IBOutlet weak var settingsOfListButton: UIBarButtonItem!
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    @IBOutlet weak var noInternetImage: UIImageView!
    
    //Mark: actions
    
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
    
    //Mark: lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // delegate & presenter
        self.presenter = MainViewControllerPresenter()
        self.presenter.delegate = self
        
        // table view
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
        self.moviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        
        self.moviesTableView.tableHeaderView = self.movieSearchBar
        self.moviesTableView.keyboardDismissMode = .onDrag
        
        // searchbar
        self.movieSearchBar.delegate = self
        
        // set items on vc
        setTitleVC()
        
        self.infoButton.title = "Info"
        self.settingsOfListButton.title = "Settings"
        
        self.tabBarController?.tabBar.items?[1].title = "Favourite movies"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        self.moviesTableView.isHidden = true
        self.movieSearchBar.isHidden = true
        self.noInternetImage.isHidden = true
        // checkinig an internet access
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                self.internetIsAvailble = true
            } else {
                self.internetIsAvailble = false
            }
        }
        monitor.start(queue: queue)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if internetIsAvailble ?? false {
            // loaddata
            loadVC()
            self.moviesTableView.isHidden = false
            self.movieSearchBar.isHidden = false
        } else {
            let alert = UIAlertController(title: "There's no internet connection.", message: "Please, check your internet access", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.noInternetImage.isHidden = false
        }
    }
    
    //Mark: self methods
    
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
    //Mark: MainVCdelegateProtocol methods
    //Mark: this method used in tableview cell action button
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
    
    //Mark: MainVCPresenterProtocol methods
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
    
    //Mark: TableView methods
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
        
        let cashedImageURL = movie.posterURLOfMovie! as NSString
        if let cachedImage = PosterOfMoviesCache.shared.object(forKey: cashedImageURL) {
            cell.loadCellWithCache(movie: movie, cachedImage: cachedImage)
        } else {
            cell.loadCell(movie: movie)
        }
    
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? MovieTableViewCell
        self.presentDataOfMovieVC(movieName: cell!.titleOfMovieLabel.text!, moviePoster: cell!.posterOfMovie.image!, movieDate: cell!.dateOfMovieLabel.text!, movieRate: cell!.ratingLabel.text!, movieData: cell!.dataOfMovieLabel.text!)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
