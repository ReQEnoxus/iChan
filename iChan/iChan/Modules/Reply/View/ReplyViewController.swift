//
//  ReplyViewController.swift
//  iChan
//
//  Created by Enoxus on 03.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit
import ReCaptcha
import Lottie
import Photos

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
        static let messageTextFieldHeight = 150
        
        static let loadingViewCornerRadius: CGFloat = 10
        
        static let loadingViewWidth = 100
        static let loadingViewHeight = 100
        
        static let animationDuration = 0.25
        
        static let endAlpha: CGFloat = 1
        
        static let expandedContainerViewWidthMultiplier: CGFloat = 0.85
        static let expandedContainerViewHeightMultiplier: CGFloat = 0.85
        
        static let errorLogoImageSize = CGSize(width: 150, height: 150)
        static let errorLogoLeftShift: CGFloat = 30
        
        static let errorViewLeftOffset = 16
        static let errorViewRightOffset = -16
        
        static let addAttachmentButtonLeftOffset = 20
        static let addAttachmentButtonRightOffset = -20
        static let addAttachmentButtonHeight = 50
        static let addAttachmentButtonTopOffset = 8
        
        static let attachmentsTableViewTopOffset = 8
        static let attachmentsTableViewLeftOffset = 16
        static let attachmentsTableViewRightOffset = -16
        static let attachmentsTableViewBottomOffset = -16
        
        static let errorLabelLineNumber = 0
        
        static let conatinerSpacing: CGFloat = 5
        
        static let errorViewHeightOffset: CGFloat = 60
        
        static let addAttachmentButtonTitle = "Добавить вложения"
        static let okButtonTitle = "Понял"
        static let loadingAnimationName = "loading"
        static let topicLabelText = "Тема"
        static let topicTextFieldPlaceholder = "Введите тему или опцию"
        static let messageLabelText = "Сообщение"
        static let messageTextFieldPlaceholder = "Введите ваше сообщение"
        static let closeButtonTitle = "Закрыть"
        static let sendButtonTitle = "Отправить"
        static let errorLogoImageName = "SF_exclamationmark_octagon-1"
    }
    
    var presenter: ReplyViewOutput!
    
    var captcha: ReCaptcha!
    
    //MARK: - Views
    lazy var topicLabel: UILabel = {
        
        let label = UILabel()
        label.font = label.font.withSize(Appearance.topicLabelFontSize)
        label.text = Appearance.topicLabelText
        label.textColor = .white
        
        return label
    }()
    
    var errorLabel: UILabel!
    
    var okButton: UIButton!
    
    lazy var errorImageView: UIImageView = {
        return UIImageView()
    }()
    
    var errorView: UIStackView!
    
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
    
    var loadingContainerView: UIView!
    
    var loadingView: AnimationView!
    
    lazy var coverView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .coverColor
        
        return view
    }()
    
    lazy var addAttachmentButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.layer.cornerRadius = Appearance.loadingViewCornerRadius
        button.backgroundColor = .swipeActionPrimary
        button.setTitle(Appearance.addAttachmentButtonTitle, for: .normal)
        button.tintColor = .orangeUi
        button.addTarget(self, action: #selector(addAttachmentButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    lazy var attachmentsTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .blackBg
        tableView.register(cell: PostAttachmentCell.self)
        
        return tableView
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
        view.addSubview(addAttachmentButton)
        view.addSubview(attachmentsTableView)
        
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
    
    func toggleButtonEnabledState() {
        
        navigationItem.rightBarButtonItem?.isEnabled.toggle()
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
        
        addAttachmentButton.snp.makeConstraints { make in
            
            make.top.equalTo(messageTextView.snp.bottom).offset(Appearance.addAttachmentButtonTopOffset)
            make.left.equalToSuperview().offset(Appearance.addAttachmentButtonLeftOffset)
            make.right.equalToSuperview().offset(Appearance.addAttachmentButtonRightOffset)
            make.height.equalTo(Appearance.addAttachmentButtonHeight)
        }
        
        attachmentsTableView.snp.makeConstraints { make in
            
            make.top.equalTo(addAttachmentButton.snp.bottom).offset(Appearance.attachmentsTableViewTopOffset)
            make.left.equalToSuperview().offset(Appearance.attachmentsTableViewLeftOffset)
            make.right.equalToSuperview().offset(Appearance.attachmentsTableViewRightOffset)
            make.bottom.equalToSuperview().offset(Appearance.attachmentsTableViewBottomOffset)
        }
    }
    
    //MARK: - View Input
    func setInitialMessageText(_ text: String) {
        messageTextView.text = text
    }
    
    func validationRequested(on id: String) {
        
        captcha = try? ReCaptcha(apiKey: id, baseURL: URL(string: Endpoint.baseUrl), endpoint: .default)
        
        captcha.configureWebView { [weak self] webView in
            
            self?.loadingContainerView.subviews.forEach({ $0.removeFromSuperview() })
            self?.loadingContainerView.addSubview(webView)
            
            webView.snp.makeConstraints { make in
                
                make.center.equalToSuperview()
                make.size.equalToSuperview()
            }
            
            self?.loadingContainerView.snp.updateConstraints { update in
                
                update.width.equalTo(self?.view.frame.width ?? .zero * Appearance.expandedContainerViewWidthMultiplier)
                update.height.equalTo(self?.view.frame.height ?? .zero * Appearance.expandedContainerViewHeightMultiplier)
            }
        
            self?.loadingContainerView.setNeedsLayout()
            
            UIView.animate(withDuration: Appearance.animationDuration, delay: .zero, options: .curveEaseOut, animations: { [weak self] in
                
                self?.loadingContainerView.layoutIfNeeded()
                webView.layoutIfNeeded()
            }, completion: .none)
        }
        
        validateCaptcha()
    }
    
    func reloadAttachmentsData() {
        attachmentsTableView.reloadData()
    }
    
    func reloadAttachmentsData(deletions: [IndexPath], insertions: [IndexPath]) {
        
        attachmentsTableView.beginUpdates()
        
        attachmentsTableView.deleteRows(at: deletions, with: .automatic)
        attachmentsTableView.insertRows(at: insertions, with: .automatic)
        
        attachmentsTableView.endUpdates()
    }
    
    func registerDataSourceForAttachmentsTable(_ dataSource: ReplyDataSource) {
        attachmentsTableView.dataSource = dataSource
    }
    
    func displayLoadingIndicator() {
        
        toggleButtonEnabledState()
        createPostingRelatedViews()
        
        view.addSubview(coverView)
        coverView.alpha = .zero
        coverView.frame = .init(x: .zero, y: .zero, width: view.frame.width, height: view.frame.height)
        
        view.addSubview(loadingContainerView)
        loadingContainerView.addSubview(loadingView)
        loadingView.play()
        
        loadingContainerView.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
            make.height.equalTo(Appearance.loadingViewHeight)
            make.width.equalTo(Appearance.loadingViewWidth)
        }
        
        loadingView.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
            make.height.equalTo(Appearance.loadingViewHeight)
            make.width.equalTo(Appearance.loadingViewWidth)
        }
        
        UIView.animate(withDuration: Appearance.animationDuration, delay: .zero, options: .curveEaseOut, animations: { [weak self] in
            
            self?.coverView.alpha = Appearance.endAlpha
            self?.loadingContainerView.layoutIfNeeded()
            self?.loadingView.layoutIfNeeded()
        }, completion: .none)
    }
    
    func displayErrorMessage(_ message: String) {
        
        loadingContainerView.subviews.forEach({ $0.removeFromSuperview() })
        
        loadingContainerView.addSubview(errorView)
        
        errorLabel.text = message
        errorImageView.image = UIImage(named: Appearance.errorLogoImageName)?.resizeAndShift(newSize: Appearance.errorLogoImageSize, shiftLeft: .zero, shiftTop: .zero)
        okButton.isHidden = false
                
        loadingContainerView.snp.updateConstraints { update in
            
            update.width.equalTo(view.frame.width * Appearance.expandedContainerViewWidthMultiplier)
            update.height.equalTo(sizeOfErrorView() + Appearance.errorViewHeightOffset)
        }
        
        loadingContainerView.setNeedsLayout()
        
        errorView.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(Appearance.errorViewLeftOffset)
            make.right.equalToSuperview().offset(Appearance.errorViewRightOffset)
        }
        
        UIView.animate(withDuration: Appearance.animationDuration, delay: .zero, options: .curveEaseOut, animations: { [weak self] in
            
            self?.errorView.layoutIfNeeded()
            self?.loadingContainerView.layoutIfNeeded()
        }, completion: .none)
    }
    
    func dismissLoadingView() {
        
        UIView.animate(withDuration: Appearance.animationDuration, delay: .zero, options: .curveEaseOut, animations: { [weak self] in
            
            self?.loadingContainerView.alpha = .zero
            self?.coverView.alpha = .zero
            }, completion: { [weak self] _ in
                
                self?.cleanUpViews()
                self?.toggleButtonEnabledState()
        })
    }
    
    //MARK: - objc funcs for buttons
    @objc func cancelButtonPressed() {
        presenter.cancelButtonPressed()
    }
    
    @objc func sendButtonPressed() {
        
        view.endEditing(true)
        presenter.sendButtonPressed(options: topicTextField.text ?? String(), comment: messageTextView.text)
    }
    
    @objc func okButtonPressed() {
        presenter.manualDismissOfLoadingViewRequested()
    }
    
    @objc func addAttachmentButtonPressed() {
        presenter.didPressAddAttachmentButton()
    }
    
    //MARK: - Misc
    func createPostingRelatedViews() {
        
        //error label
        errorLabel = UILabel()
        errorLabel.textColor = .white
        errorLabel.numberOfLines = Appearance.errorLabelLineNumber
        errorLabel.textAlignment = .center
        
        //okButton
        okButton = UIButton()
        okButton.setTitle(Appearance.okButtonTitle, for: .normal)
        okButton.tintColor = .orangeUi
        okButton.setTitleColor(.orangeUi, for: .normal)
        okButton.setTitleColor(.orangeUiDarker, for: .selected)
        okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        
        //errorView
        errorView = UIStackView()
        errorView.alignment = .center
        errorView.axis = .vertical
        errorView.spacing = Appearance.conatinerSpacing
        
        errorView.addArrangedSubview(errorImageView)
        errorView.addArrangedSubview(errorLabel)
        errorView.addArrangedSubview(okButton)
        
        //loadingContainerView
        loadingContainerView = UIView()
        loadingContainerView.layer.cornerRadius = Appearance.loadingViewCornerRadius
        loadingContainerView.backgroundColor = .darkNavBar
        
        //loadingView
        loadingView = AnimationView()
        loadingView.animation = Animation.named(Appearance.loadingAnimationName)
        loadingView.loopMode = .loop
    }
    
    private func cleanUpViews() {
        
        coverView.removeFromSuperview()
        loadingContainerView.removeFromSuperview()
    }
    
    private func sizeOfErrorView() -> CGFloat {
        
        var res = CGFloat.zero
        res = Appearance.errorLogoImageSize.height +
            Appearance.conatinerSpacing * 2 +
            errorLabel.intrinsicContentSize.height +
            okButton.intrinsicContentSize.height
        
        return res
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func validateCaptcha() {
        
        captcha.validate(on: loadingContainerView) { [weak self] result in
            
            do {
                
                let response = try result.dematerialize()
                
                self?.loadingContainerView.subviews.forEach({ $0.removeFromSuperview() })
                
                if let loadingView = self?.loadingView {
                    
                    self?.loadingContainerView.addSubview(loadingView)
                    self?.loadingView.alpha = Appearance.endAlpha
                    self?.loadingView.play()
                }
                
                self?.loadingContainerView.snp.updateConstraints { update in
                    
                    update.width.equalTo(Appearance.loadingViewWidth)
                    update.height.equalTo(Appearance.loadingViewHeight)
                }
                
                UIView.animate(withDuration: Appearance.animationDuration, delay: .zero, options: .curveEaseOut, animations: { [weak self] in
                    
                    self?.loadingView.alpha = Appearance.endAlpha
                    self?.loadingContainerView.layoutIfNeeded()
                }, completion: .none)
                
                self?.presenter.recaptchaValidated(with: response)
            }
            catch let error {
                self?.presenter.recaptchaHasFailedToValidate(with: error)
            }
        }
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

extension ReplyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ReplyViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage,
            let data = editedImage.pngData() {
            
            presenter.didLoadNewAttachment(PostAttachment(data: data, name: UUID().uuidString))
        }
        else if let originalImage = info[.originalImage] as? UIImage, let data = originalImage.pngData() {
            
            let name = (info[.phAsset] as? PHAsset)?.value(forKey: "filename") as? String ?? UUID().uuidString
            
            presenter.didLoadNewAttachment(PostAttachment(data: data, name: name))
        }
    }
}

extension ReplyViewController: UINavigationControllerDelegate {
    
}
