import UIKit

class FilterViewController: BaseViewController {
    
    public var presenter: FilterPresenter?
    private lazy var mainScrollView = UIScrollView(frame: .zero)
    private lazy var mainStackView = UIStackView(frame: .zero)
    private lazy var titleLabel = UILabel(frame: .zero)
    
    private lazy var closeButton = UIButton(frame: .zero)
    
    private lazy var orderByLabel = UILabel(frame: .zero)
    private lazy var orderBySegmentControl = UISegmentedControl(frame: .zero)
    
//    private lazy var dateTitleStackView = UIStackView(frame: .zero)
//    private lazy var dateFromLabel = UILabel(frame: .zero)
//    private lazy var dateToLabel = UILabel(frame: .zero)
//
//    private lazy var dateTextFieldsStackView = UIStackView(frame: .zero)
//    private lazy var dateFromTextField = UITextField(frame: .zero)
//    private var dateFromDatePicker = UIDatePicker()
//    private lazy var dateToTextField = UITextField(frame: .zero)
//    private var dateToDatePicker = UIDatePicker()
//    private var datePickerToolBar = UIToolbar()
    
    private lazy var typeViewDetailLabel = UILabel(frame: .zero)
    private lazy var typeViewDetailSegmentControl = UISegmentedControl(frame: .zero)
    
    private lazy var quantityItemsByPageLabel = UILabel(frame: .zero)
    private lazy var quantityItemsByPageSegmentControl = UISegmentedControl(frame: .zero)
    
    private lazy var quantityCharactersAutoSearchLabel = UILabel(frame: .zero)
    private lazy var quantityCharactersAutoSearchCurrentLabel = UILabel(frame: .zero)
    
    private lazy var quantityCharactersAutoSearchStackView = UIStackView(frame: .zero)
    private lazy var quantityCharactersAutoSearchSlider = UISlider(frame: .zero)
    private lazy var quantityCharactersAutoSearchMinLabel = UILabel(frame: .zero)
    private lazy var quantityCharactersAutoSearchMaxLabel = UILabel(frame: .zero)
    
    //0 no autosearch
    
    private lazy var saveButton = UIButton(frame: .zero)
    private lazy var resetButton = UIButton(frame: .zero)
    
    private var filterOrderBy: TypeFilterOrderBy?
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FilterPresenter(filterView: self, newsService: NewsServices())
    }
    
    override func addSubviews() {
        view.addSubview(mainScrollView)
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        
        mainScrollView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(orderByLabel)
        mainStackView.addArrangedSubview(orderBySegmentControl)
        
//        mainStackView.addArrangedSubview(dateTitleStackView)
//        dateTitleStackView.addArrangedSubview(dateFromLabel)
//        dateTitleStackView.addArrangedSubview(dateToLabel)
//
//        mainStackView.addArrangedSubview(dateTextFieldsStackView)
//        dateTextFieldsStackView.addArrangedSubview(dateFromTextField)
//        dateTextFieldsStackView.addArrangedSubview(dateToTextField)
        
        mainStackView.addArrangedSubview(typeViewDetailLabel)
        mainStackView.addArrangedSubview(typeViewDetailSegmentControl)
        
        mainStackView.addArrangedSubview(quantityItemsByPageLabel)
        mainStackView.addArrangedSubview(quantityItemsByPageSegmentControl)
        
        mainStackView.addArrangedSubview(quantityCharactersAutoSearchLabel)
        mainStackView.addArrangedSubview(quantityCharactersAutoSearchCurrentLabel)
        
        mainStackView.addArrangedSubview(quantityCharactersAutoSearchStackView)
        quantityCharactersAutoSearchStackView.addArrangedSubview(quantityCharactersAutoSearchMinLabel)
        quantityCharactersAutoSearchStackView.addArrangedSubview(quantityCharactersAutoSearchSlider)
        quantityCharactersAutoSearchStackView.addArrangedSubview(quantityCharactersAutoSearchMaxLabel)
        
        mainStackView.addArrangedSubview(saveButton)
        mainStackView.addArrangedSubview(resetButton)
    }
    
    override func addStyle() {
        view.backgroundColor = .backgroundSections
        
        titleLabel.font = .bold(18)
        titleLabel.textColor = .fontFiltersTitle
        titleLabel.textAlignment = .center
        
        closeButton.setImage(CommonAssets.close.image.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.contentMode = .scaleAspectFit
        closeButton.tintColor = .primaryColor
        
        orderByLabel.font = .regular(16)
        orderByLabel.textColor = .fontFiltersTitle
        
        orderBySegmentControl.tintColor = .primaryColor
        orderBySegmentControl.selectedSegmentTintColor = .primaryColor
        orderBySegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.fontFiltersTitle],
                                                     for: .normal)
        orderBySegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white],
                                                     for: .selected)
        
