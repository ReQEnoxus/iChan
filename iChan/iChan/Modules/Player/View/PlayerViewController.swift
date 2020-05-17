//
//  PlayerViewController.swift
//  iChan
//
//  Created by Enoxus on 19.04.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

class PlayerViewController: UIViewController, PlayerViewInput {
    
    private class Appearance {
        
        static let controlsViewWidthMultiplier = 0.9
        static let controlsViewBottomOffset = -32
        static let controlsViewHeight = 120
        static let controlsViewCornerRadius: CGFloat = 10
        
        static let playButtonLeftOffset = 8
        static let playButtonTopOffset = 8
        static let playButtonBottomOffset = -8
        
        static let sliderLeftOffset = 8
        static let sliderRightOffset = -8
        static let sliderTopOffset = 8
        static let sliderBottomOffset = -8
        
        static let timeLabelRightOffset = -8
        
        static let exitViewTopOffset = 40
        static let exitViewRightOffset = -32
        static let exitViewWidth = 35
        static let exitViewHeight = 35
        
        static let exitViewRightMultiplier = 0.95
        
        static let pauseButtonImageName = "SF_pause_circle_fill"
        static let playButtonImageName = "SF_play_circle_fill"
        static let sliderThumbImageName = "SF_square_fill_and_line_vertical_and_square"
        static let exitImageName = "SF_xmark_square_fill"
        static let loadingAnimationName = "loading"

        static let animationSideLength = 100
        
        static let timePlaceholder = "00:00"
        
        static let exitButtonSize = CGSize(width: 20, height: 20)
        static let playButtonSize = CGSize(width: 25, height: 25)
        
        static let sliderThumbSize = CGSize(width: 10, height: 10)
            
        static let hideAnimationDuration = 0.5
        static let hideAnimationDelay = 2.0
    }
    
    var presenter: PlayerViewOutput!
    
    private var isPlaying = false
    
    private var idleTimer: Timer?
    
    lazy var playerView: UIView = {
        
        let view = UIView()
        view.addGestureRecognizer(unhideGestureRecognizer)
        
        return view
    }()
    
    lazy var controlsView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .darkPlayerUiBg
        view.layer.cornerRadius = Appearance.controlsViewCornerRadius
        
