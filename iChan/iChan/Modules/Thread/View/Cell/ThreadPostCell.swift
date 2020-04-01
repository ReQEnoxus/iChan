//
//  ThreadPostCell.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit

class ThreadPostCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextViewDelegate {

    //MARK: - UI Constants
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
    }
    
    var post: Post!
    weak var delegate: ThreadPostCellDelegate?
    
    //MARK: - Setup Methods
    func configure(with post: Post, delegate: ThreadPostCellDelegate) {
        
        self.post = post
        self.delegate = delegate
        
        dateAndNameLabel.setHTMLFromString(htmlText: "\(post.name) \(post.date)", fontSize: Appearance.infoFontSize)
        numberButton.setTitle(post.num, for: .normal)
        
        commentTextView.setHTMLFromString(htmlText: post.comment, fontSize: Appearance.commentFontSize)
        
        if !post.repliesStr.isEmpty {
            
            repliesTextView.isHidden = false
            repliesTextView.setHTMLFromString(htmlText: post.repliesStr, fontSize: Appearance.repliesFontSize)
        }
        else {
            repliesTextView.isHidden = true
        }
        
        if post.files != nil, !post.files!.isEmpty {
            attachmentCollectionView.isHidden = false
        }
        else {
            attachmentCollectionView.isHidden = true
        }
        
        attachmentCollectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dateAndNumberView.addSubview(dateAndNameLabel)
        dateAndNumberView.addSubview(numberButton)
        
        mainStackView.addArrangedSubview(dateAndNumberView)
        mainStackView.addArrangedSubview(attachmentCollectionView)
        mainStackView.addArrangedSubview(commentTextView)
        mainStackView.addArrangedSubview(repliesTextView)
        
        contentView.addSubview(mainStackView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        mainStackView.snp.makeConstraints { make in
            
            make.left.equalTo(contentView).offset(Appearance.stackViewLeftOffset)
            make.right.equalTo(contentView).offset(Appearance.stackViewRightOffset)
            make.top.equalTo(contentView).offset(Appearance.stackViewTopOffset)
            make.bottom.equalTo(contentView).offset(Appearance.stackViewBottomOffset)
        
        }
        
        dateAndNameLabel.snp.makeConstraints { make in
                    
            make.left.equalTo(dateAndNumberView).offset(Appearance.dateLabelLeftOffset)
            make.top.equalTo(dateAndNumberView).offset(Appearance.dateLabelTopOffset)
            make.bottom.equalTo(dateAndNumberView).offset(Appearance.dateLabelBottomOffset)
            make.width.equalTo(mainStackView).multipliedBy(Appearance.nameLabelRatio)
        }
        
        numberButton.snp.makeConstraints { make in
        
            make.right.equalTo(dateAndNumberView).offset(Appearance.numberLabelRightOffset)
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
    }
    
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
        textView.delegate = self
        
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
        textView.delegate = self
        
        return textView
    }()
    
    lazy var mainStackView: UIStackView = {
        
        var mainStackView = UIStackView()
        
        mainStackView.alignment = .leading
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceHorizontal = true
        
        return collectionView
    }()
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        repliesTextView.isHidden = false
    }
    
    //MARK: - CollectionView DataSource & Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post.files?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttachmentCell.nibName, for: indexPath) as! AttachmentCell
        
        cell.configureImage(with: post.files?[indexPath.row].thumbnail ?? String())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let files = post.files {
            delegate?.didTapImage(index: indexPath.row, files: files)
        }
    }
    
    //MARK: - TextView Delegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        delegate?.didTapUrl(url: URL)
        return true
    }
}
