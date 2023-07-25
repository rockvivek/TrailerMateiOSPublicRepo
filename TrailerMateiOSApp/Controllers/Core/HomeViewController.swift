//
//  HomeViewController.swift
//  TrailerMateiOSApp
//
//  Created by IPH Technologies Pvt. Ltd on 21/04/22.
//

import UIKit
import AVKit

enum Sections:Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {

    let sectionTitles: [String] = [
        "Trending Movies", "trending Tv", "Popular", "Upcoming Movies", "Top Rated"
    ]
    
    private var randomTrendingMovie: Title?
    private var headerView: HeroHeaderUIView?
    
    private let homeFeedTable:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        headerView =  HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        headerView?.delegate = self
        homeFeedTable.tableHeaderView = headerView
        configureNavBar()
        configureHeroHeaderView()
    }
    
    func configureHeroHeaderView(){
        APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let title):
                let selectedTitle = title.randomElement()
                self.randomTrendingMovie = selectedTitle
                self.headerView?.configure(with: TitleViewModel(titleName: (selectedTitle?.original_title ?? selectedTitle?.original_name) ?? "Unknown Name", posterURL: selectedTitle?.poster_path ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
        
    }
    
    private func configureNavBar(){
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        let person =  UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(didTapShareButton))
        person.tintColor = .label
        
        let myFrame = CGRect(x: 100, y: 200, width: 50, height: 50)
        let routePickerView = AVRoutePickerView.init(frame: myFrame)
        routePickerView.backgroundColor = UIColor.clear
        routePickerView.tintColor = UIColor.label
        routePickerView.activeTintColor = UIColor.blue
        routePickerView.delegate = self
        view.addSubview(routePickerView)
        
        let play = UIBarButtonItem(customView: routePickerView)
        play.tintColor = .label
        navigationItem.rightBarButtonItems = [
            person, play
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func didTapShareButton() {
        let vc = UIActivityViewController(activityItems: ["https://apps.apple.com/us/app/fun-fast-maths/id1480981107"], applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = self.view
                
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func playButtonTapped() {
        print("play button tapped")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
    
    private func getTrendingMovies(){
        APICaller.shared.getUpcomingMovies{ result in
            switch result {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: -TableviewDelegates
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { results in
                switch  results {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvs { results in
                switch  results {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular { results in
                switch  results {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies{ results in
                switch  results {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                 case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated { results in
                switch  results {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            print("default")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.size.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.lowercased()
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}


extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTap(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async {
            let vc = VideoPreviewViewController()
            vc.configure(with: viewModel)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}


extension HomeViewController: HeroHeaderViewDelegate {
    func playButtonTappedDelegate() {
        guard let titleName = randomTrendingMovie?.original_name ?? randomTrendingMovie?.original_title,
              let overview = randomTrendingMovie?.overview else {
            return
        }
        APICaller.shared.getMovie(with: titleName) {[weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let viewModel = TitlePreviewViewModel(title: titleName, videoView: videoElement, titleOverview: overview)
                    let vc = VideoPreviewViewController()
                    vc.configure(with: viewModel)
                    self?.navigationController?.pushViewController(vc, animated: false)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func downloadButtonTappedDelegate() {
        guard let title = randomTrendingMovie else { return }
        DataPersistenceManager.shared.downloadTitleWith(model: title) { result in
            switch result {
            case .success():
                print("downlaoded")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "downloaded") , object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension HomeViewController: AVRoutePickerViewDelegate {
    func routePickerViewWillBeginPresentingRoutes(_ routePickerView: AVRoutePickerView) {
        print("present routing")
    }
    func routePickerViewDidEndPresentingRoutes(_ routePickerView: AVRoutePickerView) {
        print("end routing")
    }
}
