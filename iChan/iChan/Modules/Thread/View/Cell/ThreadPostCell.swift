//
//  ThreadPostCell.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit

class ThreadPostCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate {
    
    private class Appearance {
        
        static let infoFontSize: CGFloat = 13
        static let commentFontSize: CGFloat = 14
        static let repliesFontSize: CGFloat = 13
        
        static let infoHexColor = "#909090"
    }
    
    var post: Post!
    var postView: PostView!
    weak var delegate: ThreadPostCellDelegate?
    
    //MARK: - Setup Methods
    func configure(with post: Post, delegate: ThreadPostCellDelegate) {
        
        self.post = post
        self.delegate = delegate
        
        postView.dateAndNameLabel.setHTMLFromString(htmlText: "\(post.name) \(post.date)", fontSize: Appearance.infoFontSize, hexColor: Appearance.infoHexColor)
        postView.numberButton.setTitle(post.num, for: .normal)
        
        postView.commentTextView.setHTMLFromString(htmlText: post.comment, fontSize: Appearance.commentFontSize)
        
        if !post.repliesStr.isEmpty {
            
            postView.repliesTextView.isHidden = false
            postView.repliesTextView.setHTMLFromString(htmlText: post.repliesStr, fontSize: Appearance.repliesFontSize)
        }
        else {
            postView.repliesTextView.isHidden = true
        }
        
        if post.files != nil, !post.files!.isEmpty {
            postView.attachmentCollectionView.isHidden = false
        }
        else {
            postView.attachmentCollectionView.isHidden = true
        }
        
        postView.attachmentCollectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        postView = PostView()
        
        postView.attachmentCollectionView.delegate = self
        postView.attachmentCollectionView.dataSource = self
        postView.commentTextView.delegate = self
        postView.repliesTextView.delegate = self
        
        contentView.addSubview(postView)
        postView.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        postView.repliesTextView.isHidden = false
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
