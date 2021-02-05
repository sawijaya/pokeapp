//
//  ServiceAssemblyContainer.swift
//
//  Created by Salim Wijaya
//

import Foundation
import Swinject

final class ServiceAssemblyContainer: Assembly {
    func assemble(container: Container) {
        container.register(IPokemonService.self) { r in
            let service: PokemonService = PokemonService()
            let network: PokemonNetworkService = r.resolve(IPokemonNetworkService.self) as! PokemonNetworkService
            network.out = service
            service.network = network
            
            let repository: PokemonRepository = r.resolve(IPokemonRepository.self) as! PokemonRepository
            repository.out = service
            service.repository = repository
            return service
        }
        
        container.register(IPokemonNetworkService.self) { r in
            let service: PokemonNetworkService = PokemonNetworkService()
            return service
        }

        container.register(IPokemonRealmService.self) { r in
            let service: PokemonRealmService = PokemonRealmService()
            return service
        }
        
    }
}
