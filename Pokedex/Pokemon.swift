//
//  Pokemon.swift
//  Pokedex
//
//  Created by Héctor Moreno on 20/10/16.
//  Copyright © 2016 Héctor Moreno. All rights reserved.
//

import Foundation
import Alamofire

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
    private var _nextEvolutionID: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    
    var name: String {
        
        return _name
    }
    
    var pokedexID: Int {
      
        return _pokedexID
    }
    
    var pokemonDescription: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionLvl: String {
        if _nextEvolutionLvl == nil {
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }
    
    
    init(name: String, pokedexID: Int){
        self._name = name
        self._pokedexID = pokedexID
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexID)/"
    }

    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            if let JSON = response.result.value as? [String: AnyObject] {
                
                if let  weight = JSON["weight"] as? String {
                    self._weight = weight
                    print(self._weight)
                }
            
                if let height = JSON["height"] as? String {
                    self._height = height
                    print(self._height)
                    
                }
                
                if let attack = JSON["attack"] as? Int {
                    self._attack = "\(attack)"
                    print(self._attack)
                }
                
                if let defense = JSON["defense"] as? Int {
                    self._defense = "\(defense)"
                    print(self._defense)
                }
                
                if let types = JSON["types"] as? [[String: AnyObject]] where types.count > 0 {
                    if let name = types[0]["name"] as? String {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"] as? String {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                
                } else {
                    self._type = ""
                }
                
                print(self._type)
                
                if let descArr = JSON["descriptions"] as? [[String: AnyObject]] where descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"]{
                        let url = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, url).responseJSON { response in
                            if let JSON = response.result.value as? [String: AnyObject] {
                                if let pokeDescription = JSON["description"] as? String {
                                    self._description = pokeDescription
                                    print(self._description)
                                }
                            }
                            completed()
                        }
                        
                        
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = JSON["evolutions"] as? [[String: AnyObject]] where evolutions.count > 0 {
                    if let to = evolutions[0]["to"] as? String {
                            //Can´t support mega pokemon right now but api still has mega data
                        if to.rangeOfString("mega") == nil {
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newString = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newString.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionID = num
                                self._nextEvolutionTxt = to
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLvl = "\(lvl)"
                                    print(self._nextEvolutionLvl)
                                }
                                
                                print(self._nextEvolutionID)
                                print(self._nextEvolutionTxt)
                                
                                
                            }
                         }
                    }
                }
    
            }
        }
    }
    
}
