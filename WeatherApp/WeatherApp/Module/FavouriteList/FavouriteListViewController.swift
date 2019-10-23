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
        tableView.register(UINib(nibName: FavouriteTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: FavouriteTableViewCell.identifier)

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
        viewModel?.shouldShowAddFavourite()
    }
}

extension FavouriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let favourites = viewModel?.favourites.value else { return 0 }
        return favourites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favourites = viewModel?.favourites.value,
            let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.identifier,
                                                     for: indexPath) as? FavouriteTableViewCell else {
                                                        return UITableViewCell()
        }
        cell.configure(locationName: favourites[indexPath.row].name)
        return cell
    }
}

extension FavouriteListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let favourites = viewModel?.favourites.value else { return }
        let favourite = favourites[indexPath.row]
        viewModel?.appCoordinator?.showDetails(favourite: favourite)
    }

    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.delete(favourite: indexPath.row)
        }
    }
}
