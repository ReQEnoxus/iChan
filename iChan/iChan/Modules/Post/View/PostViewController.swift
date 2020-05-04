//
//  PostViewController.swift
//  iChan
//
//  Created by Enoxus on 02/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit

class PostViewController: UIViewController, UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, PostViewInput, PostViewDelegate {
    
    //MARK: - UI Constants
    private class Appearance {
        
        static let infoFontSize: CGFloat = 13
        static let commentFontSize: CGFloat = 14
        static let repliesFontSize: CGFloat = 13
        
        static let postViewTopOffset = 32
        static let postViewLeftOffset = 32
        static let postViewRightOffset = -32
        static let postViewBottomOffset = -32
        
        static let cornerRadius: CGFloat = 10
        
        static let maxHeight = UIScreen.main.bounds.height * 0.75
        
        static let animationTime = 0.25
        static let infoHexColor = "#909090"
    }
    
    var postView: PostView!
    var post: Post!
    var presenter: PostViewOutput!
    
    
    //MARK: - Views
    lazy var scrollView: UIScrollView = {
        
        var scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.backgroundColor = .darkCellBg
        scrollView.indicatorStyle = .white
        
        return scrollView
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        scrollView.addSubview(postView)
        view.addSubview(scrollView)
        
        let outsideTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissRequested))
        outsideTapGestureRecognizer.delegate = self
        view.addGestureRecognizer(outsideTapGestureRecognizer)
        
        scrollView.layer.cornerRadius = Appearance.cornerRadius
        
        postView.attachmentCollectionView.dataSource = self
        postView.attachmentCollectionView.delegate = self
        postView.commentTextView.delegate = self
        postView.repliesTextView.delegate = self
        
        postView.setupConstraints()
        
        scrollView.snp.makeConstraints { make in
            
            make.left.equalToSuperview().offset(Appearance.postViewLeftOffset)
            make.right.equalToSuperview().offset(Appearance.postViewRightOffset)
            make.center.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            
            if Appearance.maxHeight > scrollView.contentSize.height {
                make.height.equalTo(scrollView.contentSize.height)
            }
            else {
                make.height.equalTo(Appearance.maxHeight)
            }
        }
        
        presenter.initialSetup()
    }
    
    @objc func dismissRequested() {
        presenter.dismissRequested()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            
            guard let self = self else { return }
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            
            guard let self = self else { return }
            self.view.backgroundColor = .clear
        }
    }
    
    //MARK: - CollectionView Delegate & Datasource
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
            presenter.didTapImage(index: indexPath.item, files: files)
        }
    }

    //MARK: - TextView Delegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        presenter.didTapUrl(url: URL)
        return false
    }
    
    //MARK: - ViewInput
    func configure(with post: Post) {
        
        self.post = post
                        
        postView.dateAndNameLabel.setHTMLFromString(htmlText: "\(post.name) \(post.date)", fontSize: Appearance.infoFontSize, hexColor: Appearance.infoHexColor)
        postView.numberButton.setTitle(post.num, for: .normal)
        
        postView.commentTextView.setHTMLFromString(htmlText: post.comment, fontSize: Appearance.commentFontSize)
        postView.repliesTextView.setHTMLFromString(htmlText: post.repliesStr, fontSize: Appearance.repliesFontSize)
        
        scrollView.setContentOffset(.zero, animated: false)
            
            if !post.repliesStr.isEmpty {
                
                postView.repliesTextView.isHidden = false
            }
            else {
                postView.repliesTextView.isHidden = true
            }
            
            if post.files != nil, !post.files!.isEmpty {
                
                postView.attachmentCollectionView.isHidden = false
                postView.attachmentCollectionView.refreshLayout()
                postView.attachmentCollectionView.reloadData()
            }
            else {
                postView.attachmentCollectionView.isHidden = true
            }
        
        UIView.animate(withDuration: Appearance.animationTime, delay: .zero, options: .curveEaseOut, animations: { [weak self] in
            
            guard let self = self else { return }
            
            self.view.layoutIfNeeded()
            
            self.scrollView.snp.updateConstraints { make in

                if Appearance.maxHeight > self.scrollView.contentSize.height {

                    make.height.equalTo(self.scrollView.contentSize.height)
                }
                else {
                    make.height.equalTo(Appearance.maxHeight)
                }
            }
            
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    //MARK: - PostView Delegate
    func postNumberButtonPressed() {
        presenter.postNumberButtonPressed(replyingTo: post.num)
    }
}

//MARK: - Extensions
extension PostViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}
