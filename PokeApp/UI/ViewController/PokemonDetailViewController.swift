//
//  PokemonDetailViewController.swift
//  PokeApp
//
//  Created by Gaia Magnani on 08/02/2021.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: UiPokemonModel?
    
    let pokemonName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = UIColor.white
        name.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
        return name
    }()

    let dataContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    let profileImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "close"), for: .normal)
        button.tintColor = .white
        return button
    }()

    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        return stack
    }()
    
    let statLabel: UILabel = {
        let name = UILabel()
        name.text = "Stats"
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = UIColor.black
        name.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return name
    }()
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(PokemonStatTableViewCell.self, forCellReuseIdentifier: PokemonStatTableViewCell.identifier)
        self.loadData()
    }
    
    private func loadData() {
        guard let pokemon = self.pokemon else {
            return
        }
        self.view.backgroundColor = pokemon.mainColor
        pokemonName.text = pokemon.name
        
        if let imageUrl = pokemon.imageUrl {
            let url = URL(string: imageUrl)!
            UIImage.loadFrom(url: url) { [weak self] image in
                self?.profileImageView.image = image
            }
        }
        
        for type in pokemon.type {
            let typeView = TypeView()
            typeView.translatesAutoresizingMaskIntoConstraints = false
            typeView.setup(type.color, label: type.type)
            self.stackView.addArrangedSubview(typeView)
        }
        
        self.render()
    }
    
    
    private func render() {
        dataContainer.backgroundColor = .white
        self.view.addSubview(dataContainer)
        dataContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        dataContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        dataContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        dataContainer.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.60).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.view.addSubview(profileImageView)
        profileImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.view.addSubview(pokemonName)
        pokemonName.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 5).isActive = true
        pokemonName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.view.addSubview(closeButton)
        closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.addTarget(self, action: #selector(backAction(_:)), for: .touchDown)
        
        self.view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.pokemonName.bottomAnchor, constant: 5).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.dataContainer.addSubview(self.statLabel)
        self.statLabel.topAnchor.constraint(equalTo: self.dataContainer.topAnchor, constant: 20).isActive = true
        self.statLabel.leadingAnchor.constraint(equalTo: self.dataContainer.leadingAnchor, constant: 20).isActive = true
        
        self.dataContainer.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.topAnchor.constraint(equalTo: self.statLabel.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.dataContainer.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.dataContainer.trailingAnchor, constant: -20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.dataContainer.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PokemonDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let stats = self.pokemon?.stats else {
            return 0
        }
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let stats = self.pokemon?.stats, let cell = tableView.dequeueReusableCell(withIdentifier: PokemonStatTableViewCell.identifier, for: indexPath) as? PokemonStatTableViewCell else {
            return UITableViewCell()
        }
        let stat = stats[indexPath.row]
        cell.setupWith(stat.name, statValue: stat.value, color: pokemon?.mainColor ?? .red)
        return cell
    }
}
