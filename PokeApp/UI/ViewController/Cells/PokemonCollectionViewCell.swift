//
//  PokemonCollectionViewCell.swift
//  PokeApp
//
//  Created by Gaia Magnani on 09/02/2021.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    static let identifier =  String(describing: PokemonCollectionViewCell.self)
    
    let pokemonName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = UIColor.white
        name.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return name
    }()
    
    let profileImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        view.layer.cornerRadius = 10
        return view
    }()
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.render()        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        containerView.addSubview(pokemonName)
        containerView.addSubview(profileImageView)
        self.contentView.addSubview(containerView)
        
        containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        
        pokemonName.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        pokemonName.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 10).isActive = true
        pokemonName.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10).isActive = true
        
        profileImageView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 5).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setPokemon(_ pokemon: UiPokemonModel) {
        self.pokemonName.text = pokemon.name
        if let imageUrl = pokemon.imageUrl {
            let url = URL(string: imageUrl)!
            UIImage.loadFrom(url: url) { [weak self] image in
                self?.profileImageView.image = image
            }
        }
        containerView.backgroundColor = pokemon.mainColor
    }
    
}
