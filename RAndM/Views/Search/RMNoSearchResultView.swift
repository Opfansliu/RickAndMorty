//
//  RMNoSearchResultView.swift
//  RAndM
//
//  Created by mac on 2024/8/2.
//

import UIKit

final class RMNoSearchResultView: UIView {
    
    private let viewModel = RMNoSearchResultViewViewModel()
    
    private var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .systemBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(iconImage, label)
        addConstrains()
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstrains() {
        NSLayoutConstraint.activate([
            iconImage.widthAnchor.constraint(equalToConstant: 90),
            iconImage.heightAnchor.constraint(equalToConstant: 90),
            iconImage.topAnchor.constraint(equalTo: topAnchor),
            iconImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.topAnchor.constraint(equalTo:iconImage.bottomAnchor, constant: 10)
        ])
        
    }
    
    private func configure() {
        self.iconImage.image = viewModel.image
        self.label.text = viewModel.title
    }


}
