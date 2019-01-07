//
//  Data.swift
//  ToDo
//
//  Created by Khawla Alsharqi on 1/7/19.
//  Copyright © 2019 Khawla Alsharqi. All rights reserved.
//

import Foundation
import RealmSwift
class Data: Object {
    //proprites for data class(Dynamic == declarion)
  @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
    
    
}
