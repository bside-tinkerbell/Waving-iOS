//
//  TopTabBarViewController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/25.
//

import UIKit

/// 상단에 Underline Button이 Tab Bar와 같은 역할을 하고 그에 맞춰 여러 Child View Controller들을 보여주고자 할 때 상속받으면
/// TopTabBarRepresentable 프로토콜을 따르는 Child View Controllers를 등록하기만 하면 공통으로 제공되는 UI에 자동으로 AutoLayout을 적용해주는 Container View Controller.
/// 필수 구현 요소 : TopTabBarRepresentable 프로토콜에 있는 (NSString *)underButtonTopTabBarViewController:(UnderlineButtonTopTabBarViewController *)containerViewController title:(NSString *)title 메소드
/// 장점 1. 구현하기 쉽다.
/// 장점 2. Scroll View Paging이 적용된다.
/// 장점 3. 보이지 않는 Child View Controller의 View를 미리 불러오지 않는다. ( 보이는 시점에 viewDidLoad 호출됨 )
final class TopTabBarViewController: UIViewController, UIScrollViewDelegate, TabViewDelegate, SnapKitInterface {
    
    //  Views > Top Buttons
    private lazy var tabView = TabView()
    //  Views > Contents
    private lazy var scrollView = UIScrollView()
    
    var topTabBarHeight: CGFloat = 0.0
    
    /** Objc Interface */
    @objc
    func setInitiallyHideTopButtons(_ hidden: Bool) {
        self.initiallyHideTopButtons = hidden
    }
    @objc
    func setSelectedPageIndex(_ index: Int) {
        self.selectedPageIndex = index
    }
    
    var isHideShadowBottomLine = false
    /// 초기에 상단 탭바를 가릴 경우. ex) 탭 1개로만 subVC를 구성하고, 나중에 subVC를 추가한뒤에 상단 탭바를 보여줌
    var initiallyHideTopButtons = false
    /// View Controller가 로딩될 때 가장 먼저 보이고자 하는 Child View Controller를 index로 결정할 수 있다.
    var selectedPageIndex = 0
    
    private weak var contentView: UIView?
    private var dummyViews: [UIView] = []
    /// Child View Controller의 Life Cycle에 상관 없이 각 탭 바 아이템으로 저장해놓을 뷰 컨트롤러들로, 각 탭에 대응되는 뷰 컨트롤러를 담은 배열
    private var tabBarItems: [UIViewController & TopTabBarRepresentable] = []
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.scrollsToTop = false
        if self.navigationController?.interactivePopGestureRecognizer != nil {
            if let interactivePopGestureRecognizer = self.navigationController?.interactivePopGestureRecognizer {
                self.scrollView.panGestureRecognizer.require(toFail: interactivePopGestureRecognizer)
            }
        }

        self.setups()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        tabView.invalidateEntireLayout()

