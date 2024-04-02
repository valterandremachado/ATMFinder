//
//  ViewController.swift
//  ATMFinder
//
//  Created by Valter Machado on 3/31/24.
//

import SwiftUI
import UIKit
import LBTATools


class MapViewController: UIViewController {

    // MARK: - Properties
    lazy var menuButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
//        button.setTitle("Button", for: .normal)
        button.withWidth(50)
        button.withHeight(50)
        button.backgroundColor = .red
        return button
    }()

    // MARK: - Inits
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .cyan
//        setupViews()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Methods
    func setupViews() {
        [menuButton].forEach { view.addSubview($0) }
        menuButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 15, left: 15, bottom: 0, right: 0)
        )

    }
    
    func showMyViewControllerInACustomizedSheet() {
        let viewControllerToPresent = SearchViewController()
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    
}

