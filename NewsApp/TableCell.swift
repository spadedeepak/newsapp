//
//  TableCell.swift
//  NewsApp
//
//  Created by deepak on 19/09/23.
//

import UIKit

class TableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var img: UIImageView!
    
    
    @IBAction func share(_ sender: Any) {
    }
    
    @IBOutlet weak var title: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


