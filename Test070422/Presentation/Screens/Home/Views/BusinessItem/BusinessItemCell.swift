//
//  BusinessItemCell.swift
//  Test070422
//
//  Created by Admin on 06/07/2022.
//

import UIKit

class BusinessItemCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var businessItem: BusinessItemVM? {
        didSet { bind(businessItem: businessItem) }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        addressLabel.text = nil
    }
    
    private func bind(businessItem: BusinessItemVM?){
        nameLabel.text = businessItem?.name
        addressLabel.text = businessItem?.address
    }
}
