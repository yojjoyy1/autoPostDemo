//
//  ViewController.swift
//  autoPostDemo
//
//  Created by novastar on 2024/8/15.
//

import UIKit
import Alamofire
import Combine

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableV:HLTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
        
    }

    func initData(){
        if (tableV == nil){
            tableV = HLTableView(dependView: self.view)
            tableV.delegate = self
            tableV.dataSource = self
            tableV.hlDataArray.add("threads")
//            tableV.reloadData()
        }
    }
    
    //MARK: UITableViewDelegate/UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableV.hlDataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowStr = self.tableV.hlDataArray[indexPath.row] as! String
        if rowStr == "threads"{
            let vc = ThreadsViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.title = "threads"
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HLTableViewCell(style: .default, reuseIdentifier: "HLTableViewCell")
        let rowStr = self.tableV.hlDataArray[indexPath.row] as! String
        cell.titleLab.text = rowStr
        return cell
    }

}

