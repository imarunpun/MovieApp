//
//  MovieTVCell.swift
//  SampleProject
//
//  Created by Arun on 28/10/21.
//  Copyright © 2021 Arun. All rights reserved.
//

import UIKit

class MovieTVCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var voteLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureWith(movie: Movie, imageSize: ImageSize) {
        
        nameLbl.text = movie.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let releaseDate = movie.releaseDate, let dateResult = dateFormatter.date(from: releaseDate) {
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            let formattedDate = dateFormatter.string(from: dateResult)
            dateLbl.text = formattedDate
        }
        
        voteLbl.text = "\(movie.voteAverage)"
    }

}
