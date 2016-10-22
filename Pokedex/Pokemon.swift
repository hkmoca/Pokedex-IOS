//
//  Pokemon.swift
//  Pokedex
//
//  Created by Héctor Moreno on 20/10/16.
//  Copyright © 2016 Héctor Moreno. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonUrl: String!
    
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int){
        self._name = name
        self._pokedexID = pokedexID
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexID)/"
    }

    func downloadPokemonDetails(completed: DownloadComplete) {
        
    }
}
