//
//  HeroHeaderUIView.swift
//  TrailerMateiOSApp
//
//  Created by IPH Technologies Pvt. Ltd on 21/04/22.
//

import UIKit


protocol HeroHeaderViewDelegate: NSObject{
    func playButtonTappedDelegate()
    func downloadButtonTappedDelegate()
}

class HeroHeaderUIView: UIView {
    
    //MARK: - Outlet
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let downlaodButton:UIButton = {
        let button = UIButton()
        button.setTitle("Downlaod", for: .normal)
        button.layer.borderWidth = AppConstants.borderWidth
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = true
        button.layer.cornerRadius = AppConstants.cornerRadius
        button.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let playButton:UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderWidth = AppConstants.borderWidth
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = true
        button.layer.cornerRadius = AppConstants.cornerRadius
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var delegate:HeroHeaderViewDelegate?
    
    //MARK: - function
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downlaodButton)
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.label.cgColor
        ]
        gradient.frame  = bounds
        layer.addSublayer(gradient)
        
    }
    
    @objc func playButtonTapped(){
        print("play button tapped")
        delegate?.playButtonTappedDelegate()
    }
    @objc func downloadButtonTapped(){
        print("download button tapped")
        delegate?.downloadButtonTappedDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyConstraints() {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        if UIDevice.current.userInterfaceIdiom == .pad {
            let leadingConstraint = playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant:200)
            let bottomConstraint = playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
            let widthConstraint = playButton.widthAnchor.constraint(equalToConstant: 150)
            let heightConstraint = playButton.heightAnchor.constraint(equalToConstant: 50)
            NSLayoutConstraint.activate([leadingConstraint, bottomConstraint, widthConstraint, heightConstraint])
            
            downlaodButton.translatesAutoresizingMaskIntoConstraints = false
            let downloadButtonConstraints = [
                downlaodButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -200),
                downlaodButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
                downlaodButton.widthAnchor.constraint(equalToConstant: 150),
                downlaodButton.heightAnchor.constraint(equalToConstant: 50)
            ]
            
            NSLayoutConstraint.activate(downloadButtonConstraints)
        }
        else {
            let leadingConstraint = playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant:80)
            let bottomConstraint = playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
            let widthConstraint = playButton.widthAnchor.constraint(equalToConstant: 100)
            NSLayoutConstraint.activate([leadingConstraint, bottomConstraint, widthConstraint])
            
            downlaodButton.translatesAutoresizingMaskIntoConstraints = false
            let downloadButtonConstraints = [
                downlaodButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
                downlaodButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
                downlaodButton.widthAnchor.constraint(equalToConstant: 100)
            ]
            
            NSLayoutConstraint.activate(downloadButtonConstraints)
        }
       
    }
    
    func configure(with model: TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }
        heroImageView.sd_setImage(with: url, completed: nil)
    }
}
