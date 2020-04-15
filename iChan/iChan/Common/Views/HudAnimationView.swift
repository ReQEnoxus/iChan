//
//  HudAnimationView.swift
//  iChan
//
//  Created by Enoxus on 13/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Lottie
import JGProgressHUD
import SnapKit

class HudAnimationView: JGProgressHUDIndicatorView {
    
    private class Appearance {
        
        static let loadingAnimationName = "loading"
        static let loadingViewHeight: CGFloat = 100
        static let loadingViewWidth: CGFloat = 100
    }
    
    private var loadingView: AnimationView
    private var container: UIView
    
    func playAnimation() {
        
        loadingView.play()
    }
    
    func stopAnimation() {
        
        loadingView.stop()
    }
    
    init() {
        
        loadingView = AnimationView()
        loadingView.animation = Animation.named(Appearance.loadingAnimationName)
        loadingView.loopMode = .loop
        
        container = UIView(frame: CGRect(x: .zero, y: .zero, width: Appearance.loadingViewWidth, height: Appearance.loadingViewHeight))
        
        container.addSubview(loadingView)
        
        loadingView.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        
        loadingView.play()
        
        super.init(contentView: container)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
