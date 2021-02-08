//
//  PokemonEvolutionView.swift
//  pokeapp
//
//  Created by Salim Wijaya on 08/02/21.
//

import UIKit

class PokemonEvolutionView: UIView {
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 160
        self.tableView.reloadData()
        
        let nib: UINib = UINib(nibName: "PokemonEvolutionViewCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: PokemonEvolutionViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var contentSize:CGSize {
        return self.tableView.contentSize
    }
}

extension PokemonEvolutionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonEvolutionViewCell.identifier)!
        return cell
    }
}

extension PokemonEvolutionView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
