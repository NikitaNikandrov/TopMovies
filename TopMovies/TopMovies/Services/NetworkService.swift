//
//  NetworkService.swift
//  TopMovies
//
//  Created by Никита on 01.04.2021.
//

import Foundation
import UIKit

class NetworkService {
    
    func loadDataOfMovies(closure: @escaping(([MovieData]?) -> Void)) {
        
        var resultResponce: JSONMovies.JsonMoviesResponse?
        
        guard var urlComp = URLComponents(string: "https://api.themoviedb.org/3/discover/movie?") else {
            closure(nil)
            return
        }
        
        var year = SettingsOfListData.shared.choosedYear
        if year == nil {
            let date = Date()
            let calendar = Calendar.current
            year = "\(calendar.component(.year, from: date))"
        }
        
        let queryItems = [URLQueryItem(name: "api_key", value: "7a5c24768228083f2aca064e6429ebde"),
                          URLQueryItem(name: "sort_by", value: "popularity.desc"),
                          URLQueryItem(name: "primary_release_year", value: year)]
        urlComp.queryItems = queryItems
        
        guard let urlFinal = urlComp.url else {
            closure(nil)
            return
        }
        
        URLSession.shared.dataTask(with: urlFinal) { (data, _, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                resultResponce = try JSONDecoder().decode(JSONMovies.JsonMoviesResponse.self, from: data)
                guard let countOfMoviesInResponce = resultResponce!.results?.count else { return }
                if countOfMoviesInResponce == 0 { return closure(nil) } else {
                    var result: [MovieData] = []
                    for index in 0...(countOfMoviesInResponce - 1) {
                        let value = MovieData()
                        
                        guard let poster = resultResponce?.results?[index].posterPath else {
                            return value.posterURLOfMovie = ""
                        }
                        value.posterURLOfMovie = poster
                        
                        guard let rating = resultResponce?.results?[index].voteAverage else {
                            return value.numberOfRating = 0
                        }
                        value.numberOfRating = rating
                        
                        guard let title = resultResponce?.results?[index].title else {
                            return value.titleOfMovie = ""
                        }
                        value.titleOfMovie = title
                        
                        guard let overview = resultResponce?.results?[index].overview else {
                            return value.overviewOfMovie = ""
                        }
                        value.overviewOfMovie = overview
                        
                        guard let date = resultResponce?.results?[index].releaseDate else {
                            return value.releaseDateOfMovie = ""
                        }
                        value.releaseDateOfMovie = date
                        
                        result.append(value)
                    }
                    closure(result)
                }
            } catch let error { print(error) }
        } .resume()
    }
    
    func loadImageOfMovie(imageURL: String, closure: @escaping((UIImage?) -> Void)) {
        
        var url = "https://image.tmdb.org/t/p/w500"
        url += imageURL
        guard let urlResponce = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: urlResponce) { [ weak self ] (data, _, _) in
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            closure(image)
        }
        task.resume()
    }
}
