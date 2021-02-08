//
//  PokemonEvolutionView.swift
//  pokeapp
//
//  Created by Salim Wijaya on 08/02/21.
//

import UIKit

class PokemonEvolutionView: UIView {
    
}

extension PokemonEvolutionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension PokemonEvolutionView: UITableViewDelegate {
    
}
