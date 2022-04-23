//
//  ArtistViewController.swift
//  Deezer
//
//  Created by Andrii Momot on 22.04.2022.
//

import UIKit

final class ArtistViewController: BaseViewController {

    var viewModel: ArtistViewModel?
    var onShowAlbum: ((Album) -> Void)?

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        title = viewModel?.artist?.name
        configureCollectionView()
        binding()
    }
    
    private func configureCollectionView() {
        let reuseId = String(describing: AlbumCell.self)
        let cellNib = UINib(nibName: reuseId, bundle: Bundle(for: AlbumCell.self))
        collectionView.register(cellNib, forCellWithReuseIdentifier: reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func binding() {
        viewModel?.albums.bind {[weak self] albums  in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModel?.selectedAlbum.bind {[weak self] album  in
            DispatchQueue.main.async {
                guard let album = album else { return }
                self?.onShowAlbum?(album)
            }
        }
        
        viewModel?.error.bind {[weak self] error in
            DispatchQueue.main.async {
                self?.activity.stopAnimating()
                self?.showAlert(withTitle: "Error", message: error?.localizedDescription)
            }
        }
    }
}

extension ArtistViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let count = viewModel?.albums.value?.count, count > indexPath.row else { return }
        guard let albumID = viewModel?.albums.value?[indexPath.row].id else { return }
        
        viewModel?.getAlbumInfo(for: albumID)
    }
    
}

extension ArtistViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.1, height: 250)
    }
}

extension ArtistViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.albums.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseId = String(describing: AlbumCell.self)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? AlbumCell else { return UICollectionViewCell() }
        
        var album = viewModel?.albums.value?[indexPath.row]
        if album?.artist == nil {
            album?.artist = viewModel?.artist
        }
        cell.configure(with: album)
        return cell
    }
}
