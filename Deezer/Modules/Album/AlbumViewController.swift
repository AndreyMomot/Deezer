//
//  AlbumViewController.swift
//  Deezer
//
//  Created by Andrii Momot on 22.04.2022.
//

import UIKit

final class AlbumViewController: BaseViewController {
    
    var viewModel: AlbumViewModel?

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureHeaderView()
    }
    
    private func configureTableView() {
        let reuseId = String(describing: TrackCell.self)
        let cellNib = UINib(nibName: reuseId, bundle: Bundle(for: TrackCell.self))
        tableView.register(cellNib, forCellReuseIdentifier: reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    // MARK: - UITableView header imageView set up using UIScrollViewDelegate
    private func configureHeaderView() {
        let height = tableView.frame.height * 0.5
        let headerView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: height))
        headerView.imageView.loadImageWithUrl(urlString: viewModel?.album.bigCover ?? "")
        self.tableView.tableHeaderView = headerView
    }
}

extension AlbumViewController: UITableViewDelegate, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = tableView.tableHeaderView as? StretchyTableHeaderView
        headerView?.scrollViewDidScroll(scrollView: scrollView)
    }
}

extension AlbumViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.album.tracks?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = String(describing: TrackCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? TrackCell else {
          return UITableViewCell()
        }
        
        var track = viewModel?.album.tracks?.data[indexPath.row]
        track?.index = indexPath.row + 1
        cell.configure(with: track)
        
        return cell
    }
}
