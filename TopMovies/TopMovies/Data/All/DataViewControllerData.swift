//
//  DataViewControllerData.swift
//  TopMovies
//
//  Created by Никита on 03.07.2021.
//

import Foundation
import UIKit

final class DataViewControllerData {
    static var shared = DataViewControllerData()
    private init() {
        dateOfMovieLabelText = nil
        ratingLabelText = nil
        dataOfMovieLabelTtext = nil
    }
    
    var posterPicture: UIImage?
    var dateOfMovieLabelText: String?
    var ratingLabelText: String?
    var dataOfMovieLabelTtext: String?
}
