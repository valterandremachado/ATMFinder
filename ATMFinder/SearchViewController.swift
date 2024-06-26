//
//  SearchViewController.swift
//  ATMFinder
//
//  Created by Valter Machado on 4/1/24.
//

import UIKit
import SwiftUI
import LBTATools

protocol SearchControllerEventDelegate: AnyObject {
    func searchBarDidEditing(_ isEditing: Bool)
    func searchBarCancelButtonClicked(_ isClicked: Bool)
}


// TODO: Create a tableview with a header and add a search bar on the header
class SearchViewController: UIViewController {

    // MARK: - Properties
    weak var searchEventDelegate: SearchControllerEventDelegate?
    
    lazy var menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(
                systemName: "line.3.horizontal"
            )?.imageResize(
                sizeChange: .init(width: 32, height: 28)
            ).withTintColor(
                .systemBlue,
                renderingMode: .alwaysTemplate
            ), for: .normal
        )
//        button.backgroundColor = .yellow
        button.withSize(.init(width: 40, height: 40))
        return button
    }()
    
    lazy var searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search ATMs"
        searchBar.delegate = self
        searchBar.showsBookmarkButton = true
        searchBar.setImage(
            UIImage(
                systemName: "line.3.horizontal.decrease.circle.fill"
            )?.withRenderingMode(.alwaysOriginal).imageResized(
                to: .init(width: 25, height: 25)
            ),
            for: .bookmark, state: .normal
        )
        return searchBar
    }()
    
    lazy var searchViewHstack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [searchBarView, menuButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
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
        [searchViewHstack, tableView].forEach{view.addSubview($0)}
        searchViewHstack.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 25, left: 15, bottom: 0, right: 15)
        )
        
        tableView.anchor(
            top: searchViewHstack.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 15, left: 15, bottom: 0, right: 15)
        )
    }
    
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(
        _ searchBar: UISearchBar
    ) -> Bool {
        searchBar.showsCancelButton = true
        searchEventDelegate?.searchBarDidEditing(searchBar.searchTextField.isEditing)
        return true
    }
    
    func searchBarCancelButtonClicked(
        _ searchBar: UISearchBar
    ) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchEventDelegate?.searchBarCancelButtonClicked(true)
    }
}
// MARK: - TableView Delegate & Data Source
extension SearchViewController: UITableViewDelegate & UITableViewDataSource {
    
    // Fix tableView grouped style header gap
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return UIView()
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return .zero
    }
    
    // numberOfRowsInSection
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 20
    }
    
    // cellForRowAt
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = UITableViewCell()
//        cell.backgroundColor = .red
        return cell
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
