//
//  Person.swift
//  Project10
//
//  Created by Marc on 08.02.21.
//

import UIKit

class Person: NSObject, Codable {

    var name: String
    var image: String
    
    init(name: String, image: String){
        self.name = name
        self.image = image
    }
}
