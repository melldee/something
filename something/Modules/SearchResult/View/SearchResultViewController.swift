//
//  SearchResultViewController.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController, SearchResultViewControllerProtocol {

    var viewModel: SearchResultViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        
        tableView.register(UINib(nibName: SearchResultViewController.oddCellIdentifier, bundle: .main), forCellReuseIdentifier: SearchResultViewController.oddCellIdentifier)
        tableView.register(UINib(nibName: SearchResultViewController.evenCellIdentifier, bundle: .main), forCellReuseIdentifier: SearchResultViewController.evenCellIdentifier)
        
        observeViewModelState()
    }
    
    func search(query: String) {
        viewModel?.search(query: query)
    }
    
    func resetSearch() {
        viewModel?.resetSearch()
    }
    
    private func observeViewModelState() {
        viewModel?.onChangeState = { [weak self] state in
            guard let sSelf = self else { return }
            
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    sSelf.loaderActivityIndicator.startAnimating()
                case .success:
                    sSelf.loaderActivityIndicator.stopAnimating()
                    sSelf.tableView.reloadData()
                case let .error(message):
                    sSelf.loaderActivityIndicator.stopAnimating()
                    sSelf.present(UIAlertController.okAlertController(message: message), animated: true)
                }
            }
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loaderActivityIndicator: UIActivityIndicatorView!
    
    private static let oddCellIdentifier = "OddSearchResultTableViewCell"
    private static let evenCellIdentifier = "EvenSearchResultTableViewCell"
}

//MARK: UITableViewDataSource
extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if indexPath.row.isMultiple(of: 2) {
            let evenCell: SearchResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchResultViewController.evenCellIdentifier, for: indexPath) as! SearchResultTableViewCell
            if let cellViewModel = viewModel?.results[indexPath.row] {
                evenCell.setUp(viewModel: cellViewModel)
                cellViewModel.onSetInitialFrame = {
                    return evenCell.contentView.convert(evenCell.avatarImageView.frame, to: UIApplication.shared.keyWindow)
                }
            }
            
            cell = evenCell
        } else {
            let oddCell: SearchResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchResultViewController.oddCellIdentifier, for: indexPath) as! SearchResultTableViewCell
            if let cellViewModel = viewModel?.results[indexPath.row] {
                oddCell.setUp(viewModel: cellViewModel)
                cellViewModel.onSetInitialFrame = {
                    return oddCell.contentView.convert(oddCell.avatarImageView.frame, to: UIApplication.shared.keyWindow)
                }
            }
            
            cell = oddCell
        }
        
        return cell
    }
}
