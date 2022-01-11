//
//  Contact.swift
//  ContactBook
//
//  Created by Alex on 05.01.2022.
//

import Foundation

struct Contact: Codable{
    var firstName: String?
    var lastName: String?
    var number: String!
    var image: Data?
    
    init() {}
    
    init(firstName: String?, lastName: String?, number: String, image: Data?) {
        self.firstName = firstName
        self.lastName = lastName
        self.number = number
        self.image = image
    }
    
    var fullName: String? {
        guard firstName != nil && lastName != nil else {
            return firstName ?? lastName
        }
        return "\(firstName!) \(lastName!)"
    }
    
    var title: String {
        return fullName ?? number
    }
}
