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
    
        let todaysDate = NSDate()
        let createdDate = item.created
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = formatter.string(from: todaysDate as Date)
        let ageFormatter = DateComponentsFormatter()
        ageFormatter.unitsStyle = .short
        ageFormatter.allowedUnits = [.day]
        ageFormatter.maximumUnitCount = 2
        let spreadInt:Int = Int(item.spread)
        let ageString = ageFormatter.string(from: createdDate! as Date, to: todaysDate as Date)
        
    
    date.text = formattedDate
    age.text = ageString!+" ago"
    thumb.image = item.toImage?.image as? UIImage
    spread.text = "Spread: \(spreadInt)mm"
    }

    
    
}
