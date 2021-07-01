//
//  FloatingTabBarController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/01.
//

import UIKit

class FloatingTabBarController: UITabBarController {
    // MARK: - UIComponenets
    
    // MARK: - Properties

    private let tabBarItems: [String] = ["btnDisableHome", "btnDisableCollection", "btnDisableMywriting", "btnDisableSetting"]
    lazy var floatingTabbarView = FloatingBarView(tabBarItems)
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarController()
        setFloatingTabBarView()
        setConstraint()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func createNavigationController(viewController: UIViewController) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        
        return navigationController
    }
    
    func setTabBarController() {
        let homeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "HomeViewController")
        let separateViewController = UIStoryboard(name: "Separate", bundle: nil).instantiateViewController(identifier: "SeparateViewController")
        let myPageViewController = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(identifier: "MyPageViewController")
        let settingViewController = UIStoryboard(name: "Setting", bundle: nil).instantiateViewController(identifier: "SettingViewController")
        
        viewControllers = [createNavigationController(viewController: homeViewController), createNavigationController(viewController: separateViewController), myPageViewController, createNavigationController(viewController: settingViewController)]
        
        tabBar.isHidden = true
    }
    
    func setFloatingTabBarView() {
        floatingTabbarView.delegate = self
    }
    
    func setConstraint() {
        view.addSubview(floatingTabbarView)
        
        floatingTabbarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(37)
            make.bottom.equalToSuperview().offset(-34)
        }
    }
}

// MARK: - Protocols

extension FloatingTabBarController: FloatingBarViewDelegate {
    func floatingBarDidTapBarItem(selectindex: Int) {
        selectedIndex = selectindex
    }
}
