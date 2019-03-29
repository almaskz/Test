//
//  ArtistAddInfoTableViewCell.swift
//  TestWork
//
//  Created by BernsteinArts on 8/17/18.
//  Copyright © 2018 Almas Kairatuly. All rights reserved.
//

import UIKit

class ArtistAddInfoTableViewCell: UITableViewCell {
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Konst.appFontSize)
        label.textColor = .darkGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Konst.appFontSize)
        label.textColor = .darkText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabelWidth  : CGFloat = 64
    private let itemSpacing     : CGFloat = 16
    
    // MARK: Initalizers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        // configure infoLabel
        contentView.addSubview(infoLabel)
        infoLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        infoLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: infoLabelWidth).isActive = true
        
        // configure detailLabel
        contentView.addSubview(detailLabel)
        detailLabel.leadingAnchor.constraint(equalTo: infoLabel.trailingAnchor, constant: itemSpacing).isActive = true
        detailLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: ArtistInfoModelViewCell) {
        self.infoLabel.text = model.info
        self.detailLabel.text = model.detail
    }
    
}
