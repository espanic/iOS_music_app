//
//  CustomCell.swift
//  MusicApp
//
//  Created by 최윤호 on 2023/09/20.
//

import UIKit

class MusicCell: UITableViewCell {
    
    var music : Music? = nil {
        didSet{
            titleLabel.text = music?.songName
            genreLabel.text = music?.artistName
            albumLabel.text = music?.albumName
            dateLabel.text = music?.releaseDateString
            loadImage(imageUrl: music?.imageUrl)
        }
    }
    
    let musicThumbnailView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.init(252), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genreLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.setContentHuggingPriority(.init(252), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let albumLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .natural
        label.numberOfLines = 3
        label.setContentHuggingPriority(.init(251), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.setContentHuggingPriority(.init(252), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.setContentHuggingPriority(.init(250), for: .vertical)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
        setupConstraints()
        selectionStyle = .none
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented!")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupSubViews(){
        contentView.addSubview(musicThumbnailView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(albumLabel)
        stackView.addArrangedSubview(dateLabel)
    }
    

    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            musicThumbnailView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            musicThumbnailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            musicThumbnailView.heightAnchor.constraint(equalToConstant: 100),
            musicThumbnailView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: musicThumbnailView.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    func loadImage(imageUrl : String?) {
        guard let imageUrl = imageUrl else {
            return
        }
        guard let url = URL(string: imageUrl) else {return}
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {return }
            DispatchQueue.main.async { [weak self] in
                self?.musicThumbnailView.image = UIImage(data: data)
            }
        }
        
    }

}
