//
//  DeleteWritingViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/10.
//

import UIKit

// TODO: - 삭제 버튼 Action 등록

/// DeletePopUpViewController(title: "글 삭제", guide: "글을 삭제하시겠습니까?")
enum Kind{
    case separate
    case writing
}

class DeletePopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let popUpView = UIView().then {
        $0.backgroundColor = .white
        $0.setShadow(radius: 20, offset: CGSize(width: 0, height: 4), opacity: 0.03)
        $0.cornerRound(radius: 10)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = self.popUpTitle
        $0.textColor = .header
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
    }
    
    private lazy var guideLabel = UILabel().then {
        $0.text = self.popUpGuide
        $0.numberOfLines = 0
        $0.lineSpacing(spacing: 7)
        $0.textAlignment = .center
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .paper3
    }
    
    private lazy var cancelButton = UIButton(primaryAction: UIAction(handler: { _ in
        self.dismiss(animated: true, completion: nil)
    })).then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.paper3, for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
        $0.cornerRound(radius: 10)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
    }
    
    private lazy var deleteButton = UIButton().then {
        $0.backgroundColor = .blue2Main
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
        $0.cornerRound(radius: 10)
        $0.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
    }
    
    // MARK: - Properties
    
    static let identifier = "DeletePopUpViewController"
    var popUpDelegate: WritingPopUpDelegate?
    var popUpTitle: String
    var popUpGuide: String
    var kind : Kind?
    var deleteData : [String] = []
    var deletedelegate : deleteDelegate?
    var parentDelegate : deleteDelegate?
    // MARK: - Initializer
    
    init(title popUpTitle: String, guide popUpGuide: String) {
        self.popUpTitle = popUpTitle
        self.popUpGuide = popUpGuide
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
    }
    
    // MARK: - Actions

    @objc func didTapDelete(){
        var query = ""
        
        for (index,item) in deleteData.enumerated(){
            if(index == 0){
                query = item
            }
            else{
                query = "\(query),\(item)"
            }
        }
        
        switch kind{
        case .writing:
            WritingService.shared.deleteWriting(writings: query) { response in
                guard let result = response as? NetworkResult<Any> else{return}

                switch result{
                case .success(let response):
                    guard let writings = response as? GeneralResponse<WritingsResponse> else{return}
                    self.deletedelegate = self.parentDelegate
                    self.deletedelegate?.sendWritings(writings.data?.writing ?? [])
                default:
                    print("error")
                }
            }
        case .separate:
            print(deleteData)
            //여기다 작성해 인애
        case .none:
            break
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func setView() {
        view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
    
    func setConstraints() {
        view.addSubview(popUpView)
        popUpView.addSubviews([titleLabel, guideLabel, cancelButton, deleteButton])
        
        popUpView.snp.makeConstraints { make in
            make.width.equalTo(343 * SizeConstants.screenRatio)
            make.center.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(30 * SizeConstants.screenRatio).priority(.high)
            make.leading.equalToSuperview().offset(24 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().offset(-28 * SizeConstants.screenRatio)
            make.width.equalTo(141 * SizeConstants.screenRatio)
            make.height.equalTo(50 * SizeConstants.screenRatio)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.top)
            make.trailing.equalToSuperview().offset(-24 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().offset(-28 * SizeConstants.screenRatio)
            make.width.equalTo(141 * SizeConstants.screenRatio)
            make.height.equalTo(50 * SizeConstants.screenRatio)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != popUpView {
            dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Protocols
}
