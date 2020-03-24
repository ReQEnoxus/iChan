//
//  ThreadTableViewCell.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import ActiveLabel

class ThreadTableViewCell: UITableViewCell {
    
    class Appearance {
        
        static let stackViewLeftOffset = 16
        static let stackViewRightOffset = -16
        static let stackViewTopOffset = 8
        static let stackViewBottomOffset = -8
        
        static let dateLabelLeftOffset = 0
        static let dateLabelRightOffset = 0
        static let dateLabelTopOffset = 0
        static let dateLabelBottomOffset = 0
        
        static let numberLabelLeftOffset = 0
        static let numberLabelRightOffset = UIScreen.main.bounds.width - 30
        static let numberLabelTopOffset = 0
        static let numberLabelBottomOffset = 0
        
        static let numberAndDateViewLeftOffset = 0
        static let numberAndDateViewRightOffset = 0
        
        static let thumbnailImageHeight = 80
        static let thumbnailImageWidth = 80
        
        static let stackViewSpacing: CGFloat = 5
        
        static let infoFontSize: CGFloat = 13
        static let commentFontSize: CGFloat = 14
        
        static let dateLabelLineNumber = 1
        static let numberLabelLineNumber = 1
        static let commentLabelLineNumberExpanded = 8
        static let commentLabelLineNumberCollapsed = 1
        static let postCountLabelLineNumber = 1
        
        static let collapseAnimationTime = 0.5
        
    }
    
    let dateAndNameLabel = UILabel()
    let numberLabel = UILabel()
    let dateAndNumberView = UIView()
    
    lazy var thumbnailImageView: UIImageView = {
        
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let commentLabel = UILabel()
    let postCountLabel = UILabel()
    let mainStackView = UIStackView()
    
    var isCollapsed: Bool {
        return dto.isCollapsed
    }
    
    var dto: ThreadDto!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dateAndNameLabel.numberOfLines = Appearance.dateLabelLineNumber
        dateAndNameLabel.sizeToFit()
        dateAndNameLabel.textColor = .paleGrey60
        dateAndNameLabel.font = dateAndNameLabel.font.withSize(Appearance.infoFontSize)
        
        numberLabel.numberOfLines = Appearance.numberLabelLineNumber
        numberLabel.sizeToFit()
        numberLabel.textColor = .paleGrey60
        numberLabel.font = numberLabel.font.withSize(Appearance.infoFontSize)
        
        commentLabel.numberOfLines = Appearance.commentLabelLineNumberExpanded
        
//        commentLabel.sizeToFit()
        commentLabel.textColor = .white
        commentLabel.font = commentLabel.font?.withSize(Appearance.commentFontSize)
        
        postCountLabel.numberOfLines = Appearance.postCountLabelLineNumber
        postCountLabel.sizeToFit()
        postCountLabel.textColor = .paleGrey60
        postCountLabel.font = postCountLabel.font.withSize(Appearance.infoFontSize)
        
        dateAndNumberView.addSubview(dateAndNameLabel)
        dateAndNumberView.addSubview(numberLabel)
        
        mainStackView.alignment = .leading
        mainStackView.spacing = Appearance.stackViewSpacing
        mainStackView.axis = .vertical
        
        mainStackView.addArrangedSubview(dateAndNumberView)
        mainStackView.addArrangedSubview(thumbnailImageView)
        mainStackView.addArrangedSubview(commentLabel)
        mainStackView.addArrangedSubview(postCountLabel)
        
        contentView.addSubview(mainStackView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        dateAndNumberView.snp.makeConstraints { make in
            
            make.left.equalTo(mainStackView).offset(Appearance.numberAndDateViewLeftOffset)
            make.left.equalTo(mainStackView).offset(Appearance.numberAndDateViewRightOffset)
        }
        
        dateAndNameLabel.snp.makeConstraints { make in
            
            make.left.equalTo(dateAndNumberView).offset(Appearance.dateLabelLeftOffset)
            make.top.equalTo(dateAndNumberView).offset(Appearance.dateLabelTopOffset)
            make.bottom.equalTo(dateAndNumberView).offset(Appearance.dateLabelBottomOffset)
        }
        
        numberLabel.snp.makeConstraints { make in
        
            make.right.equalTo(dateAndNumberView).offset(Appearance.numberLabelRightOffset)
            make.top.equalTo(dateAndNumberView).offset(Appearance.numberLabelTopOffset)
            make.bottom.equalTo(dateAndNumberView).offset(Appearance.numberLabelBottomOffset)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            
            make.height.equalTo(Appearance.thumbnailImageHeight).priority(.high)
            make.width.equalTo(thumbnailImageView.snp.height)
        }
        
        mainStackView.snp.makeConstraints { make in
            
            make.left.equalTo(contentView).offset(Appearance.stackViewLeftOffset)
            make.right.equalTo(contentView).offset(Appearance.stackViewRightOffset)
            make.top.equalTo(contentView).offset(Appearance.stackViewTopOffset)
            make.bottom.equalTo(contentView).offset(Appearance.stackViewBottomOffset)
        }
        
        commentLabel.snp.makeConstraints { make in
            
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func configure(with dto: ThreadDto) {
        
        self.dto = dto
        
        dateAndNameLabel.text = "\(dto.posterName) \(dto.date)"
        numberLabel.text = "№\(dto.number)"
        
        if let url = dto.thumbnail {
            thumbnailImageView.sd_setImage(with: URL(string: url))
        }
        else {
            thumbnailImageView.isHidden = true
        }
        
        commentLabel.setHTMLFromString(htmlText: dto.text)
        postCountLabel.text = "\(dto.postsCount) постов, \(dto.filesCount) с картинками"
        
        if dto.isCollapsed {
            
            self.postCountLabel.isHidden = true
            self.thumbnailImageView.isHidden = true
            self.commentLabel.numberOfLines = Appearance.commentLabelLineNumberCollapsed
        }
        else {
            
            self.postCountLabel.isHidden = false
            self.thumbnailImageView.isHidden = false
            self.commentLabel.numberOfLines = Appearance.commentLabelLineNumberExpanded
        }
    }
    
    func collapse() {
        
//        UIView.animate(withDuration: Appearance.collapseAnimationTime, delay: .zero, options: .curveEaseOut, animations: { [weak self] in
//
//            guard let self = self else { return }
            
            self.postCountLabel.isHidden = true
            self.thumbnailImageView.isHidden = true
            self.commentLabel.numberOfLines = Appearance.commentLabelLineNumberCollapsed
            
//        }, completion: nil)
        
        dto.isCollapsed = true
    }
    
    func expand() {
        
//        UIView.animate(withDuration: Appearance.collapseAnimationTime, delay: .zero, options: .curveEaseOut, animations: { [weak self] in
//
//            guard let self = self else { return }
            
            self.postCountLabel.isHidden = false
            self.thumbnailImageView.isHidden = false
            self.commentLabel.numberOfLines = Appearance.commentLabelLineNumberExpanded
            
//        }, completion: nil)
        
        dto.isCollapsed = false
    }
    
    override func prepareForReuse() {
        
        
    }
}
