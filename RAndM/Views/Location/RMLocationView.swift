//
//  RMLocationView.swift
//  RAndM
//
//  Created by mac on 2024/7/31.
//

import Foundation
import UIKit

protocol RMLocationViewDelete: AnyObject {
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation)
}
 
final class RMLocationView: UIView {
    public weak var delegate: RMLocationViewDelete?
    
    private var viewModel: RMLocationViewModel? {
        didSet {
            tableView.reloadData()
            tableView.isHidden = false
            spinner.stopAnimating()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.isHidden = true
        table.alpha = 0
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.cellIdentifier)
        return table
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(tableView, spinner)
        spinner.startAnimating()
        addConstrains()
        configTableView()
        viewModel?.fetchLocations()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func addConstrains() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
        
    }
    
    public func config(with viewModel:RMLocationViewModel) {
        self.viewModel = viewModel
    }
}

extension RMLocationView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RMLocationTableViewCell.cellIdentifier,
            for: indexPath
        ) as? RMLocationTableViewCell else {
            fatalError()
        }
        
        guard let cellViewModels = viewModel?.cellViewModels else { fatalError() }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let locationModel = viewModel?.location(at: indexPath.row) else { return }
        delegate?.rmLocationView(self, didSelect:locationModel)
    }
}