        DispatchQueue.main.async(execute: {
            self.tabView.scrollToSelectedItem(animated: true, completion: nil)
        })
    }

    /// 필수 초기화 메소드
    /// TopTabBarRepresentable 프로토콜을 따르는 ChildViewControllers를 지정해줌과 동시에 초기화
    /// - Parameter childViewControllers: <NSArray<UIViewController<TopTabBarRepresentable> *> *>
    /// - Returns: instancetype

    // MARK: - Initializer

    init(childViewControllers: [UIViewController & TopTabBarRepresentable]) {
        self.tabBarItems = childViewControllers
        
        self.topTabBarHeight = 48.0
        self.isHideShadowBottomLine = true
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SnapKitInterface
    
    func addComponents() {
        view.addSubview(tabView)
        view.addSubview(scrollView)
    }
    
    func setConstraints() {
        tabView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(topTabBarHeight)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(tabView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Views

    func setups() {
        addComponents()
        setConstraints()
        
        self.view.backgroundColor = .white

        self.setupTopTabBarButtons()
        self.setupScrollContentView()

        if self.tabBarItems.count - 1 < self.selectedPageIndex {
            self.selectedPageIndex = self.tabBarItems.count - 1
        }

        self.tabView.style = .Tier2
        self.tabView.selectItem(at: tabViewIndexPath(forItem: selectedPageIndex), animated: true)
    }

    func setupTopTabBarButtons() {
        self.tabView.delegate = self

        var cellViewModels: [TabViewCollectionViewCellModelWrapper] = []

        for (idx, viewController) in tabBarItems.enumerated() {
            cellViewModels.append(TabViewCollectionViewCellModelWrapper(nameText: viewController.underlineButtonTopTabBarTitle()))

            viewController.setChangingTitleBlock?({ [weak self] navigationTitle in
                self?.title = navigationTitle
            })
            
            viewController.setChangingCurrentBarTitleBlock?({ [weak self] tapTitle in
                guard let self = self else { return }
                let updatedModel = TabViewCollectionViewCellModelWrapper(nameText: tapTitle)
                self.tabView.updateItem(with: updatedModel, at: self.tabViewIndexPath(forItem: idx))
            })
            
            viewController.setChangingAllTitleBlock?({ [weak self] barTitles in
                guard let self = self else { return }
                for (innerIndex, barTitle) in barTitles.enumerated() {
                    let updatedModel = TabViewCollectionViewCellModelWrapper(nameText: barTitle)
                    self.tabView.updateItem(with: updatedModel, at: self.tabViewIndexPath(forItem: innerIndex))
                }
            })
        }

        self.tabView.setupViewModel(with: TabViewModelWrapper(with: cellViewModels))

    }

    func setupScrollContentView() {
        if self.contentView != nil {
            self.contentView?.removeFromSuperview()
            self.contentView = nil
        }
        let contentView = UIView()
        self.scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalTo(scrollView)
        }
        self.contentView = contentView
        self.setupScrollDummyViews()
    }

    /// Lazy Loading을 위해 미리 Scroll View의 최대 Content Size만큼 Dummy View들로 채워놓는다.
    func setupScrollDummyViews() {
        var dummyViews: [UIView] = []
        guard let contentView = self.contentView else { return }
        for idx in self.tabBarItems.indices {
            let dummyView = UIView()
            dummyViews.append(dummyView)

            contentView.addSubview(dummyView)
            dummyView.translatesAutoresizingMaskIntoConstraints = false

            if idx == 0 {
                dummyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            } else {
                dummyView.leadingAnchor.constraint(equalTo: dummyViews[idx - 1].trailingAnchor).isActive = true
            }
            dummyView.snp.makeConstraints {
                $0.top.bottom.equalTo(contentView)
            }
            dummyView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            dummyView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        }
        
        if let last = dummyViews.last {
            contentView.addConstraint(last.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        }
        
        self.dummyViews = dummyViews
    }

    /// 보여주고자하는 View가 아직 Loading되지 않았을 경우 Loading 및 Layout 적용
    func setupLayoutConstraints(withViewController viewController: UIViewController & TopTabBarRepresentable) {
        guard let view = viewController.view else { return }
        guard let pageIndex = tabBarItems.firstIndex(where: { $0 == viewController }) else { return }
        guard let containerDummyView = dummyViews.wv_get(index: pageIndex) else { return }
        if view.superview != containerDummyView {
            view.removeFromSuperview()
            self.addChild(viewController)
            containerDummyView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview()
            }
            viewController.didMove(toParent: self)
        }
    }


    func tabViewIndexPath(forItem item: Int) -> IndexPath {
        return IndexPath(item: item, section: 0)
    }

    /// 인덱스에 해당하는 아이템을 갱신한다.
    func reloadItem(at index: Int) {
        guard let tabBarItem = tabBarItems.wv_get(index: index) else { return }
        tabBarItem.reload?()
    }

    /// 인덱스에 해당하는 아이템의 타이틀을 변경한다.
    func changeItemTitle(_ title: String, at index: Int) {
        let cellModelWrapper = TabViewCollectionViewCellModelWrapper(nameText: title)
        self.tabView.updateItem(with: cellModelWrapper, at: tabViewIndexPath(forItem: index))
    }

    /// 동적으로 탭바를 추가할 경우

    // MARK: - Interfaces

    func addTabBarItem(_ item: UIViewController & TopTabBarRepresentable) {
        var items = self.tabBarItems
        items.append(item)
        self.tabBarItems = items

        // 새로운 탭바 아이템을 추가한 뒤에, setups 프로세스 다시 진행
        self.setups()
    }

    // MARK: - UIScrollViewDelegate

    /// 제스처를 이용할 경우, 보여질 수 있는 뷰를 미리 파악해서 Loading
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewWidth = scrollView.frame.width
        let currentContentOffsetX = scrollViewWidth * CGFloat(selectedPageIndex)
        var nextPageIndex = selectedPageIndex

        if currentContentOffsetX > scrollView.contentOffset.x {
            //  왼쪽으로 스크롤
            nextPageIndex = Int(scrollView.contentOffset.x / scrollViewWidth)
        } else if scrollView.contentOffset.x > currentContentOffsetX && scrollView.contentOffset.x < currentContentOffsetX + scrollViewWidth {
            //  오른쪽으로 스크롤
            nextPageIndex = Int(scrollView.contentOffset.x / scrollViewWidth + 1)
        }

        guard let childViewController = tabBarItems.wv_get(index: nextPageIndex) else { return }
        self.setupLayoutConstraints(withViewController: childViewController)
    }

    /// 정확한 ContentOffset을 얻어서 그 값으로 pageIndex 처리
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let destinationIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        changeChildViewControllerOf(destinationIndex)

        let indexPath = tabViewIndexPath(forItem: destinationIndex)
        tabView.updateItemSelectedState(with: indexPath)
        tabView.scrollToItem(at: indexPath, animated: true, completion: nil)
    }

    // MARK: - Rotate

    /// 화면 회전 시, Scroll View의 Content Offset이 이상하게 작동할 수 있는 것 방지
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.setScrollViewContentOffsetIfNeeded()
        })
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.tabView.invalidateEntireLayout()
        self.setScrollViewContentOffsetIfNeeded()
    }

    func setScrollViewContentOffsetIfNeeded() {
        let contentOffset = self.pointOfViewController(with: selectedPageIndex)
        if self.scrollView.contentOffset.x != contentOffset.x {
            self.scrollView.contentOffset = contentOffset
        }
    }
    
    func changeChildViewControllerOf(_ index: Int) {
        self.selectedPageIndex = index

        for childViewController in self.children {
            guard let child = childViewController as? (UIViewController & TopTabBarRepresentable) else { continue }
            if let firstIndex = self.tabBarItems.firstIndex(where: { $0 == child }), firstIndex == index {
                child.didMove(toParent: self)
            } else {
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        }
    }

    /// tab을 tap 했을 때 호출해야 하는 메서드

    // MARK: - Button Action

    func touchUpInsideTopTabBarButton(with index: Int) {
        self.selectTopTabBarButton(at: index)
    }

    // MARK: - Private
    
    private func pointOfViewController(with index: Int) -> CGPoint {
        let scrollViewFrame = self.scrollView.frame

        return CGPoint(x: CGFloat(index) * scrollViewFrame.width, y: 0)
    }

    private func selectTopTabBarButton(at index: Int) {
        guard let childViewController = tabBarItems.wv_get(index: index) else { return }
        self.setupLayoutConstraints(withViewController: childViewController)

        //  초기에 0번 index가 아닌 다른 index를 보이려 할 때 0번 index가 아니면 ScrollView의 ContentOffSet을 제대로 잡지 못하는 이슈 해결을 위해
        DispatchQueue.main.async(execute: {
            self.scrollView.setContentOffset(self.pointOfViewController(with: index), animated: false)
        })

        self.changeChildViewControllerOf(index)
    }

    private func setTransitionEnabled(_ isEnabled: Bool) {
        self.scrollView.isScrollEnabled = isEnabled
    }

    /// childViewController 중 하나라도 다크모드를 지원하지 않으면 라이트 모드로 고정하는데 사용
    private func isSupportOverrideUserInterfaceStyle(_ childViewControllers: [UIViewController]) -> Bool {
        var isSupport = true
        for childViewController in childViewControllers {
            if childViewController.overrideUserInterfaceStyle == .light {
                isSupport = false
                break
            }
        }

        return isSupport
    }

    // MARK: - TabViewDelegate

    func tabView(_ tabView: TabView, didSelectItemAt indexPath: IndexPath) {
        self.reloadItem(at: self.selectedPageIndex)
        self.touchUpInsideTopTabBarButton(with: indexPath.item)
    }
}

