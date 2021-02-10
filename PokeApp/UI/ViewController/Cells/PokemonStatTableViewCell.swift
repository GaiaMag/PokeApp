//
//  PokemonStatTableViewCell.swift
//  PokeApp
//
//  Created by Gaia Magnani on 09/02/2021.
//

import UIKit

class PokemonStatTableViewCell: UITableViewCell {
    static let identifier = String(describing: PokemonStatTableViewCell.self)
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        stack.alignment = .trailing
        return stack
    }()
    
    let statName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = UIColor.gray
        name.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        name.numberOfLines = 2
        return name
    }()
    
    let statValue: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = UIColor.black
        name.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return name
    }()
    
    let progressView = UIProgressView(progressViewStyle: .bar)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.stackView)
        self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.3).isActive = true
        self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.stackView.addArrangedSubview(self.statName)
        self.stackView.addArrangedSubview(self.statValue)
    
        self.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        self.progressView.leadingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: 10).isActive = true
        self.progressView.centerYAnchor.constraint(equalTo: self.stackView.centerYAnchor).isActive = true
        self.progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        self.progressView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
        
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWith(_ statName: String, statValue: Int, color: UIColor) {
        self.statName.text = statName
        self.statValue.text = "\(statValue)"
        progressView.setProgress(Float(statValue)/100.0, animated: true)
        progressView.trackTintColor = UIColor.lightGray.withAlphaComponent(0.6)
        progressView.tintColor = color
    }

}
