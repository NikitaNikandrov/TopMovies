//
//  ViewController.swift
//  TopMovies
//
//  Created by Никита on 30.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    
    private var dataOfMovies = DataOfMovies()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = dataOfMovies.dataOfMovie?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        guard let movie = dataOfMovies.dataOfMovie?[indexPath.row] else { return cell }
        cell.loadCell(movie: movie)
        return cell
    }
}
