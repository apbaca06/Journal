//
//  ArticleHeaderView.swift
//  Journal
//
//  Created by cindy on 2017/12/8.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class ArticleHeaderView: UIView {

    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var headerTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        headerTitle.font = .systemFont(ofSize: 20, weight: .semibold)
     
        headerTitle.textAlignment = NSTextAlignment(rawValue: Int(-0.5))!
        
        plusButton.imageView?.image = #imageLiteral(resourceName: "icon_plus")
        
        plusButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        
        plusButton.tintColor = UIColor(red: 237/255, green: 96/255, blue: 81/255, alpha: 1)
    }
    
    

}
