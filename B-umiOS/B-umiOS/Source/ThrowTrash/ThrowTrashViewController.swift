//
//  ThrowTrashViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/08.
//

import UIKit

class ThrowTrashViewController: UIViewController {
    // MARK: - UIComponenets

    let navigationView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    lazy var navigationLabel = UILabel().then {
        $0.text = self.trashType.mode
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = UIColor.white
    }
    
    lazy var backButton = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in
        self.navigationController?.popViewController(animated: true)
    })).then {
        $0.setImage(UIImage.btnBack.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .white
    }
    
    lazy var backgroudImage = UIImageView().then {
        $0.image = UIImage(named: "img_\(self.trashType)")
    }
    
    let explanationView = UIView().then {
        $0.backgroundColor = .background
        $0.cornerRound(radius: 10)
        $0.setShadow(radius: 13, offset: CGSize(width: 1, height: 4), opacity: 0.1, color: .init(45, 45, 45, 1))
    }
    
    let explanationImage = UIImageView().then {
        $0.image = UIImage.toastPaper1
    }
    
    lazy var explanationLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 15)
        $0.textColor = .iconGray
        let attributedStr = NSMutableAttributedString(string: explainString)

        attributedStr.addAttribute(.foregroundColor, value: UIColor.blue4, range: (explainString as NSString).range(of: self.trashType.explain))

        $0.attributedText = attributedStr
    }
    
    lazy var guideLabel = UILabel().then {
        $0.text = "\(self.trashType.trashBinName) 안으로 넣어보세요!"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .white
    }
    
    lazy var trash = UIImageView().then {
        $0.image = UIImage.imgWritingPaper
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:))))
    }
    
    let trashBin = UIView()

    // MARK: - Properties
    
    private var trashType: TrashType
    private var writing: WritingRequest
    private lazy var explainString = "당신의 스트레스가 \(trashType.explain)."
    
    // MARK: - Initializer
    
    init(trashType: TrashType, writingRequest: WritingRequest) {
        self.trashType = trashType
        self.writing = writingRequest
        
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

    @objc
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: view)
            trash.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        case .ended:
            guideLabel.alpha = 1
            
            let position = gesture.location(in: view)
            if position.x > trashBin.frame.midX, position.x < trashBin.frame.maxX, position.y > trashBin.frame.minY, position.y < trashBin.frame.maxY {
                throwAwayTrash()
                
                ActivityIndicator.shared.startLoadingAnimation()
                
                WritingService.shared.createWriting(writing: writing) { response in
                    ActivityIndicator.shared.stopLoadingAnimation()
                    
                    guard let result = response as? NetworkResult<Any> else { return }
                    
                    switch result {
                    case .success:
                        self.showToast()
                    case .requestErr, .pathErr, .serverErr, .networkFail:
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                resetTrash()
            }
        case .began:
            guideLabel.alpha = 0
        case .cancelled, .possible, .failed: break
        @unknown default:
            break
        }
    }
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .white
    }
    
    func resetTrash() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: .curveEaseIn) {
            self.trash.transform = .identity
        }
    }
    
    func throwAwayTrash() {
        guideLabel.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.trash.alpha = 0
        }
    }
    
    func showToast() {
        let msg = trashType.completionMessage
        let img = trashType.logo
        
        let toast = CompletionMessage(image: img, message: msg)
        toast.tag = 1000
        
        tabBarController?.view.addSubview(toast)
        toast.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        /// 진동
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            toast.alpha = 0
            toast.removeFromSuperview()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    // MARK: - Protocols
}
