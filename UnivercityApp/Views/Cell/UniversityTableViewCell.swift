//
//  UniversityTableViewCell.swift
//  UnivercityApp
//
//  Created by Назар Гузар on 16.02.2022.
//

import UIKit

class UniversityTableViewCell: UITableViewCell {
    
    // MARK: - Subviews

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = UIColor.black
            nameLabel.font = UIFont.systemFont(ofSize: 15)
        }
    }
    
    // MARK: - Public
    
    public func setCountryName(_ name: String) {
        nameLabel.text = name
    }
}
