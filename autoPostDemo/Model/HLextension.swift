//
//  HLextension.swift
//  autoPostDemo
//
//  Created by novastar on 2024/8/19.
//

import Foundation
import SwiftyMenu

struct MealSize {
    let id: Int
    let name: String
    let token: String
    let userId: String
}
extension MealSize: SwiftyMenuDisplayable {
    public var displayableValue: String {
        return "\(self.id). \(self.name)"
    }

    public var retrievableValue: Any {
        return self.id
    }
    public var menuToken:String{
        return self.token
    }
    public var menuUserId:String{
        return self.userId
    }
}
extension ThreadsViewController:SwiftyMenuDelegate{
    // Get selected option from SwiftyMenu
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didSelectItem item: SwiftyMenuDisplayable, atIndex index: Int) {
        print("Selected item: \(item), at index: \(index)")
    }
    
    // SwiftyMenu drop down menu will expand
    func swiftyMenu(willExpand swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu willExpand.")
    }

    // SwiftyMenu drop down menu did expand
    func swiftyMenu(didExpand swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu didExpand.")
    }

    // SwiftyMenu drop down menu will collapse
    func swiftyMenu(willCollapse swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu willCollapse.")
    }

    // SwiftyMenu drop down menu did collapse
    func swiftyMenu(didCollapse swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu didCollapse.")
    }
}
