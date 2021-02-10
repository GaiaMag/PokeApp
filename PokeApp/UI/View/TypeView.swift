//
//  TypeView.swift
//  PokeApp
//
//  Created by Gaia Magnani on 09/02/2021.
//

import UIKit

class TypeView: UIView {
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    public init() {
        super.init(frame : CGRect.zero)
        self.render()
    }
    
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func render() {
        self.layer.cornerRadius = 15
        self.addSubview(typeLabel)
        typeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        typeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        typeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setup(_ color: UIColor, label: String) {
        self.typeLabel.text = label
        self.backgroundColor = color
    }

}
