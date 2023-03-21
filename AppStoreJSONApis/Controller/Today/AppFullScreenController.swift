//
//  AppFullScreenController.swift
//  AppStoreJSONApis
//
//  Created by user on 20/03/2023.
//

import UIKit

class AppFullScreenController: UITableViewController {
    
    var todayItem: TodayItem?
    var dismissHandler: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = .init(top: 0, left: 0, bottom: 48, right: 0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            let cell = AppFullScreenHeaderCell()
            cell.closeButton.addTarget(self, action: #selector(didTapped(handler:)), for: .touchUpInside)
            cell.todayCell.todayItem = todayItem
            cell.todayCell.contentView.layer.cornerRadius = 0
            return cell
        }
        
        let cell = AppDescriptionCell()
        return cell
    }
    
    @objc private func didTapped(handler: UIButton) {
        handler.isHidden = true
        dismissHandler?()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return 400
        }
            
        return super.tableView(tableView, heightForRowAt: indexPath)
        
    }

    
    
}
