//
//  SearchViewController.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchViewControllerProtocol {

    var viewModel: SearchViewModelProtocol?
    
    var itunesSearchResultViewController: SearchResultViewController?
    var githubSearchResultViewController: SearchResultViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    private func setUpView() {
        edgesForExtendedLayout = [.top, .bottom]
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let githubSearchResultViewController = githubSearchResultViewController {
            addChild(githubSearchResultViewController)
            searchResultContainerView.addSameSizeConstraintSubview(githubSearchResultViewController.view)
            githubSearchResultViewController.didMove(toParent: self)
        }
        if let itunesSearchResultViewController = itunesSearchResultViewController {
            addChild(itunesSearchResultViewController)
            searchResultContainerView.addSameSizeConstraintSubview(itunesSearchResultViewController.view)
            itunesSearchResultViewController.didMove(toParent: self)
        }
        
        for searchServiceType in SearchServiceType.allCases {
            switch searchServiceType {
            case .itunes:
                serviceSegmentedControl.setTitle(searchServiceType.title, forSegmentAt: searchServiceType.rawValue)
            case .github:
                serviceSegmentedControl.setTitle(searchServiceType.title, forSegmentAt: searchServiceType.rawValue)
            }
        }
        
        searchBar.delegate = self
    }
    
    private func resetSearch() {
        itunesSearchResultViewController?.resetSearch()
        githubSearchResultViewController?.resetSearch()
    }
    
    private func search(query: String) {
        itunesSearchResultViewController?.search(query: query)
        githubSearchResultViewController?.search(query: query)
    }
    
    @IBAction private func serviceSegmentedControlDidChange(_ sender: UISegmentedControl) {
        guard let searchServiceType = SearchServiceType(rawValue: sender.selectedSegmentIndex) else { return }
        
        switch searchServiceType {
        case .itunes:
            if let itunesSearchResultView = itunesSearchResultViewController?.view {
                searchResultContainerView.bringSubviewToFront(itunesSearchResultView)
            }
        case .github:
            if let githubSearchResultView = githubSearchResultViewController?.view {
                searchResultContainerView.bringSubviewToFront(githubSearchResultView)
            }
        }
    }
    
    private lazy var throttleInvoker: ThrottleInvoker = {
        return ThrottleInvoker()
    }()
    
    @IBOutlet private weak var serviceSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchResultContainerView: UIView!
}

//MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            resetSearch()
        } else {
            throttleInvoker.throttle(duration: 0.7, block: { [weak self] in
                DispatchQueue.main.async {
                    guard let sSelf = self else { return }
                    
                    sSelf.search(query: searchText)
                }
            })
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        if text.isEmpty {
            resetSearch()
        } else {
            search(query: text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        resetSearch()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty == true {
            searchBar.setShowsCancelButton(false, animated: true)
        }
    }
}
