//
//  AnimeFactTableViewCell.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import UIKit

class AnimeFactsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var animeFactLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpFactDescription(fact: String) {
        animeFactLabel.text = fact
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
