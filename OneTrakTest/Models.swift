//
//  Models.swift
//  OneTrakTest
//
//  Created by Pavel Scope on 05/02/2019.
//  Copyright © 2019 Paronkin Pavel. All rights reserved.
//

import Foundation


public struct Steps: Decodable {
    var aerobic: Int
    var date: Int
    var run: Int
    var walk: Int
    
    enum CodingKeys: Int, CodingKey {
        case aerobic
        case date
        case run
        case walk
    }
}
