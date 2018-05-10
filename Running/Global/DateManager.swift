//
//  DateFormate.swift
//  Running
//
//  Created by 123 on 2018/5/9.
//  Copyright © 2018年 123. All rights reserved.
//

import UIKit

class DateManager: NSObject {

   static func getDateYMD()->String{
        let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: Date.init())
    }
    
}
