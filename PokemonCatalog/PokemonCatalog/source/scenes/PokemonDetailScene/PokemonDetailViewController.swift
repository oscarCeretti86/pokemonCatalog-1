//
//  PokemonDetailViewController.swift
//  PokemonCatalog
//
//  Created by Oscar Ceretti on 13/02/2021.
//

import Foundation
import UIKit
import SnapKit
class PokemonDetailViewController: UIViewController {
    
    private var viewModel: PokemonDetailViewModel
    private var mainView = PokemonDetailView()
    
    
    init(viewModel: PokemonDetailViewModel, router: PokemonDetailRouter) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.addSubview(mainView)
        mainView.snp.remakeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
        self.viewModel.callFuncToGetPokemonDetail()
        self.view.backgroundColor = .white
    }
    
    
    func callToViewModelForUIUpdate() {
        
        self.viewModel.bindPokemonNameToController = {
            DispatchQueue.main.async {
                self.mainView.pokemonName.text = self.viewModel.pokemonName
            }
        }
        
        self.viewModel.bindPokemonImagesToController = {
            debugPrint(self.viewModel.pokemonImages)
        }
        
        self.viewModel.bindPokemonStatToController = {
            debugPrint(self.viewModel.pokemonStat)
        }
        
        self.viewModel.bindPokemonTypeToController = {
            debugPrint(self.viewModel.pokemonType)
        }
        
    }
    
}


