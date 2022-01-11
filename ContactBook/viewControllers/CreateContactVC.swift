//
//  CreateContactVC.swift
//  ContactBook
//
//  Created by Alex on 05.01.2022.
//

import UIKit

class CreateContactVC: UIViewController {

    private var contact = Contact()
    var completion: ((Contact) -> Void)?
    
    @IBOutlet private weak var navItem: UINavigationItem!
    @IBOutlet private weak var imageContact: AvatarImageView!
    private var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modificationNavItem()
        imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    @objc private func createAction() {
        navigationBackListContactAndSendContact()
    }
    
    @IBAction func editImageAction(_ sender: UIButton) {
        imagePicker.present(from: sender)
    }
    
    
    @IBAction func firstNameInputAction(_ sender: UITextField) {
        contact.firstName = sender.text
    }
    
    @IBAction func lastNameInputAction(_ sender: UITextField) {
        contact.lastName = sender.text
    }
    
    
    @IBAction func numberInputAction(_ sender: UITextField) {
        contact.number = sender.text
    }
    
    
    private func modificationNavItem() {
        let create = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(createAction))
        navItem.rightBarButtonItem = create
    }
    
    private func navigationBackListContactAndSendContact() {
        completion?(contact)
        navigationController?.popViewController(animated: true)
    }
}

extension CreateContactVC: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageContact.image = image
        contact.image = image?.pngData()
    }
}
