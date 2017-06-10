//
//  PokeCell.swift
//  pokedex
//
//  Created by Thomas McCorquodale on 6/7/17.
//  Copyright © 2017 Tom McCorquodale. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    
    
    
    func configCell(_ pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    }
    
    
    
}
