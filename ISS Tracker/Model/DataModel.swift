//
//  DataModel.swift
//  ISS Tracker
//
//  Created by Moazzam Tahir on 16/05/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import Foundation

struct ApiModel: Codable {
    var message: String
    var iss_position: ISSPosition
        
    struct ISSPosition: Codable {
        var longitude: String
        var latitude: String
    }
}

