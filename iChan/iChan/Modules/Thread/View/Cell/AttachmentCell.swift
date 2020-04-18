//
//  AttachmentCell.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit

class AttachmentCell: UICollectionViewCell {
    
    //MARK: - UI Constants
    private class Appearance {
        
        static let imageSize = 150
        static let imageCornerRadius: CGFloat = 10
        
        static let placeHolderImageName = "placeholder"
    }
    
    //MARK: - Views
    lazy var imageView: UIImageView = {
        
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isOpaque = true
        
        return imageView
    }()
    
    //MARK: - Setup Methods
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        imageView.layer.cornerRadius = Appearance.imageCornerRadius
        
        imageView.snp.makeConstraints { make in
            
            make.height.equalTo(Appearance.imageSize)
            make.width.equalTo(Appearance.imageSize)
            make.center.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImage(with url: String) {
        imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: Appearance.placeHolderImageName))
    }
}
