//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Arun on 28/10/21.
//  Copyright © 2021 Arun. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        
        self.nameLbl.text = movie.title
        
        var backdropURL: URL?
        if let backdrop =  movie.backdrop {
            let imageUrl = String(format: ApiList.imageBaseUrl, ImageSize.medium.rawValue) + backdrop
            backdropURL = URL(string: imageUrl)
            self.imageView.loadImageUsingCacheWith(backdropURL)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let releaseDate = movie.releaseDate, let dateResult = dateFormatter.date(from: releaseDate) {
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            let formattedDate = dateFormatter.string(from: dateResult)
            dateLbl.text = formattedDate
        }
        
        self.overviewLbl.text = movie.overview
    }
    
}
