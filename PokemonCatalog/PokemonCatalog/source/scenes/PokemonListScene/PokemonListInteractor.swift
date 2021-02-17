//
//  PokemonListInteractor.swift
//  PokemonCatalog
//
//  Created by Oscar Ceretti on 15/02/2021.
//

import Foundation

protocol PokemonListInteractorInterface {
    func getPokemonEntity(completion: @escaping ([Pokemon]?,Error?) -> ())
}

final class PokemonListInteractor: PokemonListInteractorInterface {
    typealias Dependencies = HasPokemonManager
    let dependencies: Dependencies
    
    private var pokeData: PokemonList?
    
    init (dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    deinit{}
    
    func getPokemonEntity(completion: @escaping ([Pokemon]?,Error?) -> ()){
        var updatedPokemons: [Pokemon] = []
        self.dependencies.pokemonManager.getPokemonList(next: self.pokeData?.next) { (pokemonList,error) in
            let myGroup = DispatchGroup()
            self.pokeData = pokemonList
            if let data = pokemonList {
                for pokemon in data.results {
                    myGroup.enter()

                    self.dependencies.pokemonManager.getPokemonDetail(urlString: pokemon.url) { (pokemonDetail, error) in
                        if let detail = pokemonDetail {
                            var sprite: String = ""
                            if let front = detail.sprites?.frontDefault {
                                sprite = front
                            } else if let frontShiny = detail.sprites?.frontShiny{
                                sprite = frontShiny
                            } else if let official = detail.sprites?.other?.officialArtwork?.frontDefault {
                                sprite = official
                            }
                            let newPokemonData = Pokemon(name: pokemon.name, url: pokemon.url, sprite: sprite)
                            if !sprite.isEmpty{
                                updatedPokemons.append(newPokemonData)
                            }
                            myGroup.leave()
                        }else {
                            myGroup.leave()
                        }
                        
                    }
                }
               
                myGroup.notify(queue: .main) {
                    completion(updatedPokemons,error)
                }
                
            }else {
                completion(nil,error)
            }
        }
    }
}

