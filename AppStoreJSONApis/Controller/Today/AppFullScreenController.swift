//
//  AppFullScreenController.swift
//  AppStoreJSONApis
//
//  Created by user on 20/03/2023.
//

import UIKit

class AppFullScreenController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        450
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            let tableViewCell = UITableViewCell()
            let todayCell = TodayCell()
            tableViewCell.contentView.addSubview(todayCell.contentView)
            todayCell.contentView.centerInSuperview(size: .init(width: 250, height: 250))
            return tableViewCell
        }
        
        let cell = AppDescriptionCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        450
    }

    
    
}
