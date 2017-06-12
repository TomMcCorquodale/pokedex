//
//  Pokemon.swift
//  pokedex
//
//  Created by Thomas McCorquodale on 6/7/17.
//  Copyright © 2017 Tom McCorquodale. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _description: String!
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _attack: String!
    fileprivate var _nextEvoTxt: String!
    fileprivate var _pokemonURL: String!
    
    
    var nextEvoText: String {
        if _nextEvoTxt == nil {
            
            _nextEvoTxt = ""
        }
        
        return _nextEvoTxt
    }
    
    var attack: String {
        
        if _attack == nil {
            
            _attack = " "
        }
        return _attack
    }
    
    var weight: String {
        
        if _weight == nil {
            
            _weight = ""
        }
        return _weight
    }
    
    var height: String {
        
        if _height == nil {
            
            _height = ""
        }
        return _height
    }
    
    var defense: String {
        
        if _defense == nil {
            
            _defense = " "
        }
        return _defense
    }
    
    var type: String {
        
        if _type == nil {
            
            _type = ""
        }
        return _type
    }
    
    var description: String {
        
        if _description == nil {
            
            _description = ""
        }
        return _description
    }
    var name: String {
        
        if _name == nil {
            
            _name = ""
        }
        
        return _name
    }
    
    var pokedexId: Int {
        
        return _pokedexId
        
    }

    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(BASE_URL)\(POKEMON_URL)\(self.pokedexId)"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                    
                }
                
                if let height = dict["height"] as? String {
                    
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        
                        
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                            }
                            
                        }
                    }
                    
                } else {
                    
                    self._type = ""
                }
                
                
                completed()
            }
            
            
            
        }
        
        
    }
    
}
