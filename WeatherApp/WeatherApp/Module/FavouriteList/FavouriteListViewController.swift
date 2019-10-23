//
//  FavouriteListViewController.swift
//  WeatherApp
//
//  Created by Edward Addley on 22/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import UIKit

class FavouriteListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyAddButton: UIButton!

    var viewModel: FavouriteListViewModel? {
        didSet {
            bindToViewModel()
        }
    }

    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped(_:)))
        emptyAddButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)

        bindToViewModel()
    }

    private func bindToViewModel() {
        if isViewLoaded {
            let show = viewModel?.showEmptyAddButton ?? true

            tableView.isHidden = show
            emptyAddButton.isHidden = !show
        }
    }
}

extension FavouriteListViewController {
    @objc
    func addButtonTapped(_ sender: UIBarButtonItem) {

    }
}
