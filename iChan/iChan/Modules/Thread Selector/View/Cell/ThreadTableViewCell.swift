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

class ThreadTableViewCell: UITableViewCell, UITextViewDelegate {
    
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
        static let imageCornerRadius: CGFloat = 10
        
        static let thumbnailCollapsedHeight = 0
        
        static let stackViewSpacing: CGFloat = 5
        
        static let infoFontSize: CGFloat = 13
        static let commentFontSize: CGFloat = 14
        
        static let postCountHeight = 20
        
        static let dateLabelLineNumber = 0
        static let numberLabelLineNumber = 1
        static let commentTextViewLineNumberExpanded = 12
        static let commentTextViewLineNumberCollapsed = 1
        static let postCountLabelLineNumber = 1
        
        static let collapseAnimationTime = 0.5
        static let infoHexColor = "#909090"
        static let nameLabelRatio = 0.75
        static let placeHolderImageName = "placeholder"
    }
    
    weak var delegate: ThreadTableViewCellDelegate?
    
    //MARK: - UI Elements
    lazy var dateAndNameLabel: UILabel = {
        
        var dateAndNameLabel = UILabel()
        
        dateAndNameLabel.numberOfLines = Appearance.dateLabelLineNumber
        dateAndNameLabel.sizeToFit()
        dateAndNameLabel.textColor = .paleGrey60
        dateAndNameLabel.font = dateAndNameLabel.font.withSize(Appearance.infoFontSize)
        
        return dateAndNameLabel
    }()
    
    let numberLabel: UILabel = {
        
        var numberLabel = UILabel()
        
        numberLabel.numberOfLines = Appearance.numberLabelLineNumber
        numberLabel.sizeToFit()
        numberLabel.textColor = .paleGrey60
        numberLabel.font = numberLabel.font.withSize(Appearance.infoFontSize)
        
        return numberLabel
    }()
    
    lazy var thumbnailImageView: UIImageView = {
        
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Appearance.imageCornerRadius
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        return imageView
    }()
    
    lazy var urlRecognizerGesture: UITapGestureRecognizer = {
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTapUrlInTextView(tapGesture:)))
        
        return recognizer
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
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.delegate = self
        textView.textDragInteraction?.isEnabled = false
            
        return textView
    }()
    
    lazy var postCountLabel: UILabel = {
        
        var postCountLabel = UILabel()
        
        postCountLabel.numberOfLines = Appearance.postCountLabelLineNumber
        postCountLabel.sizeToFit()
        postCountLabel.textColor = .paleGrey60
        postCountLabel.font = postCountLabel.font.withSize(Appearance.infoFontSize)
        
        return postCountLabel
    }()
    
    lazy var mainStackView: UIStackView = {
        
        var mainStackView = UIStackView()
        
        mainStackView.alignment = .leading
        mainStackView.spacing = Appearance.stackViewSpacing
        mainStackView.axis = .vertical
        
        return mainStackView
    }()
    
    var isCollapsed: Bool {
        return dto.isCollapsed
    }
    
    var dto: ThreadDto!
    
    //MARK: - Constraints
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dateAndNumberView.addSubview(dateAndNameLabel)
        dateAndNumberView.addSubview(numberLabel)
        
        mainStackView.addArrangedSubview(dateAndNumberView)
        mainStackView.addArrangedSubview(thumbnailImageView)
        mainStackView.addArrangedSubview(commentTextView)
        mainStackView.addArrangedSubview(postCountLabel)
        
        contentView.addSubview(mainStackView)
        
        commentTextView.addGestureRecognizer(urlRecognizerGesture)
        
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
        
        dateAndNumberView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        dateAndNameLabel.snp.makeConstraints { make in
            
            make.left.equalTo(dateAndNumberView).offset(Appearance.dateLabelLeftOffset)
            make.top.equalTo(dateAndNumberView).offset(Appearance.dateLabelTopOffset)
            make.bottom.equalTo(dateAndNumberView).offset(Appearance.dateLabelBottomOffset)
            make.width.equalToSuperview().multipliedBy(Appearance.nameLabelRatio)
        }
        
        numberLabel.snp.makeConstraints { make in
        
            make.right.equalTo(dateAndNumberView.snp.right)
            make.top.equalTo(dateAndNumberView).offset(Appearance.numberLabelTopOffset)
            make.bottom.equalTo(dateAndNumberView).offset(Appearance.numberLabelBottomOffset)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            
            make.height.equalTo(Appearance.thumbnailImageHeight).priority(999)
            make.width.equalTo(thumbnailImageView.snp.height)
        }
        
        commentTextView.snp.makeConstraints { make in
            
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        postCountLabel.snp.makeConstraints { make in
            
            make.height.equalTo(Appearance.postCountHeight)
            make.width.equalToSuperview()
        }
    }
    
    //MARK: - Configuration
    func configure(with dto: ThreadDto, delegate: ThreadTableViewCellDelegate?) {
        
        self.dto = dto
        self.delegate = delegate
        
        dateAndNameLabel.setHTMLFromString(htmlText: "\(dto.posterName) \(dto.date)", fontSize: Appearance.infoFontSize, hexColor: Appearance.infoHexColor)
        numberLabel.text = "№\(dto.number)"
        
        commentTextView.setHTMLFromString(htmlText: dto.text, fontSize: Appearance.commentFontSize)
        postCountLabel.text = "\(dto.postsCount) постов, \(dto.filesCount) с картинками"
        
        if dto.isCollapsed {
            
            postCountLabel.isHidden = true
            thumbnailImageView.isHidden = true
            
            commentTextView.isScrollEnabled = false
            commentTextView.textContainer.maximumNumberOfLines = Appearance.commentTextViewLineNumberCollapsed
            commentTextView.invalidateIntrinsicContentSize()
            commentTextView.isUserInteractionEnabled = false
        }
        else {
            
            postCountLabel.isHidden = false
            thumbnailImageView.isHidden = false
            
            commentTextView.textContainer.maximumNumberOfLines = Appearance.commentTextViewLineNumberExpanded
            commentTextView.invalidateIntrinsicContentSize()
            commentTextView.isUserInteractionEnabled = true
        }
        
        if let thumbnailData = dto.thumbnailData {
            thumbnailImageView.image = UIImage(data: thumbnailData)
        }
        else if let url = dto.thumbnail {
            thumbnailImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: Appearance.placeHolderImageName))
        }
        else {
            thumbnailImageView.isHidden = true
        }
    }
    
    //MARK: - Collapse & Expand
    func collapse() {
        
        postCountLabel.isHidden = true
        thumbnailImageView.isHidden = true

        commentTextView.textContainer.maximumNumberOfLines = Appearance.commentTextViewLineNumberCollapsed
        commentTextView.invalidateIntrinsicContentSize()
        commentTextView.isUserInteractionEnabled = false

        dto.isCollapsed = true
    }
    
    func expand() {
        
        postCountLabel.isHidden = false
        
        if thumbnailImageView.image != nil {
            thumbnailImageView.isHidden = false
        }
        
        commentTextView.textContainer.maximumNumberOfLines = Appearance.commentTextViewLineNumberExpanded
        commentTextView.invalidateIntrinsicContentSize()
        commentTextView.isUserInteractionEnabled = true
        
        dto.isCollapsed = false
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        commentTextView.isUserInteractionEnabled = false
        thumbnailImageView.sd_cancelCurrentImageLoad()
        thumbnailImageView.image = nil
    }
    
    //MARK: - objc methods for selectors
    @objc func didTapImage() {
        
        if let fileUrl = dto.file, let displayName = dto.fileName, let thumbnail = dto.thumbnail {
            delegate?.didTapImage(with: AttachmentDto(url: fileUrl, displayName: displayName, thumbnail: thumbnail, thumbnailData: dto.thumbnailData, attachmentData: dto.fileData))
        }
    }
    
    //MARK: - Gesture
    @objc func didTapUrlInTextView(tapGesture: UIGestureRecognizer) {
        
        guard let textView = tapGesture.view as? UITextView else { return }
        guard let position = textView.closestPosition(to: tapGesture.location(in: textView)) else { return }
        if let url = textView.textStyling(at: position, in: .forward)?[NSAttributedString.Key.link] as? URL {
            delegate?.didTapUrl(url: url)
        }
        else {
            delegate?.didTapTextView(threadNum: dto.number)
        }
    }
    
    //MARK: - TextViewDelegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return false
    }
}
