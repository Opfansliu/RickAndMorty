//
//  RMLocationTableViewCell.swift
//  RAndM
//
//  Created by mac on 2024/8/1.
//

import Foundation
import UIKit

final class RMLocationTableViewCell: UITableViewCell {
    static let cellIdentifier = "RMLocationTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let dimentionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubViews(nameLabel, typeLabel, dimentionLabel)
        addConstrains()
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        typeLabel.text = nil
        dimentionLabel.text = nil
    }
    
    private func addConstrains() {
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo:contentView.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            /*nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),*/
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            typeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            typeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
//            typeLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            dimentionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            dimentionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            dimentionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10 ),
            dimentionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10 ),
            
        ])
        
    }
    
    public func configure(with viewModel: RMLocationTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        typeLabel.text = viewModel.type
        dimentionLabel.text = viewModel.dimension
        
    }
}
