//
//  DataManager.swift
//  TestWork
//
//  Created by BernsteinArts on 8/16/18.
//  Copyright © 2018 Almas Kairatuly. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol DataManagerDelegate {
    func didGet(artists: [Artist]?, errorMessage: String?)
}

// Data Manager -   simple helper class to handle api request, validate data and return array of Artist objects or an error message,
//                  information is passed by a delegate

class DataManager {
    var delegaet: DataManagerDelegate
    
    init(_ delegate: DataManagerDelegate) {
        self.delegaet = delegate
    }
    
    func getArtists() {
        let url = Konst.API
        Alamofire
            .request(url)
            .validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let array = JSON(value).array else {
                        self.delegaet.didGet(artists: nil, errorMessage: Konst.errorAPI)
                        return
                    }
                    let artists = array.compactMap{Artist($0)}
                    if artists.isEmpty {
                        self.delegaet.didGet(artists: nil, errorMessage: Konst.errorAPI)
                    } else {
                        self.delegaet.didGet(artists: artists, errorMessage: nil)
                    }
                case .failure(let error):
                    self.delegaet.didGet(artists: nil, errorMessage: error.localizedDescription)
                }
        }
    }
}

