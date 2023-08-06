//
//  CycleViewController.swift
//  Waving-iOS
//
//  Created by Joy on 2023/08/05.
//

import UIKit

final class CycleViewController: UIViewController, SnapKitInterface {
    
    private lazy var navigationViewModel: NavigationModel = .init(backButtonImage: UIImage(named: "icn_back"), forwaredButtonText: "건너뛰기", title: "알림설정", didTouchBack: { [weak self] in
        self?.navigationController?.popToRootViewController(animated: true)
    })
    
    private lazy var navigationView: NavigationView = {
        let view = NavigationView()
        view.setup(model: navigationViewModel)
        return view
    }()
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 타이틀
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let titleNameLabl: UILabel = {
       let label = UILabel()
        label.font = .p_B(24)
        label.text = "OO님과 연락주기를"
        return label
    }()
    
    private let titleSettingLabel: UILabel = {
       let label = UILabel()
        label.font = .p_B(24)
        label.text = "설정해 주세요."
        return label
    }()
    
    // 서브 타이틀
    private let subTitleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.text = "연락 주기는 나의 지인 페이지에서\n변경할 수 있어요."
        label.font = .p_R(16)
        label.textColor = .text050
        return label
    }()
    
    // 반복 주기 정하는 HStack
    private lazy var cycleStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 22
        return stackView
    }()
    
    private lazy var cycleTextStackView: UIStackView = {
       let textStackView = UIStackView()
        textStackView.alignment = .center
        
        let cycleLabel: UILabel = {
            let label = UILabel()
            label.text = "반복 주기"
            label.textColor = UIColor(hex: "1B1B1B")
            label.font = .p_R(18)
            return label
        }()
        
        textStackView.addArrangedSubview(cycleLabel)
        
        return textStackView
    }()
    
    private lazy var cycleNumStackView: UIStackView = { //TODO: GestureRecognizer 추가 필요
        let numStackView = UIStackView()
        numStackView.layer.cornerRadius = 8
        numStackView.backgroundColor = .main010
        numStackView.alignment = .center
        numStackView.snp.makeConstraints {
            $0.width.equalTo(147)
        }
        return numStackView
    }()
    
    private let cycleNumLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.textColor = .text090
        label.font = .p_B(20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cycleUnitStackView: UIStackView = {
       let textStackView = UIStackView()
        textStackView.alignment = .center
        
        let cycleLabel: UILabel = {
            let label = UILabel()
            label.text = "주 마다"
            label.textColor = UIColor(hex: "1B1B1B")
            label.font = .p_R(18)
            return label
        }()
        
        textStackView.addArrangedSubview(cycleLabel)
        
        return textStackView
    }()
    
    private let nextContactLabel: UILabel = {
       let label = UILabel()
        label.text = "다음 연락일은 2023.09.24(목)입니다."
        label.textAlignment = .center
        label.textColor = .gray090
        label.font = .p_R(18)
        
        let attributedString = NSMutableAttributedString(string: label.text!)
        attributedString.wv_setFont(.p_B(18), range: (label.text! as NSString).range(of: "2023.09.24(목)"))
        label.attributedText = attributedString
        return label
    }()

    private let completedButton = WVButton()
    private lazy var completedButtonViewModel = WVButtonModel(title: "완료", titleColor: .Text.white, backgroundColor: .Button.blackBackground) { [weak self] in
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
        setConstraints()
        binding()
    }
    
    func addComponents() {
        view.backgroundColor = .systemBackground
        [navigationView, containerView].forEach { view.addSubview($0) }
        [titleStackView, subTitleLabel, cycleStackView, nextContactLabel, completedButton].forEach { containerView.addSubview($0) }
        [titleNameLabl, titleSettingLabel].forEach { titleStackView.addArrangedSubview($0) }
        cycleNumStackView.addArrangedSubview(cycleNumLabel)
        [cycleTextStackView, cycleNumStackView, cycleUnitStackView].forEach { cycleStackView.addArrangedSubview($0) }
    }
    
    func setConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(16)
            $0.left.right.bottom.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints {
            $0.top.equalTo(containerView)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.height.equalTo(64)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.height.equalTo(48)
        }
        
        cycleStackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(102)
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
            $0.height.equalTo(54)
        }
        
        nextContactLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(completedButton.snp.top).offset(-16)
        }

        completedButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        
        completedButton.setup(model: completedButtonViewModel)
    }
    
    func binding() {
        
    }
    
}