//        dateFromLabel.font = .regular(16)
//        dateFromLabel.textColor = .fontFiltersTitle
//
//        dateFromDatePicker.datePickerMode = .date
//        dateFromDatePicker.maximumDate = Date()
//        if #available(iOS 13.4, *) {
//            dateFromDatePicker.preferredDatePickerStyle = .wheels
//        }
//
//        datePickerToolBar.sizeToFit()
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneFromButtonTapped))
//        datePickerToolBar.setItems([doneButton], animated: true)
//        dateFromTextField.inputAccessoryView = datePickerToolBar
//
//        dateFromTextField.font = .regular(16)
//        dateFromTextField.textColor = .fontFiltersTitle
//        dateFromTextField.layer.borderColor = UIColor.primaryColor.cgColor
//        dateFromTextField.layer.borderWidth = 1
//        dateFromTextField.layer.cornerRadius = 5
//        dateFromTextField.inputView = dateFromDatePicker
//        dateFromTextField.addPaddingLeft(padding: 10)
//
//        dateToLabel.font = .regular(16)
//        dateToLabel.textColor = .fontFiltersTitle
//
//        dateToDatePicker.datePickerMode = .date
//        dateToDatePicker.maximumDate = Date()
//        if #available(iOS 13.4, *) {
//            dateToDatePicker.preferredDatePickerStyle = .wheels
//        }
//
//        dateToTextField.font = .regular(16)
//        dateToTextField.textColor = .fontFiltersTitle
//        dateToTextField.layer.borderColor = UIColor.primaryColor.cgColor
//        dateToTextField.layer.borderWidth = 1
//        dateToTextField.layer.cornerRadius = 5
//        dateToTextField.inputView = dateToDatePicker
//        dateToTextField.addPaddingLeft(padding: 10)
        
        typeViewDetailLabel.font = .regular(16)
        typeViewDetailLabel.textColor = .fontFiltersTitle
        typeViewDetailSegmentControl.tintColor = .primaryColor
        typeViewDetailSegmentControl.selectedSegmentTintColor = .primaryColor
        typeViewDetailSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.fontFiltersTitle],
                                                     for: .normal)
        typeViewDetailSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white],
                                                     for: .selected)
        
        quantityItemsByPageLabel.font = .regular(16)
        quantityItemsByPageLabel.textColor = .fontFiltersTitle
        
        quantityItemsByPageSegmentControl.tintColor = .primaryColor
        quantityItemsByPageSegmentControl.selectedSegmentTintColor = .primaryColor
        quantityItemsByPageSegmentControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.fontFiltersTitle],
            for: .normal)
        quantityItemsByPageSegmentControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white],
            for: .selected)
        
        quantityCharactersAutoSearchLabel.font = .regular(16)
        quantityCharactersAutoSearchLabel.textColor = .fontFiltersTitle
        
        quantityCharactersAutoSearchCurrentLabel.font = .regular(24)
        quantityCharactersAutoSearchCurrentLabel.textAlignment = .center
        quantityCharactersAutoSearchCurrentLabel.textColor = .primaryColor
        
        quantityCharactersAutoSearchMinLabel.font = .regular(16)
        quantityCharactersAutoSearchMinLabel.textAlignment = .center
        quantityCharactersAutoSearchMinLabel.textColor = .fontFiltersTitle

        quantityCharactersAutoSearchSlider.thumbTintColor = .primaryColor
        quantityCharactersAutoSearchSlider.minimumTrackTintColor = .primaryColor.withAlphaComponent(0.5)
        
        quantityCharactersAutoSearchMaxLabel.font = .regular(16)
        quantityCharactersAutoSearchMaxLabel.textAlignment = .center
        quantityCharactersAutoSearchMaxLabel.textColor = .fontFiltersTitle
        
        saveButton.backgroundColor = .primaryColor
        saveButton.layer.cornerRadius = 10
        saveButton.titleLabel?.font = .bold(14)
        
        resetButton.setTitleColor(.primaryColor, for: .normal)
        resetButton.layer.cornerRadius = 10
        resetButton.titleLabel?.font = .bold(14)
        resetButton.layer.borderWidth = 1
        resetButton.layer.borderColor = UIColor.primaryColor.cgColor
    }
    
    override func addConstraints() {
        mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { (make) in
            make.top.equalTo(mainScrollView).inset(0)
            make.bottom.equalTo(mainScrollView).inset(10)
            make.left.right.equalTo(view)
            make.width.equalTo(mainScrollView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        closeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(25)
            make.width.height.equalTo(15)
        }
        
        orderByLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        orderBySegmentControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
                
//        dateTitleStackView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(20)
//        }
//
//        dateFromLabel.snp.makeConstraints { make in
//            make.width.equalToSuperview().dividedBy(2).inset(5)
//        }
//
//        dateToLabel.snp.makeConstraints { make in
//            make.width.equalToSuperview().dividedBy(2).inset(5)
//        }
//
//        dateTextFieldsStackView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(20)
//        }
//
//        dateFromTextField.snp.makeConstraints { make in
//            make.width.equalToSuperview().dividedBy(2).inset(5)
//            make.height.equalTo(30)
//        }
//
//        dateToTextField.snp.makeConstraints { make in
//            make.width.equalToSuperview().dividedBy(2).inset(5)
//            make.height.equalTo(30)
//        }
        
        typeViewDetailLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        typeViewDetailSegmentControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        quantityItemsByPageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        quantityItemsByPageSegmentControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        quantityCharactersAutoSearchLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        quantityCharactersAutoSearchCurrentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        quantityCharactersAutoSearchStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        quantityCharactersAutoSearchMinLabel.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        quantityCharactersAutoSearchSlider.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        quantityCharactersAutoSearchMaxLabel.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        resetButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    override func addConfiguration() {
        title = "title_filter_item".localized.uppercased()
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 20
        
        titleLabel.text = "title_filter_item".localized
        
        closeButton.addTarget(self, action: #selector(pressCloseButton), for: .touchUpInside)
        
        orderByLabel.text = "title_filter_order_by".localized
        orderBySegmentControl.insertSegment( withTitle: TypeFilterOrderBy.relevance.rawValue.localized,
                                             at: 0,
                                             animated: true)
        orderBySegmentControl.insertSegment(withTitle: TypeFilterOrderBy.newest.rawValue.localized,
                                            at: 1,
                                            animated: true)
        orderBySegmentControl.insertSegment(withTitle: TypeFilterOrderBy.oldest.rawValue.localized,
                                            at: 2,
                                            animated: true)
        orderBySegmentControl.insertSegment(withTitle: TypeFilterOrderBy.none.rawValue.localized,
                                            at: 3,
                                            animated: true)
//        orderBySegmentControl.addTarget(self,
//                                        action: #selector(orderBySegmentControlChange),
//                                        for: .valueChanged)
        orderBySegmentControl.selectedSegmentIndex = 1
        
//        dateTitleStackView.axis = .horizontal
//        dateTitleStackView.spacing = 10
//
//        dateFromLabel.text = "title_filter_date_from".localized
//
//        dateToLabel.text = "title_filter_date_to".localized
//
//        dateTextFieldsStackView.axis = .horizontal
//        dateTextFieldsStackView.spacing = 10
//
//        dateFromDatePicker.addTarget(self, action: #selector(dateFromValueChanged), for: .valueChanged)
//        let doneButton = UIBarButtonItem.init(title: "Done",
//                                              style: .done,
//                                              target: self,
//                                              action: #selector(dateFromPickerDone))
//        doneButton.tintColor = .primaryColor
//        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
//        toolBar.setItems(
//            [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton],
//            animated: true)
////        dateFromDatePicker.inputAccessoryView = toolBar
//        dateToDatePicker.addTarget(self, action: #selector(dateToValueChanged), for: .valueChanged)
        
        typeViewDetailLabel.text = "title_filter_type_view_detail".localized
        typeViewDetailSegmentControl.insertSegment(withTitle: TypeFilterDetailView.present.rawValue.localized,
                                                   at: 0,
                                                   animated: true)
        typeViewDetailSegmentControl.insertSegment(withTitle: TypeFilterDetailView.push.rawValue.localized,
                                                   at: 1,
                                                   animated: true)
//        typeViewDetailSegmentControl.addTarget(self,
//                                        action: #selector(typeViewDetailSegmentControlChange),
//                                        for: .valueChanged)
        typeViewDetailSegmentControl.selectedSegmentIndex = 1
        
        quantityItemsByPageLabel.text = "title_filter_quantity_items_by_page".localized
        quantityItemsByPageSegmentControl.insertSegment(withTitle: TypeFilterQuantityItemsByPage.five.rawValue.localized,
                                                        at: 0,
                                                        animated: true)
        quantityItemsByPageSegmentControl.insertSegment(withTitle: TypeFilterQuantityItemsByPage.ten.rawValue.localized,
                                                        at: 1,
                                                        animated: true)
        quantityItemsByPageSegmentControl.insertSegment(withTitle: TypeFilterQuantityItemsByPage.twenty.rawValue.localized,
                                                        at: 2,
                                                        animated: true)
        quantityItemsByPageSegmentControl.insertSegment(withTitle: TypeFilterQuantityItemsByPage.fifty.rawValue.localized,
                                                        at: 3,
                                                        animated: true)
//        quantityItemsByPageSegmentControl.addTarget(self,
//                                        action: #selector(quantityItemsByPageSegmentControlChange),
//                                        for: .valueChanged)
        quantityItemsByPageSegmentControl.selectedSegmentIndex = 1
        
        quantityCharactersAutoSearchLabel.text = "title_filter_quantity_characters_autosearch".localized
        
        quantityCharactersAutoSearchStackView.axis = .horizontal
        quantityCharactersAutoSearchStackView.spacing = 10
        
        quantityCharactersAutoSearchCurrentLabel.text = "5"
        
        quantityCharactersAutoSearchSlider.minimumValue = 0
        quantityCharactersAutoSearchSlider.maximumValue = 10

        quantityCharactersAutoSearchSlider.addTarget(self,
                                                     action: #selector(quantityCharactersAutoSearchSliderChangeValue),
                                                     for: .valueChanged)
        
        quantityCharactersAutoSearchMinLabel.text = "0"
        quantityCharactersAutoSearchMaxLabel.text = "10"
        
        saveButton.setTitle("saveFilters".localized.uppercased(), for: .normal)
        saveButton.addTarget(self, action: #selector(pressSaveButton), for: .touchUpInside)
        
        resetButton.setTitle("resetFilters".localized.uppercased(), for: .normal)
        resetButton.addTarget(self, action: #selector(pressResetButton), for: .touchUpInside)
        
        populateFilters()
    }
    
    @objc func dateFromPickerDone() {
//       dateFromDatePicker.resignFirstResponder()
   }
    
    @objc func dateFromValueChanged() {
//        let dateString = "\(dateFromDatePicker.date)"
//        if let date = dateString.getFormattedDate(
//            fromFormat: Constants.Date.pickerDate,
//            toNewFormat: Constants.Date.newsFormat) {
//            dateFromTextField.text = date
//        }
    }
    
    @objc func doneFromButtonTapped() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
//        dateFromTextField.text = dateFormatter.string(from: dateFromDatePicker.date)
    }
    
    @objc func dateToValueChanged(_ sender: UIDatePicker) {
//        let dateString = "\(dateToDatePicker.date)"
//        if let date = dateString.getFormattedDate(
//            fromFormat: Constants.Date.pickerDate,
//            toNewFormat: Constants.Date.newsFormat) {
//            dateToTextField.text = date
//        }
    }
    
    func populateFilters() {
        if let filters = ManagerFilters().loadFilters() {
            orderBySegmentControl.selectedSegmentIndex = filters.orderBy
//            dateFromTextField.text = filters.dateFrom //birthDatePicker.date
//            dateToTextField.text = filters.dateFrom
            typeViewDetailSegmentControl.selectedSegmentIndex = filters.viewDetails
            quantityItemsByPageSegmentControl.selectedSegmentIndex = filters.quantityItemsByPage
            quantityCharactersAutoSearchCurrentLabel.text = "\(filters.quantityCharactersAutoSearch)"
            quantityCharactersAutoSearchSlider.value = Float(filters.quantityCharactersAutoSearch)
        }
    }
    
    func resetFilters() {
        for index in 0...TypeFilterOrderBy.allValues.count - 1
        where Constants.FiltersDefault.orderBy == TypeFilterOrderBy.allValues[index] {
                orderBySegmentControl.selectedSegmentIndex = index
        }
//        dateFromTextField.text = Constants.FiltersDefault.dateFrom
//        dateToTextField.text = Constants.FiltersDefault.dateTo
        for index in 0...TypeFilterDetailView.allValues.count - 1
        where Constants.FiltersDefault.viewDetails == TypeFilterDetailView.allValues[index] {
                typeViewDetailSegmentControl.selectedSegmentIndex = index
        }
        for index in 0...TypeFilterQuantityItemsByPage.allValues.count - 1
        where Constants.FiltersDefault.quantityItemsByPage == TypeFilterQuantityItemsByPage.allValues[index] {
            quantityItemsByPageSegmentControl.selectedSegmentIndex = index
        }
        quantityCharactersAutoSearchCurrentLabel.text = "\(Constants.FiltersDefault.quantityCharactersAutoSearch)"
        quantityCharactersAutoSearchSlider.value = Float(Constants.FiltersDefault.quantityCharactersAutoSearch)
        quantityCharactersAutoSearchMinLabel.text = "\(Constants.FiltersDefault.quantityCharactersAutoSearchMin)"
        quantityCharactersAutoSearchSlider.minimumValue = Float(Constants.FiltersDefault.quantityCharactersAutoSearchMin)
        quantityCharactersAutoSearchMaxLabel.text = "\(Constants.FiltersDefault.quantityCharactersAutoSearchMax)"
        quantityCharactersAutoSearchSlider.maximumValue = Float(Constants.FiltersDefault.quantityCharactersAutoSearchMax)
        saveFilters()
    }
    
    func saveFilters() {
        let filters = FilterModel(orderBy: orderBySegmentControl.selectedSegmentIndex,
                                  dateFrom: "01-01-2021", //dateFromTextField.text ?? Constants.FiltersDefault.dateFrom,
                                  dateTo: "01-01-2021", //dateToTextField.text ?? Constants.FiltersDefault.dateTo,
                                  viewDetails: typeViewDetailSegmentControl.selectedSegmentIndex,
                                  quantityItemsByPage: quantityItemsByPageSegmentControl.selectedSegmentIndex,
                                  quantityCharactersAutoSearch: Int(quantityCharactersAutoSearchSlider.value))
        ManagerFilters().storeFilters(filters: filters)
    }
    
    @objc func pressCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
//    @objc func orderBySegmentControlChange() {
////        print(orderBySegmentControl.selectedSegmentIndex)
//    }
    
//    @objc func typeViewDetailSegmentControlChange() {
////        print(typeViewDetailSegmentControl.selectedSegmentIndex)
//    }
    
//    @objc func quantityItemsByPageSegmentControlChange() {
////        print(quantityItemsByPageSegmentControl.selectedSegmentIndex)
//    }
    
    @objc func quantityCharactersAutoSearchSliderChangeValue() {
        quantityCharactersAutoSearchCurrentLabel.text = "\(Int(quantityCharactersAutoSearchSlider.value))"
    }
    
    @objc func pressSaveButton() {
        saveFilters()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func pressResetButton() {
        resetFilters()
    }
}

extension FilterViewController: FilterProtocol {
    
}
