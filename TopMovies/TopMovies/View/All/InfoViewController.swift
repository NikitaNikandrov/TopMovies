//
//  InfoViewController.swift
//  TopMovies
//
//  Created by Никита on 30.05.2021.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoLabel.numberOfLines = 0
        self.infoLabel.text = """
            The TMDb APIs are owned by TMDb, Inc. and are licensed to you on a worldwide (except as limited below), non-exclusive, non-transferable, non-sublicenseable basis on the terms and conditions set forth herein. These terms define legal use of the TMDb APIs, all updates, revisions, substitutions that may be made available by TMDb, and any copies of the TMDb APIs made by or for you. TMDb reserves all rights not expressly granted to you.
            For more infomation please visit:
            https://www.themoviedb.org/privacy-policy
            """
    }

}
