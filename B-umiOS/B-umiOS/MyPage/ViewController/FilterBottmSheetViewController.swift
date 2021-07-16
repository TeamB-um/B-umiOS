//
//  MyWritingPopUpViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/07.
//
import Then
import SnapKit
import UIKit

class FilterBottmSheetViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let popupView = UIView().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .white
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    private let confirmButton = UIButton().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .blue2Main
        $0.tintColor = .white
        $0.setTitle("확인", for: .normal)
        $0.addTarget(self, action: #selector(didTapConfirmButton(_:)), for: .touchUpInside)
    }
    
    private lazy var categoryTagCollecitonView : UICollectionView = {
        var layout = CollectionViewLeftAlignFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(WritingTagCollectionViewCell.self, forCellWithReuseIdentifier: WritingTagCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var categoryLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
        $0.text = "카테고리"
    }
    
    private var settingPeriodView = UIView().then {
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
    }
    
    private var datePickerView: UIDatePicker = {
        var picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko_KO")
        var components = DateComponents()
        
        components.year = 10
        let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        
        components.year = -10
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        
        picker.maximumDate = maxDate
        picker.minimumDate = minDate
        picker.addTarget(self, action: #selector(datePickerIsChanged(_:)), for: .valueChanged)
        
        return picker
    }()
    
    private lazy var startDateButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitleColor(.iconGray, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(datePickerButtonSelected(_:)), for: .touchUpInside)
        $0.isHidden = true
    }
    
    private var startDateLine = UIView()
    
    private var endDateLine = UIView()
    
    private var startLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .green2Main
        $0.text = "시작"
        $0.isHidden = true
    }
    
    private var endLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .iconGray
        $0.text = "끝"
        $0.isHidden = true
    }
    
    private lazy var endDateButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitleColor(.iconGray, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(datePickerButtonSelected(_:)), for: .touchUpInside)
        $0.isHidden = true
    }
    
    private lazy var setDateLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
        $0.text = "기간 설정"
    }
    
    private var dateSwitch = UISwitch().then {
        $0.isOn = false
        $0.onTintColor = .green2Main
        $0.addTarget(self, action: #selector(didTapSwitch(_:)), for: .touchUpInside)
    }
    
    private let rect = UIView().then {
        $0.backgroundColor = .paper1
        $0.cornerRound(radius: 5)
    }
    
    private let backgroundButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapBackgroundButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .clear
    }
    
    // MARK: - Properties
    
    var selecetedStartDatePicker: Bool = true
    let dateFormatter = DateFormatter().then {
        $0.locale = Locale(identifier: "ko_KO")
        $0.dateFormat = "yyyy.MM.dd(E)"
    }
    var components = DateComponents()
    var endMinimumDate: Date = Date()
    var bgDelegate: viewDelegate?
    var tag: [Category] = []
    var startDate: Date = Date()
    var endDate: Date = Date()
    var categoryID: String = ""
    var categoryName: String = ""
    var tagSelectedIdx: Int = 0
    var parentDelegate: ChangeWritingDataDelegate?
    var delegate: ChangeWritingDataDelegate?
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
        setFirstDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCategoriesData()
    }
    
    // MARK: - Actions
    
    func fetchCategoriesData() {
        ActivityIndicator.shared.startLoadingAnimation()
        CategoryService.shared.fetchCategories { result in
            ActivityIndicator.shared.stopLoadingAnimation()
            guard let categories = result as? CategoriesResponse else { return }
            self.tag = categories.category
            self.categoryTagCollecitonView.reloadData()
        }
    }
    
    @objc private func didTapBackgroundButton(_ sender: UIButton) {
        print("dismiss")
        bgDelegate?.backgroundRemove()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func datePickerIsChanged(_ sender: UIPickerView){
        if (selecetedStartDatePicker) {
            startDate = datePickerView.date
            let dateText = dateFormatter.string(from: datePickerView.date)
            startDateButton.setTitle(dateText, for: .normal)
            endMinimumDate = datePickerView.date
            
        } else {
            endDate = datePickerView.date
            let dateText = dateFormatter.string(from: datePickerView.date)
            endDateButton.setTitle(dateText, for: .normal)
        }
    }
    
    @objc private func datePickerButtonSelected(_ sender: UIButton) {
        let dateString = sender.currentTitle
        let date = dateFormatter.date(from: dateString!)
        datePickerView.date = date!
        
        if sender == startDateButton {
            selecetedStartDatePicker = true;
            startDateLine.backgroundColor = .green2Main
            startLabel.textColor = .green2Main
            endDateLine.backgroundColor = .disable
            endLabel.textColor = .iconGray
            setStardMinimumDate()
        } else {
            selecetedStartDatePicker = false
            startDateLine.backgroundColor = .disable
            startLabel.textColor = .iconGray
            endDateLine.backgroundColor = .green2Main
            endLabel.textColor = .green2Main
            datePickerView.minimumDate = endMinimumDate
        }
        changeDateText(button: sender)
    }
    
    @objc private func didTapSwitch(_ sender: UISwitch) {
        if sender.isOn {
            settingPeriodView.snp.updateConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.equalTo(categoryLabel.snp.top).offset(-34)
                make.height.equalTo(220)
            }
            startLabel.isHidden = false
            startDateButton.isHidden = false
            endLabel.isHidden = false
            endDateButton.isHidden = false
        } else {
            settingPeriodView.snp.updateConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.equalTo(categoryLabel.snp.top).offset(-34)
                make.height.equalTo(0)
            }
        }
    }

    @objc private func didTapConfirmButton(_ sender: UIButton) {
        var startDate = startDate.dateToString(format: "yyyy-MM-dd", date: startDate)
        var endDate = endDate.dateToString(format: "yyyy-MM-dd", date: endDate)
        
        if !dateSwitch.isOn {
            startDate = ""
            endDate = ""
        }
        
        ActivityIndicator.shared.startLoadingAnimation()
        WritingService.shared.filterWritings(start_date: startDate, end_date: endDate, category_id: categoryID) { result in
            ActivityIndicator.shared.stopLoadingAnimation()
            
            guard let r = result as? NetworkResult<Any> else { return }
            switch r {
            case .success(let response):
                guard let data = response as? GeneralResponse<WritingsResponse> else { return }
                
                if let d = data.data?.writing {
                    self.delegate = self.parentDelegate
                    self.delegate?.changeWitingData(filteredDate: d)
                    self.dismiss(animated: true, completion: {
                        self.categoryTagCollecitonView.reloadData()
                        NotificationCenter.default.post(name: Notification.Name.categoryIsChanged, object: self.categoryName)
                        
                    })
                }
                
            case .requestErr(ErrorMessage.notFound):
                print("404 낫파운드")
            default:
                print("error")
            }                                                                                                                                                                                                   
        }
        bgDelegate?.backgroundRemove()
        self.dismiss(animated: true, completion: nil)   
    }

    // MARK: - Methods
    
    func setView() {
        self.view.backgroundColor = .clear
    }
    
    func setConstraint() {
        self.view.addSubviews([backgroundButton,popupView])
        popupView.addSubviews([rect,categoryTagCollecitonView, categoryLabel, settingPeriodView, setDateLabel, dateSwitch, confirmButton])
        settingPeriodView.addSubviews([datePickerView, startDateButton,endDateButton,startDateLine, endDateLine, startLabel, endLabel])
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        popupView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(setDateLabel.snp.top).offset(-40)
            make.leading.trailing.equalToSuperview()
        }
        
        rect.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(65.0/375.0)
            make.centerX.equalToSuperview()
            make.height.equalTo(6 * SizeConstants.screenRatio)
        }
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(42)
            make.height.equalTo(50)
        }
        
        categoryTagCollecitonView.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.bottom.equalTo(confirmButton.snp.top).offset(30)
            make.leading.trailing.equalTo(confirmButton)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.bottom.equalTo(categoryTagCollecitonView.snp.top).offset(-22)
            make.leading.equalTo(confirmButton)
        }
        
        settingPeriodView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(categoryLabel.snp.top).offset(-34)
            make.height.equalTo(0)
        }
        
        startLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(startLabel).offset(8)
        }
        
        endLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(endDateLine).offset(8)
        }
        
        startDateButton.snp.makeConstraints { make in
            make.top.equalTo(startLabel.snp.bottom).offset(3)
            make.leading.equalTo(startLabel)
            make.height.equalTo(28)
        }
        
        endDateButton.snp.makeConstraints { make in
            make.top.equalTo(endLabel.snp.bottom).offset(3)
            make.leading.equalTo(endLabel)
            make.height.equalTo(28)
        }
        
        startDateLine.snp.makeConstraints { make in
            make.top.equalTo(startDateButton.snp.bottom)
            make.leading.equalToSuperview()
            make.width.equalTo((SizeConstants.screenWidth - 55)/2)
            make.height.equalTo(2)
        }
        
        endDateLine.snp.makeConstraints { make in
            make.top.equalTo(endDateButton.snp.bottom)
            make.width.equalTo((SizeConstants.screenWidth - 55)/2)
            make.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        
        datePickerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(140)
        }
        
        setDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(confirmButton)
            make.bottom.equalTo(settingPeriodView.snp.top).offset(-24)
        }
        
        dateSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(setDateLabel)
        }
    }
    
    func setFirstDatePicker(){
        //익스텐션 사용하는 걸로 수정할게요
        let nowDateTime = Date();
        let tmpDateFormatter = DateFormatter();
        tmpDateFormatter.dateFormat = "yyyy.MM.dd(E)"
        
        startDateLine.backgroundColor = .green2Main
        endDateLine.backgroundColor = .disable
        
        startDateButton.setTitle(dateFormatter.string(from: nowDateTime), for: .normal)
        endDateButton.setTitle(dateFormatter.string(from: nowDateTime), for: .normal)
    }
    
    func setStardMinimumDate(){
        components.year = -10
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        datePickerView.minimumDate = minDate
    }
    
    func changeDateText(button: UIButton){
        if button == startDateButton {
            startDate = datePickerView.date
        } else {
            endDate = datePickerView.date
        }
    }
}

// MARK: - Protocols
// MARK: - Extensions

extension FilterBottmSheetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = tag[indexPath.row].name
        label.font = UIFont.nanumSquareFont(type: .regular, size: 16)
        label.sizeToFit()
        
        return CGSize(width: label.bounds.width + 32, height: label.bounds.height + 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}
// MARK: - UICollectionViewDataSource

extension FilterBottmSheetViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WritingTagCollectionViewCell.identifier, for: indexPath) as? WritingTagCollectionViewCell else { return UICollectionViewCell() }
        cell.setTagLabel(tag: tag[indexPath.row].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categoryID = tag[indexPath.row].id
        categoryName = tag[indexPath.row].name
    }
}
