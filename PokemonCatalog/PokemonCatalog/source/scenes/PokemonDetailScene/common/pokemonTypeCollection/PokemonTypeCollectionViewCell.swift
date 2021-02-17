//
//  PokemonTypeCollectionViewCell.swift
//  PokemonCatalog
//
//  Created by Oscar Ceretti on 17/02/2021.
//

import Foundation
import UIKit
import SnapKit

class PokemonTypeCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "PokemonTypeCollectionViewCell__"
    
    let pokemonImage = UIImageView(frame: .zero).then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds  = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    func setupViews(){
        self.addSubview(pokemonImage)
        self.pokemonImage.snp.remakeConstraints { (make) in
            make.edges.equalTo(self)
        }
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