@objc
protocol TopTabBarRepresentable: NSObjectProtocol {
    /// 최초 childViewController가 실행이 될 때 Underline Top Tab Bar 버튼의 Title Label Text에 해당하는 문자열을 반환하는 메소드
    func underlineButtonTopTabBarTitle() -> String

    /// 최초 childViewcontroller가 실행이 될 때 들어가는 navigationTitle
    /// - Returns: 네비게이션 타이틀
    @objc
    optional func parentViewNavigationTitle() -> String
    /// 최초 childViewcontroller가 실행이 될 때 들어가는 navigationSubtitle
    /// - Returns: 네비게이션 서브타이틀
    @objc
    optional func parentViewNavigationSubtitle() -> String?
    /// - Returns: 네비게이션 오른쪽 버튼
    @objc
    optional func parentRightButton() -> UIButton?
    /// child viewController에서 동적으로 navigation title을 변경해야 할 때 사용
    /// - Parameter changingTitleBlock: title을 변경하는 경우 호출해야 하는 block (string이 nil이면 변경하지 않는다.)
    @objc
    optional func setChangingTitleBlock(_ changingTitleBlock: @escaping (String) -> Void)
    /// 현재의 tab의 title만 변경할 때 사용하는 block을 viewController에 주입한다.
    /// - Parameter changingCurrentBarTitleBlock: 현재 tab의 title을 변경할 때 사용한다.
    @objc
    optional func setChangingCurrentBarTitleBlock(_ changingCurrentBarTitleBlock: @escaping (String) -> Void)
    /// 탭 전체의 title을 변경할 때 사용한다. NSArray<NSString *>의 형태이고 순서는 tab의 순서와 같아야 한다.
    /// - Parameter changingAllTitleBlock: 모든 탭의 제목을 변경하는 block
    @objc
    optional func setChangingAllTitleBlock(_ changingAllTitleBlock: @escaping ([String]) -> Void)
    
