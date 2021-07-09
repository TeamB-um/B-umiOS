//
//  SeparateGraphPopUpViewController.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/08.
//

import UIKit
import MultiProgressView

class SeparateGraphPopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    let popupView = UIView().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .white
    }
    
    let backgroundButton = UIButton().then {
        $0.addTarget(self, action: #selector(closeView(_:)), for: .touchUpInside)
    }
    
    var headerLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
        $0.text = "그래프"
    }
    
    let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "btnCloseBlack"), for: .normal)
        $0.addTarget(self, action: #selector(closeView(_:)), for: .touchUpInside)
    }
    let monthGraphView = GraphView()
    let entireGraphView = GraphView()
    
    var devideLine = UIView().then {
        $0.backgroundColor = .paper1
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    static let identifier = "SeparateGraphPopUpViewController"
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraint()
    }
    
    // MARK: - Actions
    
    @objc  private func closeView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func setView(){
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
}
