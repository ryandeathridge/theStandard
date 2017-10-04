//
//  ItemCell.swift
//  theStandard
//
//  Created by RYAN DEATHRIDGE on 4/10/17.
//  Copyright © 2017 RYAN DEATHRIDGE. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var spread: UILabel!
    @IBOutlet weak var age: UILabel!

    func configureCell(item: Entry) {
    
        let todaysDate = Date()
    
    date.text = "\(item.created)"
    spread.text = "Spread: \(item.spread)mm"
    age.text = "\(todaysDate)-\(item.created)"
        
    }

}
