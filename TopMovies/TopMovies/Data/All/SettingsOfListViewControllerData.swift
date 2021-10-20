//
//  SettingsOfListViewControllerData.swift
//  TopMovies
//
//  Created by Никита on 13.06.2021.
//

import Foundation

final class SettingsOfListData {
    static var shared = SettingsOfListData()
    private init() {
        choosedYear = nil
        choosedYearRow = -1
        ChoosedSortRow = 0
        sortPickerOptions = ["Popularity high to low", "Popularity low to high" ,"New first", "Old first"]
        yearPickerOptions = []
    }
    
    var choosedYear: String?
    var choosedYearRow : Int
    var ChoosedSortRow : Int
    let sortPickerOptions : [String]
    var yearPickerOptions : [Int]
}
