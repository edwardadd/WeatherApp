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
        // swiftlint:disable force_cast
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: locationTextField)
            .map({ ($0.object as! UITextField).text })
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] text in
                if let text = text {
                    self?.viewModel?.search(city: text)
                }
        }.store(in: &cancelable)
    }
}
