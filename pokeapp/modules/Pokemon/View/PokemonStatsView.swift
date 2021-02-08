//
//  PokemonStatsView.swift
//  pokeapp
//
//  Created by Salim Wijaya on 07/02/21.
//

import UIKit

class PokemonStatsView: UIView {

    @IBOutlet var imgvwTypes: [UIImageView]!
    var pokemon:NSDictionary?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgvwTypes.forEach { (imgvw) in
            imgvw.layer.cornerRadius = 20
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    deinit {
        print(#file, #function)
    }

}
