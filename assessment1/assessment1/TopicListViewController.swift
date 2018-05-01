//
//  MasterViewController.swift
//  assessment1
//
//  Created by Admin on 2018-04-30.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import SDWebImage

class TopicListViewController: UITableViewController {

    lazy var viewModel: TopicListViewModel = {
        return TopicListViewModel(apiService: APIService())
    }()
    
    var detailViewController: TopicDetailViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? TopicDetailViewController
        }
        
        viewModel.reloadTableViewClosure = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel.load()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let cellModel  = viewModel.getCellViewModel(at: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! TopicDetailViewController
                //controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
        let cellViewModel = viewModel.getCellViewModel( at: indexPath )
        cell.lblTitle.text = cellViewModel.titleText
        if let iconURL = cellViewModel.iconURL {
            cell.imgView.sd_setImage(with: iconURL, placeholderImage: nil)
        } else {
            cell.imgView?.image = nil
        }
        return cell
    }
}

