//
//  ViewController.swift
//  MusicApp
//
//  Created by 최윤호 on 2023/09/20.
//

import UIKit

final class MainViewController: UIViewController {
    
    let tableView = UITableView()
    
    let searchController : UISearchController = {
       let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "검색"
        controller.hidesNavigationBarDuringPresentation = false
        
        return controller
    }()
    
    var networkApi = MusicApi.shared
    
    var musicList : [Music] = [] {
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        setupSearchController()
        setupHideKeyboard()
        getMusicList(nil)
        
    }
    
    func getMusicList(_ term : String?) {
        networkApi.getMusic(searchTerm: term ?? "music") { result in
            switch result {
            case .success(let list):
                self.musicList = list
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "title"

    }
    
    func setupSearchController () {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.delegate = self
    }
    
    func setupHideKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismisskeyboard))
//        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismisskeyboard(){
        searchController.searchBar.endEditing(true)
    }
    
    func setupTableView() {
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.rowHeight = 120
        tableView.register(MusicCell.self, forCellReuseIdentifier: Cell.musicCellIdentifier)
        
    }
    
    override func loadView() {
        view = tableView
    }


}


extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath)
        guard let cell = cell as? MusicCell else {
            return UITableViewCell()
        }
        cell.music = musicList[indexPath.row]
        return cell
    }
    
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}


extension MainViewController : UISearchControllerDelegate {
    
}
