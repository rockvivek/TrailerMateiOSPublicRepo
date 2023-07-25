//
//  VideoPreviewViewController.swift
//  TrailerMateiOSApp
//
//  Created by IPH Technologies Pvt. Ltd on 26/04/22.
//

import UIKit
import WebKit

class VideoPreviewViewController: UIViewController {

    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry Porter"
        return label
    }()
    
    private let overviewLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "This is the best movie to watch."
        label.numberOfLines = 0
        return label
    }()
    
    private let webView:WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    private let downlaodButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Download", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = AppConstants.cornerRadius
        button.layer.masksToBounds = true
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(webView)
        view.addSubview(downlaodButton)
        view.backgroundColor = .systemBackground
        applyConstraints()
    }

    func applyConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        let webViewConstraints = [
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        NSLayoutConstraint.activate(webViewConstraints)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        let overviewLabelConstraints = [
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(overviewLabelConstraints)
        
        downlaodButton.translatesAutoresizingMaskIntoConstraints = false
        let downlaodButtonConstraints = [
            downlaodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downlaodButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 50),
            downlaodButton.widthAnchor.constraint(equalToConstant: 140),
            downlaodButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(downlaodButtonConstraints)
    }
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.videoView.id.videoId)") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
}
