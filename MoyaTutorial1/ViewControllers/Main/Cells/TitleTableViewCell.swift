//
//  TitleTableViewCell.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 12.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
    }
    
    func generateCell(title: String) {
        textLabel?.text = title
    }
}