        return view
    }()
    
    lazy var exitView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .darkPlayerUiBg
        view.layer.cornerRadius = Appearance.controlsViewCornerRadius
        
        return view
    }()
    
    lazy var loadingView: AnimationView = {
        
        var loadingView = AnimationView()
        loadingView.animation = Animation.named(Appearance.loadingAnimationName)
        loadingView.loopMode = .loop
        
        return loadingView
    }()
    
    lazy var exitButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Appearance.exitImageName)?.resizeAndShift(newSize: Appearance.exitButtonSize, shiftLeft: .zero, shiftTop: .zero), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
        
        return button
    }()
    
    lazy var togglePlayButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Appearance.playButtonImageName)?.resizeAndShift(newSize: Appearance.playButtonSize, shiftLeft: .zero, shiftTop: .zero), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTogglePlay), for: .touchUpInside)
        
        return button
    }()
    
    lazy var seekSlider: UISlider = {
        
        let slider = UISlider()
        slider.minimumTrackTintColor = .paleGrey60
        slider.setThumbImage(UIImage(named: Appearance.sliderThumbImageName)?.resizeAndShift(newSize: Appearance.sliderThumbSize, shiftLeft: .zero, shiftTop: .zero), for: .normal)
        slider.addTarget(self, action: #selector(changedSliderValue), for: .valueChanged)
        
        return slider
    }()
    
    lazy var timeLabel: UILabel = {
        
        let label = UILabel()
        label.text = Appearance.timePlaceholder
        label.textColor = .white
        
        return label
    }()
    
    lazy var unhideGestureRecognizer: UITapGestureRecognizer = {
        
        let recognizer = UITapGestureRecognizer()
        recognizer.numberOfTapsRequired = 1
        recognizer.addTarget(self, action: #selector(showControls))
        recognizer.delegate = self
        
        return recognizer
    }()
    
    func setupConstraints() {
        
        playerView.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        
        controlsView.snp.makeConstraints { make in
            
            make.bottom.equalToSuperview().offset(Appearance.controlsViewBottomOffset)
            make.width.equalToSuperview().multipliedBy(Appearance.controlsViewWidthMultiplier)
            make.centerX.equalToSuperview()
        }
        
        togglePlayButton.snp.makeConstraints { make in
            
            make.left.equalToSuperview().offset(Appearance.playButtonLeftOffset)
            make.top.equalToSuperview().offset(Appearance.playButtonTopOffset)
            make.bottom.equalToSuperview().offset(Appearance.playButtonBottomOffset)
        }
        
        timeLabel.snp.makeConstraints { make in
            
            make.right.equalToSuperview().offset(Appearance.timeLabelRightOffset)
            make.centerY.equalToSuperview()
        }
        
        seekSlider.snp.makeConstraints { make in
            
            make.left.equalTo(togglePlayButton.snp.right).offset(Appearance.sliderLeftOffset)
            make.centerY.equalToSuperview()
            make.right.equalTo(timeLabel.snp.left).offset(Appearance.sliderRightOffset)
        }
        
        exitView.snp.makeConstraints { make in
            
            make.height.equalTo(Appearance.exitViewHeight)
            make.width.equalTo(Appearance.exitViewWidth)
            make.top.equalToSuperview().offset(Appearance.exitViewTopOffset)
            make.right.equalToSuperview().multipliedBy(Appearance.exitViewRightMultiplier)
        }
        
        exitButton.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
    }
    
    func setupViewHierarchy() {
        
        view.addSubview(playerView)
        view.addSubview(controlsView)
        view.addSubview(exitView)
        exitView.addSubview(exitButton)
        controlsView.addSubview(togglePlayButton)
        controlsView.addSubview(seekSlider)
        controlsView.addSubview(timeLabel)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        presenter.initialSetup()
    }
    
    //MARK: - ViewInput
    func setMaxValueForSlider(_ value: Float) {
        seekSlider.maximumValue = value
    }
    
    func setValueForSlider(_ value: Float) {
        seekSlider.value = value
    }
    
    func displayLoadingIndicator() {
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
            make.height.equalTo(Appearance.animationSideLength)
            make.width.equalTo(Appearance.animationSideLength)
        }
        loadingView.play()
    }
    
    func removeLoadingIndicator() {
        loadingView.removeFromSuperview()
    }
    
    func initialSetupFinished() {
        
        setupViewHierarchy()
        setupConstraints()
        didTogglePlay()
        showControls()
        resetIdleTimer()
    }
    
    func setValueForTimeLabel(_ value: String) {
        timeLabel.text = value
    }
    
    //MARK: - objc methods for buttons and gesture recognizers
    @objc func didTapExit() {
        presenter.exitButtonPressed()
    }
    
    @objc func didTogglePlay() {
        
        resetIdleTimer()
        if !isPlaying {
            
            togglePlayButton.setImage(UIImage(named: Appearance.pauseButtonImageName)?.resizeAndShift(newSize: Appearance.playButtonSize, shiftLeft: .zero, shiftTop: .zero), for: .normal)
            isPlaying = true
        }
        else {

            togglePlayButton.setImage(UIImage(named: Appearance.playButtonImageName)?.resizeAndShift(newSize: Appearance.playButtonSize, shiftLeft: .zero, shiftTop: .zero), for: .normal)
            isPlaying = false
        }
        
        presenter.playOrPauseToggled()
    }
    
    @objc func changedSliderValue() {
        
        resetIdleTimer()
        presenter.sliderDidChangeValue(newValue: seekSlider.value)
    }
    
    @objc func showControls() {
        
        controlsView.alpha = 1
        exitView.alpha = 1
    }
    
    //MARK: - Util
    func resetIdleTimer() {
        
        idleTimer?.invalidate()
        idleTimer = Timer.scheduledTimer(withTimeInterval: Appearance.hideAnimationDelay, repeats: false) { _ in

            UIView.animate(withDuration: Appearance.hideAnimationDuration) {
                
                self.controlsView.alpha = 0
                self.exitView.alpha = 0
            }
        }
    }
}

extension PlayerViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        resetIdleTimer()
        return true
    }
}
