//
//  BoardTableViewCell.swift
//  iChan
//
//  Created by Enoxus on 09/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit

class BoardTableViewCell: UITableViewCell {
    
    class Appearance {
        
        static let labelLeftOffset = 16
        static let labelRightOffset = 16
        static let labelTopOffset = 22
        static let labelBottomOffset = -22
        
        static let numberOfLinesInLabel = 0
    }
    
    let boardNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        boardNameLabel.textColor = .white
        boardNameLabel.numberOfLines = Appearance.numberOfLinesInLabel
        
        contentView.addSubview(boardNameLabel)
        
        boardNameLabel.snp.makeConstraints { make in
            
            make.left.equalTo(contentView).offset(Appearance.labelLeftOffset)
            make.right.equalTo(contentView).offset(Appearance.labelRightOffset)
            make.top.equalTo(contentView).offset(Appearance.labelTopOffset)
            make.bottom.equalTo(contentView).offset(Appearance.labelBottomOffset)
        }
        
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        
        boardNameLabel.text = text
    }
}
