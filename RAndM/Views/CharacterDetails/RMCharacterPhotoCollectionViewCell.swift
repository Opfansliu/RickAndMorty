//
//  RMCharacterPhotoCollectionViewCell.swift
//  RAndM
//
//  Created by mac on 2024/7/22.
//

import UIKit

class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterPhotoCollectionViewCell"
    
    private var imageV : UIImageView  = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageV)
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstrains() {
        NSLayoutConstraint.activate([
            imageV.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageV.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageV.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageV.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageV.image = nil
    }
    
    public func config(with viewModel: RMCharacterPhotoCollectionViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageV.image = UIImage(data: data)
                }
            case .failure(let failure):
                print("\(failure.localizedDescription)")
            }
        }
    }
    
}
