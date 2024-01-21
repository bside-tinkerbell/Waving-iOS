//
//  SignupViewController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/03.
//

import UIKit
import Combine

final class SignupViewController: UIViewController {

    private var buttonForPreviousStep: WVButton?
    private var buttonForNextStep: WVButton?
    
    lazy private var buttonModelForPreviousStep = WVButtonModel(title: "이전", borderColor: .Border.gray) { [weak self] in
        guard let self else { return }
        let newIndex = max(self.currentSignupStepIndex - 1, 0)
        self.moveToSpecificSignupStep(newIndex)
        self.currentSignupStepIndex = newIndex
    }
    
    lazy private var buttonModelForNextStep = WVButtonModel(title: "다음", titleColor: .Text.text010, backgroundColor: .Text.text090) { [weak self] in
        guard let self else { return }

        self.currentSignupStepViewModel?.nextButtonAction?()
        
        let newIndex = min(self.currentSignupStepIndex + 1, self.collectionViewCellModels.count - 1)
        self.moveToSpecificSignupStep(newIndex)
        self.currentSignupStepIndex = newIndex
    }
    
    private var cancellables = [AnyCancellable]()
    
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.collectionViewFlowLayout)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var collectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        return flowLayout
    }()
    
    lazy private var buttonContainerView: UIView = {
        let containerView = UIView()
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        let buttonForPreviousStep = WVButton()
        buttonForPreviousStep.setup(model: buttonModelForPreviousStep)
        self.buttonForPreviousStep = buttonForPreviousStep
        stackView.addArrangedSubview(buttonForPreviousStep)
        
        let buttonForNextStep = WVButton()
        buttonForNextStep.setup(model: buttonModelForNextStep)
        self.buttonForNextStep = buttonForNextStep
        stackView.addArrangedSubview(buttonForNextStep)
        
        return containerView
    }()
    
    // MARK: - View Models
    private var collectionViewCellModels: [SignupStepViewModel] = []
    
    private var currentSignupStep: SignupStepType = .emailPassword
    
    private var currentSignupStepIndex: Int = 0
    
    private var currentSignupStepViewModel: SignupStepViewModel? {
        didSet {
            bind()
        }
    }
    
    private lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    
    init() {
        self.collectionViewCellModels = [.init(type: .emailPassword),
                                         .init(type: .username),
                                         .init(type: .birthdate),
                                         .init(type: .phoneNumber),
                                         .init(type: .termsOfUse),
                                         .init(type: .complete)]
        self.currentSignupStepViewModel = self.collectionViewCellModels.first
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupView()
        bind()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupView() {
        view.addGestureRecognizer(tapGestureRecognizer)
        
        view.backgroundColor = .white
        
        view.addSubview(buttonContainerView)
        buttonContainerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(buttonContainerView.snp_topMargin)
        }
        
        collectionView.register(SignupStepCollectionViewCell.self, forCellWithReuseIdentifier: "SignupStepCollectionViewCell")
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func bind() {
        currentSignupStepViewModel?.$type
            .sink { [weak self] type in
                guard let self else { return }
                if type == .termsOfUse {
                    view.removeGestureRecognizer(tapGestureRecognizer)
                }
            }
            .store(in: &cancellables)
        
        currentSignupStepViewModel?.route
            .sink { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
        
        currentSignupStepViewModel?.$showPreviousButton
            .sink { [weak self] show in
                guard let self else { return }
                self.buttonForPreviousStep?.isHidden = !show
            }
            .store(in: &cancellables)
        
        currentSignupStepViewModel?.$showNextButton
            .sink { [weak self] show in
                guard let self else { return }
                self.buttonForNextStep?.isHidden = !show
            }
            .store(in: &cancellables)
        
        currentSignupStepViewModel?.$isNextButtonEnabled
            .sink { [weak self] enabled in
                guard let self else { return }
                self.buttonForNextStep?.isEnabled = enabled
            }
            .store(in: &cancellables)
        
    }
    
    func moveToSpecificSignupStep(_ stepIndex: Int, animated: Bool = true) {
        currentSignupStepViewModel = collectionViewCellModels[stepIndex]
        collectionView.setContentOffset(CGPoint(x: self.collectionView.frame.width * CGFloat(stepIndex), y: 0), animated: animated)
    }
}

extension SignupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionViewCellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < collectionViewCellModels.count else { return UICollectionViewCell() }
        
        let cellModel = collectionViewCellModels[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignupStepCollectionViewCell", for: indexPath) as! SignupStepCollectionViewCell
        cell.setup(with: cellModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
}
