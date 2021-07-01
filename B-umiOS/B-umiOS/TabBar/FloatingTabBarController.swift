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
        viewControllers = [createNavigationController(viewController: UIViewController()), createNavigationController(viewController: UIViewController()), createNavigationController(viewController: UIViewController()), createNavigationController(viewController: UIViewController())]
        
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
