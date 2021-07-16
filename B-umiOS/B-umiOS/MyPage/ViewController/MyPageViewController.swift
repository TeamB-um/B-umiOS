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
    case MyTrashBin = 2
}

class MyPageViewController: UIViewController {
    // MARK: - UIComponenets

    private lazy var myPageMenuCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white

        collectionView.register(MyPageMenuCollectionViewCell.self, forCellWithReuseIdentifier: MyPageMenuCollectionViewCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    private var indicatorBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue2Main

        return view
    }()

    private lazy var menuSectionCollectionView: UICollectionView = {
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

    let menu = ["글", "리워드", "삭제함"]
    let subViewControllers: [UIViewController] = [MyWritingViewController(), MyRewardViewController(), MyTrashBinViewController()]
    let myPageMenuCellLineSpacing: CGFloat = 39.0
    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraint()
        setCollectionView()
    }

    // MARK: - Actions

    // MARK: - Methods

    func setCollectionView() {
        myPageMenuCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .init())
        collectionView(myPageMenuCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
    }

    func setConstraint() {
        view.addSubviews([myPageMenuCollectionView, indicatorBarView, menuSectionCollectionView])

        let labelSize = calcLabelSize(text: menu[0])

        myPageMenuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(labelSize.height + 26)
        }

        indicatorBarView.snp.makeConstraints { make in
            make.top.equalTo(myPageMenuCollectionView.snp.bottom)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(myPageMenuCellLineSpacing)
            make.width.equalTo(labelSize.width + 10)
            make.height.equalTo(3)
        }

        menuSectionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(indicatorBarView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
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

// MARK: - Extensions

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == myPageMenuCollectionView {
            return 26
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == myPageMenuCollectionView {
            return UIEdgeInsets(top: 0, left: myPageMenuCellLineSpacing, bottom: 0, right: 0)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = calcLabelSize(text: menu[indexPath.row])

        if collectionView == myPageMenuCollectionView {
            return CGSize(width: size.width + 10, height: size.height + 26)
        }
        let height = UIScreen.main.bounds.height - (size.height + 26 + 3 + view.safeAreaInsets.top)
        return CGSize(width: UIScreen.main.bounds.width, height: floor(height))
    }
}

extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuSectionCollectionView {
            return menu.count
        }
        return subViewControllers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case myPageMenuCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageMenuCollectionViewCell.identifier, for: indexPath) as? MyPageMenuCollectionViewCell else { return UICollectionViewCell() }

            if indexPath.row == 0 {
                cell.isSelected = true
            } else {
                cell.isSelected = false
            }

            cell.setCell(menu: menu[indexPath.row])

            return cell

        case menuSectionCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuSectionCollectionViewCell.identifier, for: indexPath) as? MenuSectionCollectionViewCell
            else { return UICollectionViewCell() }
            let sectionVC = subViewControllers[indexPath.row]

            return wrapAndGetCell(viewColtroller: sectionVC, cell: cell)

        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == myPageMenuCollectionView {
            menuSectionCollectionView.isPagingEnabled = false
            menuSectionCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            menuSectionCollectionView.isPagingEnabled = true

            guard let cell = myPageMenuCollectionView.cellForItem(at: indexPath) as? MyPageMenuCollectionViewCell else {
                return
            }

            indicatorBarView.snp.remakeConstraints { make in
                make.top.equalTo(cell.snp.bottom)
                make.leading.equalTo(cell.snp.leading)
                make.width.equalTo(cell.snp.width)
                make.height.equalTo(3)
            }

            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension MyPageViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 375 {}
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let idx = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        scrollToMenu(to: idx)
    }
}
