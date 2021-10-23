//
//  NSCacheService.swift
//  TopMovies
//
//  Created by Никита on 23.10.2021.
//

import Foundation
import UIKit

final class PosterOfMoviesCache {
    static var shared = NSCache<NSString, UIImage>()
    private init() {}
}
