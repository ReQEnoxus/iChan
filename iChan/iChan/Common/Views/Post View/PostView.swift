//
//  PostView.swift
//  iChan
//
//  Created by Enoxus on 02/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit

class PostView: UIView {
    
    private class Appearance {
        
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
        
        static let thumbnailImageHeight = 150
        static let thumbnailImageWidth = 150
        static let thumbnailImageSize = CGSize(width: 150, height: 150)
        
        static let thumbnailCollapsedHeight = 0
        
        static let stackViewSpacing: CGFloat = 5
        
        static let infoFontSize: CGFloat = 13
        static let commentFontSize: CGFloat = 14
        static let repliesFontSize: CGFloat = 13
        
        static let dateLabelLineNumber = 0
        static let numberLabelLineNumber = 1
        static let commentTextViewLineNumberExpanded = 0
        static let commentTextViewLineNumberCollapsed = 1
        static let postCountLabelLineNumber = 1
        
        static let nameLabelRatio = 0.75
        
        static let infoHexColor = "#909090"
    }
    
    weak var delegate: PostViewDelegate?
    
    //MARK: - UI Elements
    lazy var dateAndNameLabel: UILabel = {
        
        var dateAndNameLabel = UILabel()
        
        dateAndNameLabel.numberOfLines = Appearance.dateLabelLineNumber
        dateAndNameLabel.sizeToFit()
        dateAndNameLabel.textColor = .paleGrey60
        dateAndNameLabel.font = dateAndNameLabel.font.withSize(Appearance.infoFontSize)
        dateAndNameLabel.lineBreakMode = .byWordWrapping
        dateAndNameLabel.numberOfLines = Appearance.dateLabelLineNumber
        
        return dateAndNameLabel
    }()
    
    let numberButton: UIButton = {
        
        var numberButton = UIButton(type: .system)
        numberButton.setTitleColor(.orangeUi, for: .normal)
        numberButton.addTarget(self, action: #selector(numberButtonPressed), for: .touchUpInside)
        
        return numberButton
    }()
    
    let dateAndNumberView = UIView()
    
    lazy var commentTextView: UITextView = {
        
        var textView = UITextView()
        
        textView.backgroundColor = .darkCellBg
        textView.allowsEditingTextAttributes = false
        textView.isEditable = false
        textView.textColor = .white
        textView.tintColor = .orangeUi
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    lazy var repliesTextView: UITextView = {
        
        var textView = UITextView()
        
        textView.backgroundColor = .darkCellBg
        textView.allowsEditingTextAttributes = false
        textView.isEditable = false
        textView.textColor = .white
        textView.tintColor = .orangeUi
        textView.isScrollEnabled = false
        textView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return textView
    }()
    
    lazy var mainStackView: UIStackView = {
        
        var mainStackView = UIStackView()
        
        mainStackView.alignment = .fill
        mainStackView.spacing = Appearance.stackViewSpacing
        mainStackView.axis = .vertical
        
        return mainStackView
    }()
    
    lazy var attachmentCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Appearance.thumbnailImageSize
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(cellClass: AttachmentCell.self)
        
        collectionView.backgroundColor = .darkCellBg
        collectionView.alwaysBounceHorizontal = true
        
        return collectionView
    }()
    
    func setupConstraints() {
        
        mainStackView.snp.makeConstraints { make in
            
            make.left.equalTo(self).offset(Appearance.stackViewLeftOffset)
            make.right.equalTo(self).offset(Appearance.stackViewRightOffset)
            make.top.equalTo(self).offset(Appearance.stackViewTopOffset)
            make.bottom.equalTo(self).offset(Appearance.stackViewBottomOffset)
        
        }
        
        dateAndNameLabel.snp.makeConstraints { make in
                    
            make.left.equalTo(dateAndNumberView).offset(Appearance.dateLabelLeftOffset)
            make.top.equalTo(dateAndNumberView).offset(Appearance.dateLabelTopOffset)
            make.bottom.equalTo(dateAndNumberView).offset(Appearance.dateLabelBottomOffset)
            make.width.equalTo(mainStackView).multipliedBy(Appearance.nameLabelRatio)
        }
        
        numberButton.snp.makeConstraints { make in
        
            make.right.equalTo(dateAndNumberView.snp.right)
            make.top.equalTo(dateAndNumberView).offset(Appearance.numberLabelTopOffset)
            make.bottom.equalTo(dateAndNumberView).offset(Appearance.numberLabelBottomOffset)
        }
                
        attachmentCollectionView.snp.makeConstraints { make in
            
            make.height.equalTo(Appearance.thumbnailImageHeight).priority(999)
            make.width.equalToSuperview()
        }
        
        commentTextView.snp.makeConstraints { make in
            
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        repliesTextView.snp.makeConstraints { make in
            
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
            
        snp.makeConstraints { make in
            
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .darkCellBg
        
        dateAndNumberView.addSubview(dateAndNameLabel)
        dateAndNumberView.addSubview(numberButton)
        
        mainStackView.addArrangedSubview(dateAndNumberView)
        mainStackView.addArrangedSubview(attachmentCollectionView)
        mainStackView.addArrangedSubview(commentTextView)
        mainStackView.addArrangedSubview(repliesTextView)
        
        addSubview(mainStackView)
    }
    
    convenience init(delegate: PostViewDelegate) {
        
        self.init()
        self.delegate = delegate
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func numberButtonPressed() {
        delegate?.postNumberButtonPressed()
    }
}
