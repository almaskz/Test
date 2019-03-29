//
//  ArtistTopTableViewCell.swift
//  TestWork
//
//  Created by BernsteinArts on 8/17/18.
//  Copyright © 2018 Almas Kairatuly. All rights reserved.
//

import UIKit
import Kingfisher

class ArtistTopTableViewCell: UITableViewCell {
 
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.imageView?.contentMode = .scaleAspectFit
        self.textLabel?.textColor = .darkText
        self.textLabel?.font = UIFont.systemFont(ofSize: Konst.appFontSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        let cvFrame = self.contentView.frame
        self.imageView?.frame = CGRect(x: 20, y: 1, width: cvFrame.height - 2, height: cvFrame.height - 2)
        self.imageView?.layer.cornerRadius = cvFrame.height/2.0
        self.imageView?.layer.masksToBounds = true
    }
    
    func configure(_ model: Artist) {
        let placeholder = UIImage(named: Konst.placeholder)
        self.imageView?.kf.setImage(with: model.avatarURL, placeholder: placeholder)
        var name = model.firstName
        if let lastName = model.lastName {
            name = "\(lastName), \(model.firstName)"
        }
        self.textLabel?.text = name
    }
}
