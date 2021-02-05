//
//  RepositoryAssemblyContainer.swift
//  pokeapp
//
//  Created by Salim Wijaya on 03/02/21.
//

import Foundation
import Swinject

final class RepositoryAssemblyContainer: Assembly {
    func assemble(container: Container) {
        container.register(IPokemonRepository.self) { r in
            let repository: PokemonRepository = PokemonRepository()
            return repository
        }
    }
}
