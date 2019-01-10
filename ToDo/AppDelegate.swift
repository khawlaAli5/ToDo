//
//  AppDelegate.swift
//  ToDo
//
//  Created by Khawla Alsharqi on 1/2/19.
//  Copyright © 2019 Khawla Alsharqi. All rights reserved.
//

import UIKit
import RealmSwift
//import SwipeCellKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      //  print(Realm.Configuration.defaultConfiguration.fileURL)
        
      
        //create our realm
        do{
            _ = try Realm()
        }
        catch
        {
            print("Error createing Real \(error)")
        }

        
        return true
    }

   
}

