//
//  PostAttachmentCell.swift
//  iChan
//
//  Created by Enoxus on 08.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit

class PostAttachmentCell: UITableViewCell {
    
    private class Appearance {
        
        static let miniatureLeftOffset = 8
        static let miniatureTopOffset = 8
        static let miniatureBottomOffset = -8
        
        static let nameLabelLeftOffset = 8
        static let nameLabelRightOffset = -8
        
        static let deleteButtonRightOffset = -8
        
        static let bgEdgeOffset = 4
        
        static let imageNameFontSize: CGFloat = 12
        
        static let imageSize = 30
        static let buttonSize = 20
        
        static let imageCornerRadius: CGFloat = 5
        
        static let nameLabelLineNumber = 1
        
        static let deleteButtonImageName = "SF_xmark_square_fill"
        
        static let bgViewCornerRadius: CGFloat = 10
    }
    
    var attachment: PostAttachment!
    weak var delegate: AttachmentCellDelegate?
    
    //MARK: - Views
    lazy var attachmentMiniatureImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Appearance.imageCornerRadius
        
        return imageView
    }()
    
    lazy var bgView: UIView = {
        
        let view = UIView()
        
        view.layer.cornerRadius = Appearance.bgViewCornerRadius
        view.backgroundColor = .darkCellBg
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var attachmentNameLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = Appearance.nameLabelLineNumber
        label.textColor = .white
        label.lineBreakMode = .byTruncatingMiddle
        label.font = .systemFont(ofSize: Appearance.imageNameFontSize)
        
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Appearance.deleteButtonImageName), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        
        return button
    }()

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
        
        contentView.backgroundColor = .clear
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewHierarchy() {
        
        contentView.addSubview(bgView)
        bgView.addSubview(attachmentMiniatureImageView)
        bgView.addSubview(attachmentNameLabel)
        bgView.addSubview(deleteButton)
    }
    
    func setupConstraints() {
        
        bgView.snp.makeConstraints { make in
            
            make.left.equalToSuperview().offset(Appearance.bgEdgeOffset)
            make.top.equalToSuperview().offset(Appearance.bgEdgeOffset)
            make.right.equalToSuperview().inset(Appearance.bgEdgeOffset)
            make.bottom.equalToSuperview().inset(Appearance.bgEdgeOffset)
        }
        
        attachmentMiniatureImageView.snp.makeConstraints { make in
            
            make.width.equalTo(Appearance.imageSize)
            make.height.equalTo(Appearance.imageSize)
            make.left.equalToSuperview().offset(Appearance.miniatureLeftOffset)
            make.top.equalToSuperview().offset(Appearance.miniatureTopOffset)
            make.bottom.equalToSuperview().offset(Appearance.miniatureBottomOffset)
        }
        
        deleteButton.snp.makeConstraints { make in
            
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(Appearance.deleteButtonRightOffset)
            make.width.equalTo(Appearance.buttonSize)
            make.height.equalTo(Appearance.buttonSize)
        }
        
        attachmentNameLabel.snp.makeConstraints { make in
            
            make.centerY.equalToSuperview()
            make.left.equalTo(attachmentMiniatureImageView.snp.right).offset(Appearance.nameLabelLeftOffset)
            make.right.equalTo(deleteButton.snp.left).offset(Appearance.nameLabelRightOffset)
        }
    }
    
    func configure(with attachment: PostAttachment, delegate: AttachmentCellDelegate?) {
        
        self.attachment = attachment
        attachmentMiniatureImageView.image = UIImage(data: attachment.data)
        attachmentNameLabel.text = attachment.name
        self.delegate = delegate
    }
    
    @objc func deleteButtonPressed() {
        delegate?.deleteButtonPressed(on: attachment)
    }
}
