//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import UIKit
import Combine

class DetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var viewModel: DetailsViewModel?

    private var cancelable: Set<AnyCancellable> = Set()

    override func viewDidLoad() {
        tableView.register(UINib(nibName: DetailsTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: DetailsTableViewCell.identifier)
        bindToViewModel()
    }

    private func bindToViewModel() {
        guard let viewModel = viewModel else { return }

        viewModel.details.sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] _ in
            self?.tableView.reloadData()
        }).store(in: &cancelable)
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let details = viewModel?.details.value else { return 0 }
        return details.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let details = viewModel?.details.value,
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier,
                                                     for: indexPath) as? DetailsTableViewCell else {
                                                        return UITableViewCell()
        }
        cell.configure(details: details[indexPath.row])
        return cell
    }
}
