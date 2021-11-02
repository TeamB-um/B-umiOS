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
        $0.setImage(UIImage.btnCloseBlack, for: .normal)
        $0.addTarget(self, action: #selector(closeView(_:)), for: .touchUpInside)
    }
    
    var monthGraphView = GraphView(title: "월간", sub: "한 달 내 카테고리별")
    var entireGraphView = GraphView(title: "전체", sub: "전체 사용 기간 동안의")
    
    var divideLine = UIView().then {
        $0.backgroundColor = .paper1
        $0.isHidden = true
    }
    
    var graphStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 15 * SizeConstants.screenRatio
        $0.backgroundColor = .white
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    static let identifier = "SeparateGraphPopUpViewController"
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCategoryGraph()
    }
    
    // MARK: - Actions
    
    @objc private func closeView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func setView(){
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        graphStackView.addArrangedSubview(monthGraphView)
        graphStackView.addArrangedSubview(entireGraphView)
        self.view.bringSubviewToFront(divideLine)
    }
    
    func fetchCategoryGraph(){
        ActivityIndicator.shared.startLoadingAnimation()
        CategoryService.shared.fetchGraphData { response in
            guard let result = response as? NetworkResult<Any> else{return}
            
            switch result {
            case .success(let response):
                guard let w = response as? GeneralResponse<GraphResponse> else { return }
                
                self.entireGraphView.setGraph(data: w.data?.allstat ?? [])
                self.monthGraphView.setGraph(data: w.data?.monthstat ?? [])
                self.divideLine.isHidden = false
                
                if(w.data?.allstat.count == 0){
                    self.emptyData(self.entireGraphView, "아직 아무것도 버리지 않았어요!")
                }
                else{
                    self.existData(self.entireGraphView)
                }
                
                if(w.data?.monthstat.count == 0){
                    self.emptyData(self.monthGraphView, "지난달 아무것도 버리지 않았어요!")
                }
                else{
                    self.existData(self.monthGraphView)
                }
                
            default:
                break
            }
            ActivityIndicator.shared.stopLoadingAnimation()
        }
    }
    
    func existData(_ graph : GraphView){
        graph.verticalStackView.isHidden = false
        graph.progressBackGroundView.isHidden = false
        graph.progressView.isHidden = false
    }
    
    func emptyData(_ graph : GraphView, _ text : String){
        graph.emptyLabel.text = text
        graph.emptyImage.isHidden = false
        graph.emptyLabel.isHidden = false
    }
}