    @objc
    optional func reload()
    // MARK: - Delete Mode

    /// 삭제 권한이 있는지 확인
    /// - Returns: 삭제 권한
    @objc
    optional func isPermittedDeletion() -> Bool
    /// Contents Delete Mode로 진입할 때 알림
    /// - Parameter viewController: UnderlineButtonTopTabBarViewController
    @objc
    optional func didEnterContentsDeleteMode(_ viewController: TopTabBarViewController)
    @objc
    optional func didExitContentsDeleteMode(_ viewController: TopTabBarViewController)
    /// 삭제가 진행될 예정임을 알림
    /// - Parameter viewController: UnderlineButtonTopTabBarViewController
    @objc
    optional func willDeleteContents(_ viewController: TopTabBarViewController)
    /// 삭제 가능한 컨텐츠 유무에 따라 삭제 버튼의 상태를 변경할 때 사용한다.
    /// - Parameter changingHasDeletableContentsBlock: 삭제 가능한 컨텐츠 유무에 따라 삭제 상태를 변경하는 블록
    @objc
    optional func setChangingHasDeletableContentsBlock(_ changingHasDeletableContentsBlock: @escaping (_ hasDeletableContents: Bool) -> Void)
    /// Child View Controller로부터 삭제 진행이 완료됐음을 받을 때 사용할 블록 세팅
    /// - Parameter didDeleteContentsBlock: 삭제 진행이 완료됐음을 알리는 블록
    @objc
    optional func setDidDeleteContentsBlock(_ didDeleteContentsBlock: @escaping (_ isSuccess: Bool) -> Void)
    /// 우상단의 삭제 버튼 Bubble Count를 변경할 때 사용한다.
    /// - Parameter changingDeletableContentsButtonCountBlock: 우상단의 삭제 버튼 Bubble Count를 변경하는 Block
    @objc
    optional func setChangingDeletableContentsButtonCountBlock(_ changingDeletableContentsButtonCountBlock: @escaping (Int) -> Void)
    // MARK: - Select Mode
    @objc
    optional func didSelectMultiBands(_ viewController: TopTabBarViewController)
    @objc
    optional func setChangingSelectedBandsButtonCountBlock(_ changingSelectedBandsButtonCountBlock: @escaping (Int) -> Void)
    @objc
    optional func willChangeSelectedTab(_ viewController: TopTabBarViewController)
    // GroupCall
    @objc
    optional func updateGroupCallMemberSelectionBlock(_ memberSelctionCountBlock: @escaping (Int) -> Void)
    @objc
    optional func updateGroupCallChannelSelectionBlock(_ channelSelctionBlock: @escaping (_ isSelected: Bool) -> Void)
    @objc
    optional func didSelectGroupCallTargetSelection()
}

extension TopTabBarViewController {
    
    static func makeGreetingListViewController() -> TopTabBarViewController {
        // test code
        // TODO: api 호출
        let categoryNames = ["명언/명대사", "고마워요", "응원해요"]
        // end of test code
        
        var childViewControllers = [UIViewController & TopTabBarRepresentable]()
        for name in categoryNames {
            childViewControllers.append(GreetingListViewController(categoryName: name))
        }
        
        let topTabBarViewController = TopTabBarViewController(childViewControllers: childViewControllers)
        return topTabBarViewController
    }
}
