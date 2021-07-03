//
//  MyPageViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/02.
//

import SnapKit
import UIKit

enum menuStatus: Int {
    case myWriting = 0
    case myReward = 1
    case MyTrashBin = 2
}

class MyPageViewController: UIViewController {
    
    // MARK: - UIComponenets
    
    private lazy var myPageMenuCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white

        collectionView.register(MyPageMenuCollectionViewCell.self, forCellWithReuseIdentifier: MyPageMenuCollectionViewCell.identifier)
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .right)

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
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .right)

        collectionView.register(MenuSectionCollectionViewCell.self, forCellWithReuseIdentifier: MenuSectionCollectionViewCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()
    
    // MARK: - Properties
    
    var label = UILabel()
    var indicatorLayoutConstraint : [NSLayoutConstraint] = []

    let menu = ["글", "리워드", "휴지통"]
    let subViewControllers: [UIViewController] = [MyWritingViewController(), MyRewardViewController(), MyTrashBinViewController()]
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        setConstraint()
        collectionView(myPageMenuCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        
        
        
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    
    func setCollectionView() {
        collectionView(myPageMenuCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
    }

    func setConstraint() {
        let views: [UIView] = [myPageMenuCollectionView, indicatorBarView, menuSectionCollectionView]
        views.forEach { v in
            view.addSubview(v)
        }

        let labelSize = calcLabelSize(text: menu[0])
        print(labelSize)
        
        myPageMenuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }

        indicatorBarView.snp.makeConstraints { make in

            make.top.equalTo(myPageMenuCollectionView.snp.bottom)
            make.height.equalTo(3)

            print("초기 레이아웃 설정")

        }

        menuSectionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(indicatorBarView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.sizeToFit()

        return label.bounds.size
    }

    func scrollToMenu(to index: Int) {
        menuSectionCollectionView.selectItem(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .right)
    }
}
    
    // MARK: - Protocols
    


    // MARK: - Extensions

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == myPageMenuCollectionView {
            return 20
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == myPageMenuCollectionView {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        return .zero
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = menu[indexPath.row]
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.sizeToFit()

        if collectionView == myPageMenuCollectionView {
            return CGSize(width: label.bounds.width + 30, height: 56)
        }
        let height = UIScreen.main.bounds.height - (myPageMenuCollectionView.contentSize.height + 5)
        return CGSize(width: UIScreen.main.bounds.width, height: height)
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
                myPageMenuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
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
            
            self.view.addSubview(indicatorBarView)
            
    
            guard let cell = myPageMenuCollectionView.cellForItem(at: indexPath) as? MyPageMenuCollectionViewCell else {
                return }
                                          
            indicatorBarView.translatesAutoresizingMaskIntoConstraints = false
            
            updateViewConstraints()
            NSLayoutConstraint.deactivate(indicatorLayoutConstraint)
            indicatorLayoutConstraint = [ indicatorBarView.leadingAnchor.constraint(equalTo:
                                                                                        cell.leadingAnchor , constant: 10),
                                          indicatorBarView.trailingAnchor.constraint(equalTo:
                                                                                        cell.trailingAnchor, constant: -10),
                                          indicatorBarView.topAnchor.constraint(equalTo: cell.bottomAnchor),
                                          ]
            
            NSLayoutConstraint.activate(indicatorLayoutConstraint)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded() }
            
            menuSectionCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

        }
    }
    
}

extension MyPageViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x)
        
        if scrollView.contentOffset.x > 375 {
            
        }
        //..menu.indicatorLeadingConstarint.constant = scrollView.contentOffset.x / 3
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let idx = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        scrollToMenu(to: idx)
        print("ㅜㅇ왕부왕ㅂ우보앙")
    }
}
