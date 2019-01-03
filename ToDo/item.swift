//
//  item.swift
//  ToDo
//
//  Created by Khawla Alsharqi on 1/3/19.
//  Copyright © 2019 Khawla Alsharqi. All rights reserved.
//

import Foundation
//able to encode & Decode it self
class Item : Codable {
    var title : String = ""
    var done : Bool = false
}
