//
//  HomeViewController.swift
//  Deezer
//
//  Created by Andrii Momot on 20.04.2022.
//

import UIKit

final class HomeViewController: BaseViewController {
        
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchFooter: SearchFooter!
    @IBOutlet private weak var searchFooterBottomConstraint: NSLayoutConstraint!
        
    private let searchController = UISearchController(searchResultsController: nil)
    var viewModel: HomeViewModelProtocol?
    var onShowArtist: (([Album]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureSearchController()
        binding()
        addNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureTableView() {
        let reuseId = String(describing: ArtistCell.self)
        let cellNib = UINib(nibName: reuseId, bundle: Bundle(for: ArtistCell.self))
        tableView.register(cellNib, forCellReuseIdentifier: reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Deezer"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func addNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil,
                                       queue: .main) {[weak self] notification in
                                        self?.handleKeyboard(notification: notification)
        }
        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                       object: nil,
                                       queue: .main) {[weak self] notification in
                                        self?.handleKeyboard(notification: notification)
        }
    }
    
    private func search(for string: String?) {
        // Handle correnct search request
        guard let string = string?.trimmingCharacters(in: .whitespaces), !string.isEmpty else {
            viewModel?.artists.value = nil
            tableView.reloadData()
            return
        }
        let searchString = string.replacingOccurrences(of: " ", with: "%")
        guard searchString != viewModel?.previousSearch else { return }

        activity.startAnimating()
        viewModel?.search(for: searchString)
    }
    
    private func binding() {
        viewModel?.artists.bind {[weak self] artists in
            DispatchQueue.main.async {
                if let count = artists?.count {
                    self?.searchFooter.setFooter(with: count)
                }
                self?.activity.stopAnimating()
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.albums.bind {[weak self] albums  in
            DispatchQueue.main.async {
                guard let albums = albums else { return }
                self?.onShowArtist?(albums)
            }
        }
        
        viewModel?.error.bind {[weak self] error in
            DispatchQueue.main.async {
                self?.activity.stopAnimating()
                self?.showAlert(withTitle: "Error", message: error?.localizedDescription)
            }
        }
    }
    
    private func handleKeyboard(notification: Notification) {
      guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
        searchFooterBottomConstraint.constant = 0
        view.layoutIfNeeded()
        return
      }
      
      guard let info = notification.userInfo,
        let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return  }
      
      let keyboardHeight = keyboardFrame.cgRectValue.size.height
      UIView.animate(withDuration: 0.1, animations: {[weak self] () -> Void in
        self?.searchFooterBottomConstraint.constant = keyboardHeight
        self?.view.layoutIfNeeded()
      })
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let count = viewModel?.artists.value?.count, count > indexPath.row else { return }
        guard let artistID = viewModel?.artists.value?[indexPath.row].id else { return }
        
        let artist = viewModel?.artists.value?[indexPath.row]
        viewModel?.selectedArtist = artist
        viewModel?.getAlbums(for: artistID)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ArtistHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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

