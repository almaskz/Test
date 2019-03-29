//
//  ArtistsCollectionViewController.swift
//  TestWork
//
//  Created by BernsteinArts on 8/16/18.
//  Copyright © 2018 Almas Kairatuly. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import KRProgressHUD

class ArtistsCollectionViewController: UICollectionViewController {
    
    fileprivate let reuseIdentifier     = "TopArtistCell"
    fileprivate lazy var artists        = [Artist]()
    fileprivate lazy var dataManager    = DataManager(self)
    fileprivate lazy var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavBar()
        self.setupCollectionView()
        self.refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // NOTE: Kingfisher will purge the memory cache when received a memory warning, as well as clean the expired and size exceeded cache when needed. So there is not need to handle myself.
    }
    
    @objc private func refresh() {
        self.showLoading()
        self.dataManager.getArtists()
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ArtistsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

// MARK: UICollectionViewDataSource

extension ArtistsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.artists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let artistCell = cell as? ArtistCollectionViewCell {
            artistCell.configure(self.artists[indexPath.item])
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension ArtistsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ArtistCollectionViewCell else { return }
        // cancel a downloading or retriving task once the cell is offscreen, in case there are a lot of items in collection view
        cell.cancelDownloadTask()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openArtistDetails(self.artists[indexPath.item])
    }
}

// MARK: - Segue

extension ArtistsCollectionViewController {
    fileprivate func openArtistDetails(_ artist: Artist) {
        let detailArtistVC = ArtistInfoTableViewController(style: .grouped)
        detailArtistVC.artist = artist
        self.navigationController?.pushViewController(detailArtistVC, animated: true)
    }
}

// MARK: DataManagerDelegate

extension ArtistsCollectionViewController: DataManagerDelegate {
    func didGet(artists: [Artist]?, errorMessage: String?) {
        if let thisArtists = artists {
            self.artists = thisArtists
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                self.hideLoading()
            }
            
        } else if let message = errorMessage {
            self.showError(message)
        }
    }
}

// MARK: KRProgressHUD

extension ArtistsCollectionViewController {
    func showError(_ message: String) {
        KRProgressHUD.showMessage(message)
        self.hideLoading()
        
    }
    
    func showLoading() {
        if self.refreshControl.isRefreshing == false {
            KRProgressHUD.show()
        }
    }
    
    func hideLoading() {
        if self.refreshControl.isRefreshing == true {
            self.refreshControl.endRefreshing()
        } else {
            KRProgressHUD.dismiss()
        }
    }
}

// MARK: Helper

extension ArtistsCollectionViewController {
    fileprivate func setupCollectionView() {
        self.collectionView?.backgroundColor = .white
        self.collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView?.alwaysBounceVertical = true
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.collectionView?.addSubview(refreshControl)
        // Register cell classes
        self.collectionView?.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    fileprivate func setupNavBar() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.topItem?.title = "Top Artists"
        if #available(iOS 11, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
}
