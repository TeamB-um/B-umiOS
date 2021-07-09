//
//  SettingViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/02.
//

import UIKit

class SettingViewController: UIViewController, popupDelegate{
    // MARK: - UIComponenets

    var navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var backgroundView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    var headerLabel = UILabel().then {
        $0.text = "설정"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
    }
    
    let navigationDividerView = UIView().then {
        $0.backgroundColor = .paper1
    }
    
    let stackDividerView = UIView().then {
        $0.backgroundColor = .paper1
    }
    
    var topStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .vertical
    }
    
    var bottomStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .vertical
    }
    
    var trashbinPeriodLabel = UILabel().then {
        $0.text = "3일"
        $0.textColor = .textGray
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
    }
    
    let trashbinPeriodButton = UIButton().then {
        $0.setImage(UIImage(named: "brnEdit"), for: .normal)
        $0.addTarget(self, action: #selector(setPeriodButton(_:)), for: .touchUpInside)
    }
    
    let trashbinManageButton = UIButton().then {
        $0.setImage(UIImage(named: "btnLeft"), for: .normal)
        $0.addTarget(self, action: #selector(didTapTrashBinManageButton(_:)), for: .touchUpInside)
    }
    
    var pushAlarmSwitch = UISwitch().then {
        $0.onTintColor = .blue2Main
    }
    
    let serviceConditionButton = UIButton().then {
        $0.setImage(UIImage(named: "btnLeft"), for: .normal)
    }
    
    let personalInfomationButton = UIButton().then {
        $0.setImage(UIImage(named: "btnLeft"), for: .normal)
    }
    
    let opensourceLicenseButton = UIButton().then {
        $0.setImage(UIImage(named: "btnLeft"), for: .normal)
    }
    
    let developerInformationButton = UIButton().then {
        $0.setImage(UIImage(named: "btnLeft"), for: .normal)
    }

    // MARK: - Properties
    
    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        setConstraint()
    }

    // MARK: - Actions

    @objc
        private func didTapTrashBinManageButton(_ sender: UIButton) {
            if let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingTrashBinViewController"){
                self.navigationController?.pushViewController(pushVC, animated: true)
            }
        }
    
    @objc
        private func setPeriodButton(_ sender: UIButton) {
            
            let popUpVC = self.storyboard?.instantiateViewController(identifier: "PeriodPopUpViewController") as! PeriodPopUpViewController
            popUpVC.modalPresentationStyle = .overFullScreen
            popUpVC.modalTransitionStyle = .coverVertical
            
            popUpVC.popupdelegate = self
            
            DispatchQueue.main.async {
                self.view.addSubview(self.backgroundView)
                self.backgroundView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
            self.present(popUpVC, animated: true, completion: nil)
            
            
        }
    
    // MARK: - Methods
    
    func createView(text : String, items: [NSCoding]) -> UIView{
        let newView = UIView().then {
            $0.backgroundColor = .background
        }
    
        let label = UILabel().then {
            $0.textColor = .paper4
            $0.text = text
            $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
        }
        
        let stackView = UIStackView().then {
            $0.distribution = .fillEqually
            $0.axis = .horizontal
            $0.spacing = 16 * SizeConstants.screenRatio
        }
        
        newView.addSubviews([label, stackView])
        
        for item in items{
            stackView.addArrangedSubview(item as! UIView)
        }
        
        newView.snp.makeConstraints { make in
            make.height.equalTo(48 * SizeConstants.screenRatio)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24 * SizeConstants.screenRatio)
            make.centerY.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.top.bottom.equalTo(label)
        }
        
        return newView
    }

    // MARK: - Protocols
    
    func diss() {
        self.backgroundView.removeFromSuperview()
    }
}

protocol popupDelegate {
    func diss()
}
