//
//  ArticleListTableViewCell.swift
//  Journal
//
//  Created by cindy on 2017/12/8.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class ArticleListTableViewCell: UITableViewCell {


    @IBOutlet weak var articleTitle: UILabel!
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        articleImageView.backgroundColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
