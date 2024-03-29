//
//  Cell.swift
//  TeamProject
//
//  Created by 김준경 on 2021/01/25.
//

import UIKit

class Cell: UICollectionViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var eventNumLabel: UILabel!
    
    var categories : [Category] = api.callCategory()
    var events: [Event] = api.callEvent()
    var category : Category = Category()
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
}
