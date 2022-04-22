//
//  HomeViewController.swift
//  Deezer
//
//  Created by Andrii Momot on 20.04.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        binding()
        search(for: "artbat")
    }
    
    private func search(for string: String?) {
        guard let string = string else { return }
        viewModel?.search(for: string)
    }
    
    private func binding() {
        viewModel?.artists.bind({ artists in
            print(artists)
        })
        
        viewModel?.error.bind({ error in
            print(error?.localizedDescription)
        })
    }
}
