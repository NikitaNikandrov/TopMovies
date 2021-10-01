//
//  FavouritsViewController.swift
//  TopMovies
//
//  Created by Никита on 21.06.2021.
//

import UIKit

class FavouritsViewController: UIViewController {
    
    @IBOutlet weak var favourutsMovieTableView: UITableView!
    
    let cellReuseID = "Cell"
    
    private var presenter: FavouritsViewControllerPresenter!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.favourutsMovieTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter = FavouritsViewControllerPresenter()
        presenter.loadDataFromDefaults()
        
        self.title = "Favourit movies"
        self.favourutsMovieTableView.delegate = self
        self.favourutsMovieTableView.dataSource = self
        self.favourutsMovieTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
    }
    
}

extension FavouritsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavouritViewControllerData.shared.favouritMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellReuseID)
        let movie = FavouritViewControllerData.shared.favouritMovies?[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row + 1)" + ". \(movie ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FavouritViewControllerData.shared.favouritMovies?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        self.favourutsMovieTableView.reloadData()
    }
}
