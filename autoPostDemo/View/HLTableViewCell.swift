//
//  HLTableViewCell.swift
//  autoPostDemo
//
//  Created by novastar on 2024/8/16.
//

import UIKit

class HLTableViewCell: UITableViewCell {

    var titleLab:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 自訂方法
    func setUpView(){
        self.backgroundColor = .white
        if titleLab == nil{
            titleLab = UILabel()
            titleLab.textColor = .black
            titleLab.textAlignment = .center
            titleLab.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(titleLab)
            
            let leading = NSLayoutConstraint(item: titleLab, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 10)
            let top = NSLayoutConstraint(item: titleLab, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 5)
            let bottom = NSLayoutConstraint(item: titleLab, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: -5)
            let width = NSLayoutConstraint(item: titleLab, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 300)
            let trailing = NSLayoutConstraint(item: titleLab, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: -10)
            NSLayoutConstraint.activate([leading,top,bottom,trailing])
        }
    }
}
