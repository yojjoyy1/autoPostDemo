//
//  HLTableView.swift
//  autoPostDemo
//
//  Created by novastar on 2024/8/15.
//

import UIKit

class HLTableView: UITableView {

    var hlDataArray:NSMutableArray!
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    init(dependView:UIView){
        super.init(frame: .zero, style: .plain)
        self.createView(dependView: dependView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 自訂方法
    private func createView(dependView:UIView){
        hlDataArray = NSMutableArray()
        self.backgroundColor = .white
        self.tableFooterView = UIView()
        self.tableHeaderView = UIView()
        self.register(HLTableViewCell.self, forCellReuseIdentifier: "HLTableViewCell")
        dependView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        let leading = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: dependView, attribute: .leading, multiplier: 1.0, constant: 10)
        let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: dependView, attribute: .top, multiplier: 1.0, constant: 10)
        let trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: dependView, attribute: .trailing, multiplier: 1.0, constant: -10)
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: dependView, attribute: .bottom, multiplier: 1.0, constant: -10)
        NSLayoutConstraint.activate([leading,top,trailing,bottom])
    }
    
}
