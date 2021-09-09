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
        setNotifiaction()
        setConstraint()
    }
    
    // MARK: - Actions

    @objc
    func hideTabBar(_ sender: NotificationCenter) {
        /// curveEaseIn - 느리게 시작했다가 빠르게
        /// /// curveEaseIn - 느리게 빠르게 시작했다가 느리게
        /// curveEaseInOut - 느리게 - 가속 - 느리게 (default)
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn, animations: {
            self.floatingTabbarView.transform = CGAffineTransform(translationX: 0, y: self.floatingTabbarView.frame.origin.y + self.view.safeAreaInsets.bottom + self.floatingTabbarView.frame.height)
        })
    }

    @objc
    func showTabBar(_ sender: NotificationCenter) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: .curveEaseInOut, animations: {
            self.floatingTabbarView.transform = .identity
        })
    }
    
    @objc
    func showPresentPopUp(_ sender: NotificationCenter) {
        let popUpVC = SurprisePopUpViewController()
        popUpVC.modalTransitionStyle = .crossDissolve
        popUpVC.modalPresentationStyle = .overCurrentContext
        
        self.present(popUpVC, animated: true, completion: nil)
    }
    
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
    
    func setNotifiaction() {
        NotificationCenter.default.addObserver(self, selector: #selector(showTabBar(_:)), name: Notification.Name.TabBarShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideTabBar(_:)), name: Notification.Name.TabBarHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showPresentPopUp(_:)), name: Notification.Name.pushPresent, object: nil)
    }
}

// MARK: - Protocols

extension FloatingTabBarController: FloatingBarViewDelegate {
    func floatingBarDidTapBarItem(selectindex: Int) {
        selectedIndex = selectindex
    }
}
