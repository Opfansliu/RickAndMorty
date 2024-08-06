//
//  RMFootLoadingCollectionReusableView.swift
//  RAndM
//
//  Created by mac on 2024/7/17.
//

import UIKit

final class RMFootLoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "RMFootLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(spinner)
        addConstrains()
    }
    
    required init?(coder:NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstrains() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    public func startAnimating() {
        spinner.startAnimating()
        
    }
        
}
