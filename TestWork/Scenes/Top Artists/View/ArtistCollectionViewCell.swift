//
//  ArtistCollectionViewCell.swift
//  TestWork
//
//  Created by BernsteinArts on 8/17/18.
//  Copyright © 2018 Almas Kairatuly. All rights reserved.
//

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {
    
    private let itemSpacing : CGFloat = 4
    private let labelHeight : CGFloat = 28
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: Konst.placeholder)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Konst.appFontSize)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = Konst.cornerRadius
        contentView.layer.masksToBounds = true
        
        addSubview(self.imageView)
        addSubview(self.nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            self.imageView.widthAnchor.constraint(equalTo: widthAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: self.contentView.frame.height - self.labelHeight),
            self.imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.nameLabel.widthAnchor.constraint(equalTo: widthAnchor),
            self.nameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: self.itemSpacing),
            self.nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(_ model: Artist) {
        let placeholder = UIImage(named: Konst.placeholder)
        self.imageView.kf.setImage(with: model.avatarURL, placeholder: placeholder)
        var name = " \(model.firstName)"
        if let lastName = model.lastName {
           name = " \(lastName), \(model.firstName)"
        }
        self.nameLabel.text = name
    }
    
    func cancelDownloadTask() {
        self.imageView.kf.cancelDownloadTask()
    }
}
