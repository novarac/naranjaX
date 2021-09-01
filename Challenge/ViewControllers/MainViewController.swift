import UIKit

public protocol MainViewProtocol: AnyObject {
    
}

class MainViewController: BaseViewController {
    
    private lazy var mainTableView = UITableView(frame: .zero)
    private lazy var thereAreNotNewsLabel = UILabel(frame: .zero)
    private lazy var thereAreNotNewsImage = UIImageView(frame: .zero)
    
    override func addSubviews() {
        view.addSubview(mainTableView)
        view.addSubview(thereAreNotNewsLabel)
        view.addSubview(thereAreNotNewsImage)
    }
    
    override func addStyle() {
        view.backgroundColor = .white

        mainTableView.backgroundColor = .lightGray.withAlphaComponent(0.5)
        mainTableView.separatorStyle = .none
        mainTableView.separatorColor = .secondaryColor
        
        thereAreNotNewsImage.contentMode = .scaleAspectFit
        thereAreNotNewsImage.image = CommonAssets.noNews.image.withRenderingMode(.alwaysTemplate)
        thereAreNotNewsImage.tintColor = .gray.withAlphaComponent(0.3)
        
        thereAreNotNewsLabel.font = .medium(14)
        thereAreNotNewsLabel.textColor = .gray.withAlphaComponent(0.3)
        thereAreNotNewsLabel.textAlignment = .center
    }
    
    override func addConstraints() {
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        thereAreNotNewsImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.height.equalTo(60)
        }
        
        thereAreNotNewsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(thereAreNotNewsImage.snp.bottom).offset(10)
        }
    }
    
    override func addConfiguration() {
        title = "title_home".localized
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 100
        mainTableView.tableFooterView = UIView()
        
        thereAreNotNewsLabel.text = "noNewsToShow".localized
        thereAreNotNewsLabel.isHidden = false
        thereAreNotNewsImage.isHidden = false
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
