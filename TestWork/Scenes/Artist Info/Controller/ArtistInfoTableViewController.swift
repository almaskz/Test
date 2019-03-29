//
//  ListArtistsTableViewController.swift
//  TestWork
//
//  Created by BernsteinArts on 8/16/18.
//  Copyright © 2018 Almas Kairatuly. All rights reserved.
//

import UIKit
import Kingfisher

class ArtistInfoTableViewController: UITableViewController {
    
    var artist: Artist!
    
    fileprivate let topCellId       = "TopCell"
    fileprivate let addInfoCellId   = "ArtistInfoCell"
    
    fileprivate let estimatedRowHeight: CGFloat = 96
    
    fileprivate var addInfo = [ArtistInfoModelViewCell]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewSetup()
        self.populateTableContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: TableViewDataSource

extension ArtistInfoTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return addInfo.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.topCellId, for: indexPath) as! ArtistTopTableViewCell
            cell.configure(self.artist)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.addInfoCellId, for: indexPath) as! ArtistAddInfoTableViewCell
            cell.configure(self.addInfo[indexPath.row])
            return cell
        }
    }
}

// MARK: TableViewDelegate

extension ArtistInfoTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Helpers

extension ArtistInfoTableViewController {
    fileprivate func tableViewSetup() {
        self.tableView.estimatedRowHeight = self.estimatedRowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(ArtistTopTableViewCell.self, forCellReuseIdentifier: self.topCellId)
        self.tableView.register(ArtistAddInfoTableViewCell.self, forCellReuseIdentifier: self.addInfoCellId)
    }
    
    fileprivate func populateTableContent() {
        self.addInfo.append(ArtistInfoModelViewCell(info: Konst.genre, detail: self.artist.genre))
        self.addInfo.append(ArtistInfoModelViewCell(info: Konst.bio, detail: self.artist.bio))
        if let quote = self.artist.quote {
            self.addInfo.append(ArtistInfoModelViewCell(info: Konst.quote, detail: "\"\(quote)\""))
        }
    }
}

