//
//  Category.swift
//  ToDo
//
//  Created by Khawla Alsharqi on 1/7/19.
//  Copyright © 2019 Khawla Alsharqi. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    //we always use @objc dynamic when we declare virabels in RealmSwift
    @objc dynamic var name : String = ""
   @objc dynamic var color: String? = ""
    let items = List<Item>()
   
}
