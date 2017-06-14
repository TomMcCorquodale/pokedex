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
    fileprivate var _nextEvoName: String!
    fileprivate var _nextEvoId: String!
    fileprivate var _nextEvoLevel: String!
    
    var nextEvoName: String {
        
        if _nextEvoName == nil {
            
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvoId: String {
        
        if _nextEvoId == nil {
            
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoLevel: String {
        
        if _nextEvoLevel == nil {
            
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    
    var nextEvoText: String {
        if _nextEvoTxt == nil {
            
            _nextEvoTxt = ""
        }
        
        return _nextEvoTxt
    }
    
    var attack: String {
        
        if _attack == nil {
            
            _attack = ""
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
            
            _defense = ""
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

                if let descriptionArray = dict["descriptions"] as? [Dictionary<String,String>] , descriptionArray.count > 0 {
       
                    if let url = descriptionArray[0]["resource_uri"] {
                        
                        let combinedURL = URL(string: "\(BASE_URL)\(url)")
                        
                        Alamofire.request(combinedURL!).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    self._description = newDescription
                                    
                                    print(self._description)
                                }
                            }
                            completed()
                        })
                        
                    }
                    
                } else {
                    
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                            
                            self._nextEvoName = nextEvo
                            
                            if let url = evolutions[0]["resource_uri"] as? String {
                                print(url)
                                
                                let newStr = url.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                
                                print(newStr)
                                let nextEvoID = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvoId = nextEvoID
                                
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    
                                    if let lvl = lvlExist as? Int {
                                        
                                        self._nextEvoLevel = "\(lvl)"
                 
                                    }
                                    
                                } else {
                                    
                                    self._nextEvoLevel = ""
                                       
                                }
                                
                                
                                
                            }
                            
                            
                        }
                        
                        
                    }
               
            }
            }
            
             completed()
        }
        
        
    }
    
}
