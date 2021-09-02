import UIKit
import Kingfisher

class NewCellItem: UITableViewCell {

    private lazy var titleLabel = UILabel(frame: .zero)
    private lazy var sectionLabel = UILabel(frame: .zero)
    private lazy var dateLabel = UILabel(frame: .zero)
    private lazy var starRatingView = StarRatingView(frame: .zero)
    private lazy var image = UIImageView(frame: .zero)
    private lazy var separetor = UIView(frame: .zero)
    
    var currentNew: NewsModel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        addSubviews()
        addConstraints()
        addStyle()
        addConfigurations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(sectionLabel)
        addSubview(dateLabel)
        addSubview(starRatingView)
        addSubview(image)
    }
    
    func addStyle() {
        titleLabel.font = .medium(14)
        titleLabel.numberOfLines = 4
        titleLabel.minimumScaleFactor = 0.7
        titleLabel.textColor = .black
        
        sectionLabel.font = .medium(12)
        sectionLabel.textColor = .gray
        
        dateLabel.font = .medium(12)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
        
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .lightGray.withAlphaComponent(0.2)
    }

    func addConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(image.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(14)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        starRatingView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(image.snp.trailing).offset(10)
            make.width.equalTo(70)
        }
        
        sectionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(starRatingView.snp.top).offset(-10)
            make.leading.equalTo(image.snp.trailing).offset(10)
        }
                
        image.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(0)
            make.width.equalTo(180)
        }
    }

    func addConfigurations() {
        let bgColorView = UIView()
        bgColorView.backgroundColor = .primaryColor.withAlphaComponent(0.5)
        selectedBackgroundView = bgColorView
    }
    
    func configure(forNew new: NewsModel?) {
        currentNew = new
        
        titleLabel.text = new?.webTitle
        if let quantity = new?.fields?.starRating {
            starRatingView.configure(forQuantityStars: quantity)
        }
        sectionLabel.text = new?.sectionName
        
        if let date = new?.webPublicationDate?.getFormattedDate(
            fromFormat: Constants.Date.dateServerFormat,
            toNewFormat: Constants.Date.newsFormat) {
            dateLabel.text = date
            if let date = date.getFormattedToDate(fromFormat: Constants.Date.newsFormat) {
                dateLabel.text = date.timeAgoDisplay()
            }
        } else {
            dateLabel.text = new?.webPublicationDate
        }

        if let url = URL(string: new?.fields?.thumbnail ?? "") {
            image.kf.setImage(with: url, placeholder: CommonAssets.iconGrayApp.image)
            image.clipsToBounds = true
        }
    }
}
