//
//  RMCharacterListViewCell.swift
//  RAndM
//
//  Created by mac on 2024/7/16.
//

import Foundation
import UIKit

final class RMCharacterListViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterListViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .label
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.textColor = .secondaryLabel
        statusLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubViews(imageView, nameLabel, statusLabel)
        addConstraints()
        setUpLayer()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("unSupported")
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        contentView.layer.shadowOffset = CGSize(width: -4, height:4)
        contentView.layer.shadowOpacity = 0.4
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3)
            
        ])
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = ""
        statusLabel.text = ""
        
    }
    
    public func configure(with viewModel:RMCharacterListViewCellViewModel) {
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure(let failure):
                print(String(describing: failure.localizedDescription))
            }
        }
        
    }
    
}
