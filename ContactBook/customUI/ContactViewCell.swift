//
//  ContactViewCell.swift
//  ContactBook
//
//  Created by Alex on 05.01.2022.
//

import UIKit

class ContactViewCell: UITableViewCell {
    
    var contact: Contact! {
        didSet {
            guard let contact = contact else {return}
            title.text = contact.title
            
            guard let dataImage = contact.image else {return}
            let image = UIImage(data: dataImage)
            icon.image = image
        }
    }
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var title: UILabel!
    
    private var saveColorBG: UIColor?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.layer.cornerRadius = icon.frame.height / 2
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        saveColorBG = containerView.backgroundColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        guard selected
        else {
            containerView.backgroundColor = saveColorBG
            return
            }
        containerView.backgroundColor = .lightGray
    }

}
