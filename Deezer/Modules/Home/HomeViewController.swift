//
//  HomeViewController.swift
//  Deezer
//
//  Created by Andrii Momot on 20.04.2022.
//

import UIKit

final class HomeViewController: BaseViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    let cellIdentifier = "ArtistCell"
    var viewModel: HomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureSearchController()
        binding()
    }
    
    private func configureTableView() {
        let reuseId = String(describing: ArtistCell.self)
        let cellNib = UINib(nibName: reuseId, bundle: Bundle(for: ArtistCell.self))
        tableView.register(cellNib, forCellReuseIdentifier: reuseId)
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Deezer"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func search(for string: String?) {
        // Handle correnct search request
        guard let string = string?.trimmingCharacters(in: .whitespaces), !string.isEmpty else {
            viewModel?.artists.value = nil
            tableView.reloadData()
            return
        }
        let searchString = string.replacingOccurrences(of: " ", with: "%")
        activity.startAnimating()
        viewModel?.search(for: searchString)
    }
    
    private func binding() {
        viewModel?.artists.bind({[weak self] artists in
            DispatchQueue.main.async {[weak self] in
                self?.activity.stopAnimating()
                self?.tableView.reloadData()
            }
        })
        
        viewModel?.error.bind({[weak self] error in
            DispatchQueue.main.async {[weak self] in
                self?.activity.stopAnimating()
                self?.showAlert(withTitle: "Error", message: error?.localizedDescription)
            }
        })
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.artists.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = String(describing: ArtistCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? ArtistCell else {
          return UITableViewCell()
        }
        cell.configure(with: viewModel?.artists.value?[indexPath.row])
        return cell
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        search(for: text)
    }
}

