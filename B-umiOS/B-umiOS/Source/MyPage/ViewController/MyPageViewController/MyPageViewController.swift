//
//  MyPageViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/02.
//

import SnapKit
import UIKit

enum MenuStatus: Int {
    case myWriting = 0
    case myReward = 1
}

class MyPageViewController: UIViewController {
    // MARK: - UIComponenets

    lazy var myPageMenuCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white

        collectionView.register(MyPageMenuCollectionViewCell.self, forCellWithReuseIdentifier: MyPageMenuCollectionViewCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    var indicatorBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue2Main

        return view
    }()
    
    let navigationDividerView = UIView().then {
        $0.backgroundColor = .paper1
    }

    lazy var menuSectionCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .background
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(MenuSectionCollectionViewCell.self, forCellWithReuseIdentifier: MenuSectionCollectionViewCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    var label = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
    }

    // MARK: - Properties

    let menu = ["글", "리워드"]
    let subViewControllers: [UIViewController] = [MyWritingViewController(), MyRewardViewController()]
    let myPageMenuCellLineSpacing: CGFloat = 39.0
    
    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraints()
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadCollectionView()
    }


    // MARK: - Actions

    // MARK: - Methods
    
    func reloadCollectionView() {
        menuSectionCollectionView.reloadData()
    }

    func setCollectionView() {
        myPageMenuCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .init())
        collectionView(myPageMenuCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
    }

    func wrapAndGetCell(viewColtroller: UIViewController, cell: MenuSectionCollectionViewCell) -> MenuSectionCollectionViewCell {
        viewColtroller.view.tag = MenuSectionCollectionViewCell.SUBVIEW_TAG
        cell.contentView.addSubview(viewColtroller.view)

        /// 다른 UIViewController, PageViewController 등의 컨테이너 뷰컨에서 다른 UIViewController가 추가, 삭제된 후에 호출된다.
        /// 인자로 부모 뷰컨을 넣어서 호출해줌..
        /// 자식 뷰컨이 부모 뷰컨으로부터 추가, 삭제되는 상황에 반응할 수 있도록.

        viewColtroller.didMove(toParent: self)
        return cell
    }

    func calcLabelSize(text: String) -> CGSize {
        label.text = text
        label.sizeToFit()

        return label.bounds.size
    }

    func scrollToMenu(to index: Int) {
        myPageMenuCollectionView.selectItem(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .init())
        collectionView(myPageMenuCollectionView, didSelectItemAt: IndexPath(row: index, section: 0))
    }
}

// MARK: - Protocols
