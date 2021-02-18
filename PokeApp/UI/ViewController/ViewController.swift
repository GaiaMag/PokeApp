//
//  ViewController.swift
//  PokeApp
//
//  Created by Gaia Magnani on 27/01/2021.
//

import UIKit


class ViewController: UIViewController {
    
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    var pokemonArray: [UiPokemonModel] = []
    
    private let viewModel = PokemonViewModel()
    
    let titleLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = UIColor.black
        name.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return name
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel.pokemonList.bind { [weak self] list in
            guard let self = self else { return }
            let pokemonCount = self.pokemonArray.count
            let (start, end) = (pokemonCount, list.count)
            let indexPaths = (start..<end).map { return IndexPath(row: $0, section: 0) }
            self.pokemonArray = list
            
            guard pokemonCount != 0 else {
                self.collectionView.reloadData()
                return
            }
            
            self.collectionView.performBatchUpdates({ () -> Void in
                self.collectionView.insertItems(at: indexPaths)
            }, completion: { (finished) -> Void in
            })
        }
        
        viewModel.navigateToDetail.bind { [weak self] model in
            guard let self = self else { return }
            if let model = model {
                let detail = PokemonDetailViewController()
                detail.pokemon = model
                detail.modalPresentationStyle = .fullScreen
                detail.modalTransitionStyle = .coverVertical
                self.present(detail, animated: true, completion: nil)
                self.viewModel.navigationDone()
            }
        }
        self.render()
    }
    
    private func render() {
        self.view.backgroundColor = .white
        titleLabel.text = "PokeApp"
        self.view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PokemonCollectionViewCell.self,
                                forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        
        if let collectionViewLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.minimumInteritemSpacing = 0
            collectionViewLayout.minimumLineSpacing = 0
            collectionViewLayout.scrollDirection = .vertical
        }
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier,
                                                            for: indexPath) as? PokemonCollectionViewCell else {
            return UICollectionViewCell()
        }
        let pokemon = pokemonArray[indexPath.row]
        cell.setPokemon(pokemon)
        return cell
    }
    
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2 ,
                      height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.onCellSelected(model: self.pokemonArray[indexPath.row])
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (collectionView.contentSize.height - collectionView.frame.size.height) {
            viewModel.loadPokemon()
        }
    }
}

