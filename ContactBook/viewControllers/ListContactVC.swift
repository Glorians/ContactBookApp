//
//  ViewController.swift
//  ContactBook
//
//  Created by Alex on 04.01.2022.
//

import UIKit

class ListContactVC: UIViewController {

    @IBOutlet private weak var navItem: UINavigationItem!
    @IBOutlet private weak var tableView: UITableView!
    
    private var contacts = [Contact]() {
        didSet {
            contactSortingAlphabet = Dictionary(grouping: contacts, by: {$0.title.first!})
            sortedKeys = Array(contactSortingAlphabet.keys).sorted(by: {$0 < $1})
            tableView.reloadData()
            storedHelper.saveContacts(contacts)
        }
    }
    
    private var sortedKeys = [Character]()
    private var contactSortingAlphabet: Dictionary<Character, [Contact]>!
    
    private let storedHelper = StoredHelper()
    
    deinit {
        print("deinit")
        storedHelper.saveContacts(contacts)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisapper")
        storedHelper.saveContacts(contacts)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonToNavItem()
        contacts = storedHelper.getContacts() ?? []
    }
    
    private func calculateContacts() {
        contactSortingAlphabet = Dictionary(grouping: contacts, by: {$0.title.first!})
    }
    
    private func addButtonToNavItem() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigationToCreateContact))
        navItem.rightBarButtonItem = add
    }
    
    @objc private func navigationToCreateContact() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let createContactVC = storyBoard.instantiateViewController(withIdentifier: "CreateContactVC") as? CreateContactVC else {return}
        
        createContactVC.completion = {[weak self] contact in
            self?.contacts.append(contact)
        }
        
        navigationController?.pushViewController(createContactVC, animated: true)
    }
}

extension ListContactVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(contacts)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactSortingAlphabet[sortedKeys[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactViewCell
        guard let contact = contactSortingAlphabet[sortedKeys[indexPath.section]]?[indexPath.row] else {return UITableViewCell()}
        cell.contact = contact
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactSortingAlphabet.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(sortedKeys[section])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    private func navigationToShowContact() {
        
    }
}

