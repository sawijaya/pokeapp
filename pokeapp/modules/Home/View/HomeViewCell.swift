//
//  HomeViewCell.swift
//  pokeapp
//
//  Created by Salim Wijaya on 02/02/21.
//

import UIKit
import Kingfisher

class HomeViewCell: UITableViewCell {
    static let identifier: String = "HomeViewCellIdentifier"
    @IBOutlet weak var imgvw: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet var imgvwTypes: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgvwTypes.sort { (imgvw1, imgvw2) -> Bool in
            return imgvw1.tag < imgvw2.tag
        }
        
        self.imgvwTypes.forEach { (imgvw) in
            imgvw.layer.cornerRadius = imgvw.frame.height / 2
        }
        
        if let url: URL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png") {
            self.imgvw.kf.setImage(with: url)
        }
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.backgroundColor = UIColor(red: 151/255, green: 234/255, blue: 254/255, alpha: 1)
        } else {
            contentView.backgroundColor = UIColor.white
        }
        // Configure the view for the selected state
    }
    
}
