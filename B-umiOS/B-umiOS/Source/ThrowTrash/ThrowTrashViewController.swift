//
//  ThrowTrashViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/08.
//

import Lottie
import UIKit

class ThrowTrashViewController: UIViewController {
    // MARK: - UIComponenets

    let navigationView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    var navigationLabel = UILabel().then {
//        $0.text = self.trashType.mode
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = UIColor.white
    }
    
    lazy var backButton = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in
        self.navigationController?.popViewController(animated: true)
    })).then {
        $0.setImage(UIImage.btnBack.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .white
    }
    
    var backgroudImage = UIImageView()
    
    var animationView = AnimationView().then {
        $0.loopMode = .playOnce
    }
    
    let explanationView = UIView().then {
        $0.backgroundColor = .background
        $0.cornerRound(radius: 10)
        $0.setShadow(radius: 13, offset: CGSize(width: 1, height: 4), opacity: 0.1, color: .init(45, 45, 45, 1))
    }
    
    let explanationImage = UIImageView().then {
        $0.image = UIImage.toastPaper1
    }
    
    var explanationLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 15)
        $0.textColor = .iconGray
    }
    
    var guideLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .white
    }
    
    var trash = UIImageView().then {
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
    
    deinit {
        print("throw trash deinit 🎵👀")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
    }
    
//    override func viewWillLayoutSubviews() {
//        let trailing = (explanationView.frame.width - explanationImage.frame.maxX - explanationLabel.frame.width) / 2.0
//
//        explanationLabel.snp.updateConstraints { make in
//            make.trailing.equalToSuperview().offset(-trailing * SizeConstants.screenRatio)
//        }
//    }
    
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
            if (trashBin.frame.minX ... trashBin.frame.maxX).contains(position.x),
               (trashBin.frame.minY ... trashBin.frame.maxY).contains(position.y)
            {
//                throwAwayTrash { [weak self] in
//                    self?.createWritingData()
//                }
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
        
        backgroudImage.image = UIImage(named: "img_\(trashType)")
        animationView.animation = Animation.named("\(trashType.rawValue)")
        
        guideLabel.text = "\(trashType.trashBinName) 안으로 넣어보세요!"
        navigationLabel.text = trashType.mode
        
        let attributedStr = NSMutableAttributedString(string: explainString)

        attributedStr.addAttribute(.foregroundColor, value: UIColor.blue3, range: (explainString as NSString).range(of: trashType.explain))

        explanationLabel.attributedText = attributedStr
    }
    
    func resetTrash() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: .curveEaseIn) {
            self.trash.transform = .identity
        }
    }
    
    func throwAwayTrash(compleition: @escaping () -> ()) {
        guideLabel.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.trash.alpha = 0
        }

        if trashType == TrashType.separate {
            compleition()
        } else {
            animationView.play { _ in
                compleition()
            }
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            toast.alpha = 0
            toast.removeFromSuperview()
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
//    func createWritingData() {
//        ActivityIndicator.shared.startLoadingAnimation()
//
//        WritingService.shared.createWriting(writing: writing) { response in
//            ActivityIndicator.shared.stopLoadingAnimation()
//
//            guard let result = response as? NetworkResult<Any> else { return }
//
//            switch result {
//            case .success:
//                self.showToast()
//            case .requestErr, .pathErr, .serverErr, .networkFail:
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
//    }

    // MARK: - Protocols
}
