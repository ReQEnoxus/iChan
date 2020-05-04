//
//  ReplyViewController.swift
//  iChan
//
//  Created by Enoxus on 03.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit

class ReplyViewController: UIViewController, ReplyViewInput {
    
    //MARK: - UI Constants
    private class Appearance {
        
        static let topicLabelFontSize: CGFloat = 12
        static let textViewFontSize: CGFloat = 16
        
        static let topicLabelTopOffset = 16
        static let topicLabelLeftOffset = 8
        static let topicLabelRightOffset = -8
        
        static let topicTextFieldTopOffset = 8
        
        static let messageLabelTopOffset = 8
        static let messageLabelLeftOffset = 8
        static let messageLabelRightOffset = -8
        
        static let messageTextFieldTopOffset = 8
        static let messageTextFieldHeight = 250
        
        static let topicLabelText = "Тема"
        static let topicTextFieldPlaceholder = "Введите тему или опцию"
        static let messageLabelText = "Сообщение"
        static let messageTextFieldPlaceholder = "Введите ваше сообщение"
        static let closeButtonTitle = "Закрыть"
        static let sendButtonTitle = "Отправить"
    }
    
    var presenter: ReplyViewOutput!
    
    //MARK: - Views
    lazy var topicLabel: UILabel = {
        
        let label = UILabel()
        label.font = label.font.withSize(Appearance.topicLabelFontSize)
        label.text = Appearance.topicLabelText
        label.textColor = .white
        
        return label
    }()
    
    lazy var topicTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = Appearance.topicTextFieldPlaceholder
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.tintColor = .orangeUi
        textField.delegate = self
        textField.keyboardAppearance = .dark
        
        return textField
    }()
    
    lazy var messageLabel: UILabel = {
        
        let label = UILabel()
        label.font = label.font.withSize(Appearance.topicLabelFontSize)
        label.text = Appearance.messageLabelText
        label.textColor = .white
        
        return label
    }()
    
    lazy var messageTextView: UITextView = {
        
        let textView = UITextView()
        textView.isEditable = true
        textView.textColor = .white
        textView.font = .systemFont(ofSize: Appearance.textViewFontSize)
        textView.tintColor = .orangeUi
        textView.delegate = self
        textView.keyboardAppearance = .dark
        
        return textView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .blackBg
        configureNavigationBar(largeTitleColor: .white, backgroundColor: .darkNavBar, tintColor: .white, title: String(), preferredLargeTitle: false)
        setupViewHierarchy()
        setupConstraints()
        topicTextField.backgroundColor = .darkCellBg
        messageTextView.backgroundColor = .darkCellBg
        presenter.initialSetup()
    }
    
    //MARK: - Setup
    func setupViewHierarchy() {
        
        view.addSubview(topicLabel)
        view.addSubview(topicTextField)
        view.addSubview(messageLabel)
        view.addSubview(messageTextView)
        
        configureLeftNavbarButton()
        configureRightNavbarButton()
    }
    
    func configureLeftNavbarButton() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        navigationItem.leftBarButtonItem?.title = Appearance.closeButtonTitle
        navigationItem.leftBarButtonItem?.tintColor = .orangeUi
        navigationItem.leftBarButtonItem?.target = self
        navigationItem.leftBarButtonItem?.action = #selector(cancelButtonPressed)
    }
    
    func configureRightNavbarButton() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        navigationItem.rightBarButtonItem?.title = Appearance.sendButtonTitle
        navigationItem.rightBarButtonItem?.tintColor = .orangeUi
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(sendButtonPressed)
    }
    
    func setupConstraints() {
        
        topicLabel.snp.makeConstraints { make in
            
            make.top.equalToSuperview().offset(Appearance.topicLabelTopOffset)
            make.left.equalToSuperview().offset(Appearance.topicLabelLeftOffset)
            make.right.equalToSuperview().offset(Appearance.topicLabelRightOffset)
        }
        
        topicTextField.snp.makeConstraints { make in
            
            make.top.equalTo(topicLabel.snp.bottom).offset(Appearance.topicTextFieldTopOffset)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            
            make.top.equalTo(topicTextField.snp.bottom).offset(Appearance.messageLabelTopOffset)
            make.left.equalToSuperview().offset(Appearance.messageLabelLeftOffset)
            make.right.equalToSuperview().offset(Appearance.messageLabelRightOffset)
        }
        
        messageTextView.snp.makeConstraints { make in
            
            make.top.equalTo(messageLabel.snp.bottom).offset(Appearance.messageTextFieldTopOffset)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(Appearance.messageTextFieldHeight)
        }
    }
    
    //MARK: - View Input
    func setInitialMessageText(_ text: String) {
        messageTextView.text = text
    }
    
    //MARK: - objc funcs for buttons
    @objc func cancelButtonPressed() {
        presenter.cancelButtonPressed()
    }
    
    @objc func sendButtonPressed() {
        presenter.sendButtonPressed(message: Message(topic: topicTextField.text ?? String(), text: messageTextView.text))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension ReplyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageTextView.becomeFirstResponder()
    }
}

extension ReplyViewController: UITextViewDelegate {
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
    }
}
