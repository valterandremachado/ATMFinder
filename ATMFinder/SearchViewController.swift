//
//  SearchViewController.swift
//  ATMFinder
//
//  Created by Valter Machado on 4/1/24.
//

import UIKit
import SwiftUI
import LBTATools



class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    // TODO: Create a tableview with a header and add a search bar on the header

    // MARK: - Properties
    
    lazy var searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search ATMs"
        searchBar.showsBookmarkButton = true
        searchBar.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .bookmark, state: .normal)
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.alwaysBounceVertical = true
        return table
    }()
    
    var offSet: Double = -1
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addModalIndicator()
    }
    
    // MARK: - Methods
    
    // SetupViews
    private func setupView() {
        [searchBarView, tableView].forEach{view.addSubview($0)}
        searchBarView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 10, left: 15, bottom: 0, right: 15)
        )
        
        tableView.anchor(
            top: searchBarView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 15, bottom: 0, right: 15)
        )
    }
    
}

// MARK: - TableView Delegate & Data Source
extension SearchViewController: UITableViewDelegate & UITableViewDataSource {
    
    // Fix tableView grouped style header gap
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .zero
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
//        cell.backgroundColor = .red
        return cell
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
    }

}


// MARK: - Helpers
extension SearchViewController {
    
    private func addModalIndicator() {
        let indicator = UIView()
        indicator.backgroundColor = .tertiaryLabel
        let indicatorSize = CGSize(width: 35, height: 5)
        let indicatorX = (view.frame.width - indicatorSize.width) / CGFloat(2)
        indicator.frame = CGRect(origin: CGPoint(x: indicatorX, y: 8), size: indicatorSize)
        indicator.layer.cornerRadius = indicatorSize.height / CGFloat(2.0)
        view.addSubview(indicator)
    }
}
