//
//  TabView.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/25.
//

import UIKit

public class TabView: UIView {
    
    // MARK: - Properties
    
    private var collectionView: UICollectionView!
    public var bottomSeparatorView: UIView!
    
    public var style: TabViewStyle = .Legacy(nil) {
        didSet {
            if oldValue != self.style {
                self.adjustViewState()
                self.collectionView.reloadData()
            }
        }
    }
    
    /// 탭뷰 스타일 적용 - 컴포넌트 상단탭 컴포넌트가 적용되지 않은 영역
    @objc
    public func setTierStyle(color: UIColor?) {
        self.style = .Tier1(color)
    }
    
    public var viewModel: TabViewModel? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    /// 탭뷰 아이템 활성화 여부
    public var isEnabled: Bool = false {
        didSet {
            self.collectionView.isUserInteractionEnabled = isEnabled
            self.viewModel?.cellViewModels.forEach { $0.isEnabled = isEnabled }
            self.collectionView.reloadData()
        }
    }
    
    @objc
    public weak var delegate: TabViewDelegate?
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: self.style.defaultHeight)
    }
    
    // MARK: - Initializers
    
    public convenience init(style: TabViewStyle = .Legacy(nil)) {
        self.init(frame: .zero)
        self.style = style
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initViews()
        self.initDefaultConstraints()
        self.setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initViews()
        self.initDefaultConstraints()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.collectionView.reloadData()
    }

    // MARK: - Public
    
    @objc
    public func selectItem(at indexPath: IndexPath?, animated: Bool = true) {
        guard self.numberOfItems() > 0 else { return }
        
        var indexPathForSelectedItem = IndexPath(item: 0, section: 0)
        
        if let indexPath = indexPath, (indexPath.item < self.numberOfItems()) {
            
            indexPathForSelectedItem = indexPath
            
        }
        
        self.updateItemSelectedState(with: indexPathForSelectedItem)
        self.didSelectItem(at: indexPathForSelectedItem, animated: animated)
    }
    
    @objc
    public func setupViewModel(with modelWrapper: TabViewModelWrapper) {
        self.viewModel = TabViewModel(with: modelWrapper.cellViewModels)
    }
    
    public func updateItem(with cellViewModel: TabViewCollectionViewCellModel, at indexPath: IndexPath) {
        let indexPathForSelectedItem = self.indexPathForSelectedItem()
        
        self.viewModel?.cellViewModels.wv_replaced(with: cellViewModel, at: indexPath.item)
        
        DispatchQueue.main.async { [weak self] in
            self?.updateItemSelectedState(with: indexPathForSelectedItem)
        }
    }
    
    @objc
    public func updateItem(with cellViewModelWrapper: TabViewCollectionViewCellModelWrapper, at indexPath: IndexPath) {
        self.updateItem(with: cellViewModelWrapper.model, at: indexPath)
    }
    
    /// 탭메뉴 중 선택한 아이템의 indexPath를 반환
    public func indexPathForSelectedItem() -> IndexPath? {
        guard let viewModel = self.viewModel,
              let selectedIndex = viewModel.cellViewModels.firstIndex(where: { $0.isSelected }),
              selectedIndex < numberOfItems() else {
            return nil
        }
        
        return IndexPath(item: selectedIndex, section: 0)
    }
    
    @objc
    public func updateItemSelectedState(with indexPathForSelectedItem: IndexPath?) {
        guard let indexPathForSelectedItem = indexPathForSelectedItem else { return }
        self.viewModel?.cellViewModels.forEach { $0.isSelected = false }
        self.viewModel?.cellViewModels[indexPathForSelectedItem.item].isSelected = true
        self.collectionView.reloadData()
        self.collectionView.performBatchUpdates { [weak self] in
            self?.collectionView.selectItem(at: indexPathForSelectedItem, animated: false, scrollPosition: [])
        }
    }
    
    @objc
    public func scrollToItem(at indexPath: IndexPath, animated: Bool, completion: (() -> Void)?) {
        if animated {
            
            UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
                
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                
            }) { _ in
                
                completion?()
                
            }
            
        } else {
            
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            completion?()
            
        }
    }
    
    @objc
    public func scrollToSelectedItem(animated: Bool, completion: (() -> Void)?) {
        
        guard let indexPathForSelectedItem = self.indexPathForSelectedItem() else { return }
        
        self.scrollToItem(at: indexPathForSelectedItem, animated: animated, completion: completion)
        
    }
    
    @objc
    public func invalidateEntireLayout() {
        
        self.collectionView.collectionViewLayout.invalidateLayout()
        
    }
    
    @objc
    public func reloadData() {
        self.collectionView.reloadData()
    }
    
    // MARK: - Private
    
    private func initViews() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        
        self.bottomSeparatorView = UIView(frame: .zero)
        self.bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.bottomSeparatorView)
        
        self.collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.collectionView)
    }
    
    private func initDefaultConstraints() {
        
        NSLayoutConstraint.activate([
            self.bottomSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            self.bottomSeparatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomSeparatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomSeparatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.topAnchor.constraint(equalTo: self.collectionView.topAnchor),
            self.leadingAnchor.constraint(equalTo: self.collectionView.leadingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
    
    private func setupViews() {
        
        self.collectionView.contentInsetAdjustmentBehavior = .never
        
        self.collectionView.backgroundColor = .clear
        self.collectionView.contentInset = .zero
        self.collectionView.scrollsToTop = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.allowsMultipleSelection = false
        
        collectionView.register(TabViewCollectionViewCell.self, forCellWithReuseIdentifier: "TabViewCollectionViewCell")

        self.adjustViewState()
        
    }
    
    private func numberOfItems() -> Int {
        return (self.viewModel?.cellViewModels.count ?? 0)
    }
    
    private func didSelectItem(at indexPath: IndexPath, animated: Bool) {
        
        self.scrollToItem(at: indexPath, animated: animated) { [weak self] in
            
            guard let self else { return }
            
            self.delegate?.tabView?(self, didSelectItemAt: indexPath)
            
        }
    }
    
    private func adjustViewState() {
        self.backgroundColor = self.style.backgroundColor
        self.bottomSeparatorView.backgroundColor = self.style.bottomSeparatorViewColor
    }
}

// MARK: - UICollectionViewDataSource

extension TabView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItems()
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabViewCollectionViewCell", for: indexPath) as! TabViewCollectionViewCell
        cell.style = self.style.cellStyle
        guard let cellViewModel = self.viewModel?.cellViewModels.wv_element(at: indexPath.item) else { return cell }
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension TabView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel?.cellViewModels.forEach { $0.isSelected = false }
        self.viewModel?.cellViewModels.wv_element(at: indexPath.item)?.isSelected = true
        self.collectionView.reloadData()
        self.collectionView.performBatchUpdates { [weak self] in
            self?.didSelectItem(at: indexPath, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TabView: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItems = self.numberOfItems()
        guard numberOfItems > 0 else { return .zero }
        guard let cellViewModel = self.viewModel?.cellViewModels.wv_element(at: indexPath.item) else { return .zero }
        
        // 폰트에 따른 문자열의 너비와 최소 리딩 마진 및 최소 트레일링 마진의 합을 계산한다.
        var itemWidth = (self.style.cellStyle.nameLabelMinimumLeadingMargin + self.style.cellStyle.nameLabelMinimumTrailingMargin)
        itemWidth += self.style.cellStyle.attributedName(cellViewModel.name, isSelectedState: cellViewModel.isSelected, isEnabledState: cellViewModel.isEnabled).size().width.rounded(.up)
        
        var totalWidth = collectionView.bounds.width
        if self.traitCollection.horizontalSizeClass == .compact {
            totalWidth -= (self.style.compactInsetForSection.left + self.style.compactInsetForSection.right)
        } else {
            totalWidth -= (self.style.regularInsetForSection.left + self.style.regularInsetForSection.right)
        }
        
        // Compact 일때, 아이템 총 합 길이가 collectionView 보다 작으면 스크롤, 크면 1/n
        if self.traitCollection.horizontalSizeClass == .compact {
            if totalWidth > itemWidth * CGFloat(numberOfItems) {
                itemWidth = totalWidth / CGFloat(numberOfItems)
            }
        }
        
        // Compact 이고 아이템 총합 길이가 collectionView 보다 크거나, Regluar 일때 나열 후 스크롤
        return CGSize(width: itemWidth, height: collectionView.bounds.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return self.style.minimumLineSpacing
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return self.style.minimumInteritemSpacing
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if self.traitCollection.horizontalSizeClass == .compact {
            return self.style.compactInsetForSection
        } else {
            return self.style.regularInsetForSection
        }
    }

}

@objc
public protocol TabViewDelegate {
    
    @objc
    optional func tabView(_ tabView: TabView, didSelectItemAt indexPath: IndexPath)
    
}
