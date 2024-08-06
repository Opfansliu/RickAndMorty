//
//  RMSearchInputViewViewModel.swift
//  RAndM
//
//  Created by mac on 2024/8/2.
//

import UIKit

protocol RMSearchInputViewDelegate: AnyObject {
    func rmSearchInputView(_ inputView: RMSearchInputView,
                           didSelectOption option: RMSearchInputViewModel.DynamicOptions)
}

final class RMSearchInputView: UIView {
    
    weak var delegate: RMSearchInputViewDelegate?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var viewModel: RMSearchInputViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else {  return  }
            let options = viewModel.options
            createOptionSelectionViews(options: options)
            
        }
    }
    
    public func presentKeyborard() {
        searchBar.becomeFirstResponder()
    }
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .systemPink
        addSubViews(searchBar)
        addConstraints()
        

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
            
        ])
        
    }
    
    public func configure(with viewModel: RMSearchInputViewModel) {
        self.searchBar.placeholder = viewModel.searchPlaceholderText
        self.viewModel = viewModel
    }
    
    private func createOptionStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 6
        addSubViews(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        return stackView
    }
    
    
    public func createOptionSelectionViews(options: [RMSearchInputViewModel.DynamicOptions]) {
        
        let stackView = createOptionStackView()
        for x in 0..<options.count {
            let option = options[x]
            print(option.rawValue)
            let button = createBtn(with: option, tag: x)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func createBtn(with option: RMSearchInputViewModel.DynamicOptions, tag: Int) -> UIButton {
        let button = UIButton()
        button.setAttributedTitle(
            NSAttributedString(
                string: option.rawValue,
                attributes:[
                    .font:UIFont.systemFont(ofSize: 18, weight: .medium),
                    .foregroundColor: UIColor.label
                    
                ]
            ),
            for: .normal)
        button.backgroundColor = .secondarySystemFill
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.tag = tag
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        return button
    }
    
    @objc
    private func didTapButton(_ sender: UIButton) {
        guard let options = viewModel?.options else { return }
        let tag = sender.tag
        let selected = options[tag]
        
        print("Did tap \(selected.rawValue)")
        delegate?.rmSearchInputView(self, didSelectOption: options[tag])
        
    }
    
    
    
}
