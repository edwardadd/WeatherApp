//
//  FavouriteListViewController.swift
//  WeatherApp
//
//  Created by Edward Addley on 22/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import UIKit
import Combine

class FavouriteListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyAddButton: UIButton!

    var viewModel: FavouriteListViewModel?

    private var cancelable: Set<AnyCancellable> = Set()

    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped(_:)))
        emptyAddButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)

        bindToViewModel()
    }

    private func bindToViewModel() {
        guard let viewModel = viewModel else { return }

        viewModel.favourites.sink(receiveCompletion: { _ in
            // TODO Handle error, maybe it should be possible to have an error
            // and that it should be a separate observable?
        }, receiveValue: { [weak self] favourites in
            let showEmptyAddButton = favourites.isEmpty

            self?.tableView.isHidden = showEmptyAddButton
            self?.emptyAddButton.isHidden = !showEmptyAddButton
            self?.tableView.reloadData()
        }).store(in: &cancelable)
    }
}

extension FavouriteListViewController {
    @objc
    func addButtonTapped(_ sender: UIBarButtonItem) {
        viewModel?.favourites.value.append(Favourite(name: "London"))
    }
}

extension FavouriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let favourites = viewModel?.favourites.value else { return 0 }
        return favourites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favourites = viewModel?.favourites.value else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = favourites[indexPath.row].name
        return cell
    }
}
