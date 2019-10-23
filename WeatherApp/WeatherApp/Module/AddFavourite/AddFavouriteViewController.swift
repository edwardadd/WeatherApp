//
//  AddFavouriteViewController.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import UIKit
import Combine

class AddFavouriteViewController: UIViewController {
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!

    var viewModel: FavouriteViewModel?

    private var cancelable: Set<AnyCancellable> = Set()

    override func viewDidLoad() {

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(doneButtonTapped(_:)))

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                            target: self,
                                                            action: #selector(cancelButtonTapped(_:)))

        navigationItem.rightBarButtonItem?.isEnabled = false

        bindToViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        locationTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        locationTextField.resignFirstResponder()
    }

    private func bindToViewModel() {
        guard let viewModel = viewModel else { return }

        // swiftlint:disable force_cast
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: locationTextField)
            .compactMap({ ($0.object as! UITextField).text })
            .compactMap { $0.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .filter { !$0.isEmpty }
            .sink { [weak self] text in
                self?.viewModel?.search(city: text)
            }
            .store(in: &cancelable)

        viewModel.weather.sink(receiveCompletion: { [weak self] _ in
            self?.clearLabels()
            self?.navigationItem.rightBarButtonItem?.isEnabled = false
        }, receiveValue: { [weak self] weather in
            if let weather = weather {
                self?.windLabel.text = weather.windSpeed
                self?.weatherLabel.text = weather.weatherDescription
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
            } else {
                self?.clearLabels()
                self?.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }).store(in: &cancelable)
    }

    private func clearLabels() {
        windLabel.text = "-"
        weatherLabel.text = "-"
    }
}

extension AddFavouriteViewController {
    @objc
    func doneButtonTapped(_ sender: UIBarButtonItem) {
        viewModel?.save()
        dismiss(animated: true, completion: { [weak self] in
            self?.viewModel?.appCoordinator?.refreshFavouritesList()
        })
    }

    @objc
    func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
