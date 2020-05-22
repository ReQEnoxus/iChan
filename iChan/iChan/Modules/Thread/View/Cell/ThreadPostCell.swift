//
//  ThreadPostCell.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit

class ThreadPostCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate, PostViewDelegate {
    
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
            
            UIView.performWithoutAnimation {
                postView.attachmentCollectionView.reloadSections(IndexSet([0]))
            }
            postView.attachmentCollectionView.refreshLayout()
            postView.attachmentCollectionView.isHidden = false
        }
        else {
            postView.attachmentCollectionView.isHidden = true
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        postView = PostView(delegate: self)
        
        postView.attachmentCollectionView.delegate = self
        postView.attachmentCollectionView.dataSource = self
        
        let replyTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedTextView(tapGesture:)))
        let commentTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedTextView(tapGesture:)))
        postView.commentTextView.addGestureRecognizer(commentTapRecognizer)
        postView.repliesTextView.addGestureRecognizer(replyTapRecognizer)
        
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
        
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let files = post.files {
            delegate?.didTapImage(index: indexPath.row, files: files)
        }
    }
    
    //MARK: - Gesture
    @objc func tappedTextView(tapGesture: UIGestureRecognizer) {
        
        guard let textView = tapGesture.view as? UITextView else { return }
        guard let position = textView.closestPosition(to: tapGesture.location(in: textView)) else { return }
        if let url = textView.textStyling(at: position, in: .forward)?[NSAttributedString.Key.link] as? URL {
            delegate?.didTapUrl(url: url)
        }
    }
    
    //MARK: - PostView Delegate
    func postNumberButtonPressed() {
        delegate?.postNumberButtonPressed(replyingTo: post.num)
    }
}
