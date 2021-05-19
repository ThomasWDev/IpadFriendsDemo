//
//  FDDashboardVC.swift
//  IpadFriendsDemo
//
//  Created by Thomas Woodfin on 5/19/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

class FDDashboardVC: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    private var refreshControl = UIRefreshControl()
    private var activityIndicatorView: ActivityIndicatorView!
    private let viewModel = FDDashboardVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPullToRefresh()
        getData()
    }

    private func setupPullToRefresh(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        getData()
    }
    
    private func setupIndicator(){
        self.activityIndicatorView = ActivityIndicatorView(title: "Processing...", center: self.view.center)
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
    }
    
    private func getData(){
        setupIndicator()
        self.activityIndicatorView.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        viewModel.getFriendList {[weak self] (success) in
            
            self?.activityIndicatorView.stopAnimating()
            self?.view.isUserInteractionEnabled = true
            
            if success{
                self?.tableView.reloadData()
            }
        }
    }

}

extension FDDashboardVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.getFriendList()?.count == 0 {
            Helper.emptyMessageInTableView(tableView, "No data available")
        }else{
            tableView.backgroundView = nil
        }

        return viewModel.getFriendList()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: FDDashboardCell.identifier, for: indexPath) as! FDDashboardCell
        cell.configureCell(vm: viewModel, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showEventDetailsVC(index: indexPath.row)
    }

    private func showEventDetailsVC(index: Int){
        let storyboard = UIStoryboard(storyboard: .dashboard)
        let vc = storyboard.instantiateViewController(withIdentifier: FDDetailsVC.self)
        vc.viewModel = self.viewModel
        vc.currentIndex = index
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
