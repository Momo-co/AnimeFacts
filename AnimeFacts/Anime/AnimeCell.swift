//
//  AnimeCell.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import UIKit

class AnimeCell: UITableViewCell {
    
    
    @IBOutlet weak var animeImageView: UIImageView!
    
    @IBOutlet weak var animeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpAnimeName(name: String) {
        animeNameLabel.text = name
    }
    
    func setUpAnimeImage(imageURL: String) {
        animeImageView.downloaded(from: imageURL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
