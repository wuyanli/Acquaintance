//
//  Person.swift
//  TestTable
//
//  Created by 吴艳丽 on 2016/11/23.
//  Copyright © 2016年 吴艳丽. All rights reserved.
//

import Foundation
import UIKit

class Person: NSObject {
    
    var name: String
    var photo: UIImage?
    var notes: String?
    
    //initialization
    init?(name: String, photo: UIImage?, notes: String?){//问号代表可选
        if name.isEmpty {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.notes = notes
        
        super.init()
    }
    convenience init?(_ name: String){//问号代表可失败
        self.init(name: name, photo:nil, notes:nil)
    }
}
