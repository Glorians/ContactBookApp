//
//  StoredHelper.swift
//  ContactBook
//
//  Created by Alex on 10.01.2022.
//

import Foundation
import UIKit

class StoredHelper {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private var firstLaunchApp: Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: StoredKeys.launchedBefore.rawValue)
        if launchedBefore {
            print("launch don't first")
            return false
            
        } else {
            UserDefaults.standard.set(true, forKey: StoredKeys.launchedBefore.rawValue)
            print("launch first")
            return true
            
        }
    }
    
    init() {
        guard firstLaunchApp else {return}
        generateDefaultContact()
    }
    
    func saveContacts(_ contacts: [Contact]) {
        let string = convertContactsToJson(contacts)
        UserDefaults.standard.set(string, forKey: StoredKeys.contacts.rawValue)
    }
    
    func getContacts() -> [Contact]? {
        let stringResult = UserDefaults.standard.string(forKey: StoredKeys.contacts.rawValue)
        guard let string = stringResult else {return nil}
        return convertStringToContacts(string)
    }
    
    private func convertContactsToJson(_ contacts: [Contact]) -> String? {
        do {
            let data = try encoder.encode(contacts)
            return String(data: data, encoding: .utf8)
        } catch {
            print("Failed to encode Json contacts")
            return nil
        }
    }
    
    private func convertStringToContacts(_ string: String) -> [Contact]? {
        guard let data = string.data(using: .utf8) else {return nil}
        do {
            return try decoder.decode([Contact].self, from: data)
        } catch {
            print("Failed to decode Json contacts")
            return nil
        }
    }
    
    private func generateDefaultContact() {
        let contacts = [
            Contact(firstName: "Alex", lastName: "Beliaev", number: "+380683349830", image: nil),
            Contact(firstName: "Bob", lastName: nil, number: "+380632268502", image: nil),
            Contact(firstName: nil, lastName: nil, number: "+380975142090", image: nil)
        ]
        saveContacts(contacts)
    }
    
    enum StoredKeys: String {
        case contacts
        case launchedBefore
    }
}

