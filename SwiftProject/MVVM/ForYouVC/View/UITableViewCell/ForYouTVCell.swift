//
//  ForYouTVCell.swift
//  SwiftProject
//
//  Created by Admin on 02/04/24.
//

import UIKit

class ForYouTVCell: UITableViewCell {
    
    @IBOutlet weak var trackImg: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
