//
//  RMSearchView.swift
//  RAndM
//
//  Created by mac on 2024/8/2.
//

import UIKit

protocol RMSearchViewDelete: AnyObject {
    func rmRMSearchView(_ searchView: RMSearchView, didSelectOption model: RMSearchInputViewModel.DynamicOptions)
}

final class RMSearchView: UIView {
    
    weak var delegate: RMSearchViewDelete?

    private var viewModel: RMSearchViewViewModel
    
    private let noResultView =  RMNoSearchResultView()
    
    private let rmInputView = RMSearchInputView()
   
    //MARK: - init 
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(noResultView, rmInputView)
        addConstrains()
        rmInputView.delegate = self
        
        rmInputView.configure(with: RMSearchInputViewModel(type: viewModel.config.type))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstrains() {
        NSLayoutConstraint.activate([
            rmInputView.topAnchor.constraint(equalTo: topAnchor),
            rmInputView.leftAnchor.constraint(equalTo: leftAnchor),
            rmInputView.rightAnchor.constraint(equalTo: rightAnchor),
            rmInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 44 : 110),
            
            noResultView.widthAnchor.constraint(equalToConstant: 150),
            noResultView.heightAnchor.constraint(equalToConstant: 150),
            noResultView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func presentKeyboard() {
        rmInputView.presentKeyborard()
    }

}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension RMSearchView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension RMSearchView: RMSearchInputViewDelegate {
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewModel.DynamicOptions) {
        delegate?.rmRMSearchView(self, didSelectOption: option)
    }
}
