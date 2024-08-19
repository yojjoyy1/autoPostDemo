//
//  ThreadsViewController.swift
//  autoPostDemo
//
//  Created by novastar on 2024/8/16.
//

import UIKit
import SwiftyMenu

class ThreadsViewController: UIViewController {

    var dismissBtn:UIButton!
    var publishBtn:UIButton!
    var publishTextView:UITextView!
    var publishTextViewY:CGFloat = 0.0
    var tokenView:SwiftyMenu!
    var tokenMenuDataSourceArray:Array<SwiftyMenuDisplayable>!
    var currentMealSize = MealSize(id: 0, name: "unknow", token: "", userId: "")
    private var codeMenuAttributes = SwiftyMenuAttributes()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.publishTextViewY = self.publishTextView.frame.origin.y
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    //MARK: 自訂方法
    func setUpView(){
//        if #available(iOS 15.0, *){
//            let barAppearance = UINavigationBarAppearance()
//            barAppearance.configureWithOpaqueBackground()
//            barAppearance.backgroundColor = .white
//            self.navigationController?.navigationBar.standardAppearance = barAppearance
//            self.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
//            self.navigationController?.navigationBar.compactAppearance = barAppearance
//            self.navigationController?.navigationBar.compactScrollEdgeAppearance = barAppearance
//        }else{
//            self.navigationController?.navigationBar.barTintColor = .white
//        }
        self.navigationController?.navigationBar.isTranslucent = false
        if dismissBtn == nil{
            dismissBtn = UIButton(frame: .zero)
            dismissBtn.setTitle("退回", for: .normal)
            dismissBtn.setTitleColor(.red, for: .normal)
            dismissBtn.backgroundColor = .lightGray
            dismissBtn.translatesAutoresizingMaskIntoConstraints = false
            dismissBtn.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
            self.view.addSubview(dismissBtn)
            
            let leading = NSLayoutConstraint(item: dismissBtn, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 10)
            let botoom = NSLayoutConstraint(item: dismissBtn, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -10)
            let trailing = NSLayoutConstraint(item: dismissBtn, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -10)
            let height = NSLayoutConstraint(item: dismissBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60)
            NSLayoutConstraint.activate([leading,trailing,botoom,height])
        }
        if tokenView == nil{
            tokenView = SwiftyMenu(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
            tokenView.backgroundColor = .white
            self.view.addSubview(tokenView)
            tokenView.translatesAutoresizingMaskIntoConstraints = false

            let leading = NSLayoutConstraint(item: tokenView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 50)
            let trailing = NSLayoutConstraint(item: tokenView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -50)
            let top = NSLayoutConstraint(item: tokenView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: UIApplication.shared.statusBarFrame.height + 10)
            tokenView.heightConstraint = NSLayoutConstraint(item: tokenView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)
            NSLayoutConstraint.activate([leading,trailing,top,tokenView.heightConstraint])
            
            tokenMenuDataSourceArray = [
                MealSize(id: 1, name: "user1", token: "user1Token", userId: "user1Userid"),
                MealSize(id: 2, name: "user2", token: "user2Token", userId: "user2Userid"),
                MealSize(id: 3, name: "user3", token: "user3Token", userId: "user3Userid"),
                MealSize(id: 4, name: "user4", token: "user4Token", userId: "user4Userid")
            ]
            tokenView.items = tokenMenuDataSourceArray
            tokenView.delegate = self
            codeMenuAttributes.placeHolderStyle = .value(text: "選擇發送貼文的帳號", textColor: .lightGray)
            codeMenuAttributes.textStyle = .value(color: .gray, separator: "&", font: .systemFont(ofSize: 14))
            codeMenuAttributes.scroll = .disabled
            codeMenuAttributes.multiSelect = .disabled
            codeMenuAttributes.hideOptionsWhenSelect = .enabled
            codeMenuAttributes.rowStyle = .value(height: 50, backgroundColor: .white, selectedColor: .white)
            codeMenuAttributes.roundCorners = .all(radius: 8)
            codeMenuAttributes.height = .value(height: 300)
            codeMenuAttributes.border = .value(color: .gray, width: 0.5)
            codeMenuAttributes.arrowStyle = .value(isEnabled: true, image: nil)
            codeMenuAttributes.separatorStyle = .value(color: .black, isBlured: false, style: .singleLine)
            codeMenuAttributes.headerStyle = .value(backgroundColor: .white, height: 50)
            codeMenuAttributes.accessory = .disabled
            tokenView.configure(with: codeMenuAttributes)
            /// SwiftyMenu also supports `CallBacks`
            tokenView.didSelectItem = { 
                menu, item, index in
                self.currentMealSize = item as! MealSize
                print("Selected \(item) at index: \(index)")
            }

            tokenView.willExpand = {
                print("SwiftyMenu Will Expand!")
            }

            tokenView.didExpand = {
                print("SwiftyMenu Expanded!")
            }

            tokenView.willCollapse = {
                print("SwiftyMenu Will Collapse!")
            }

            tokenView.didCollapse = {
                print("SwiftyMenu Collapsed!")
            }
        }
        if publishBtn == nil{
            publishBtn = UIButton(frame: .zero)
            publishBtn.setTitle("發送到threads", for: .normal)
            publishBtn.setTitleColor(.blue, for: .normal)
            publishBtn.backgroundColor = .lightGray
            publishBtn.translatesAutoresizingMaskIntoConstraints = false
            publishBtn.addTarget(self, action: #selector(self.publishThreads), for: .touchUpInside)
            self.view.addSubview(publishBtn)
            
            let leading = NSLayoutConstraint(item: publishBtn, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 10)
            let botoom = NSLayoutConstraint(item: publishBtn, attribute: .bottom, relatedBy: .equal, toItem: dismissBtn, attribute: .top, multiplier: 1.0, constant: -10)
            let trailing = NSLayoutConstraint(item: publishBtn, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -10)
            let height = NSLayoutConstraint(item: publishBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60)
            NSLayoutConstraint.activate([leading,trailing,botoom,height])
        }
        if publishTextView == nil{
            publishTextView = UITextView(frame: .zero)
            publishTextView.backgroundColor = .white
            publishTextView.textColor = .black
            publishTextView.layer.borderWidth = 1
            publishTextView.layer.borderColor = UIColor.lightGray.cgColor
            publishTextView.textAlignment = .left
            publishTextView.isEditable = true
            publishTextView.isSelectable = true
            publishTextView.isScrollEnabled = true
            self.view.addSubview(publishTextView)
            publishTextView.translatesAutoresizingMaskIntoConstraints = false
            
            let leading = NSLayoutConstraint(item: publishTextView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 10)
            let botoom = NSLayoutConstraint(item: publishTextView, attribute: .bottom, relatedBy: .equal, toItem: publishBtn, attribute: .top, multiplier: 1.0, constant: -10)
            let trailing = NSLayoutConstraint(item: publishTextView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -10)
            let height = NSLayoutConstraint(item: publishTextView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200)
            NSLayoutConstraint.activate([leading,trailing,botoom,height])
        }
    }
    
    //MARK: button按鈕方法
    @objc func backAction(){
        self.dismiss(animated: true)
    }
    @objc func publishThreads(){
        if !self.publishTextView.text.isEmpty{
            HLRequestModel.publishTreads(content: self.publishTextView.text, userId: self.currentMealSize.userId, access_token: self.currentMealSize.token)
            self.publishTextView.text = ""
        }
        print("publishThreads")
    }
    //MARK: 鍵盤方法
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardY = keyboardFrame.cgRectValue.origin.y
        let keyboardHeight = keyboardFrame.cgRectValue.height
        adjustContentInsetForKeyboard(y: keyboardY,height: keyboardHeight)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        adjustContentInsetForKeyboard(y: self.view.frame.size.height,height: 0)
    }
    func adjustContentInsetForKeyboard(y: CGFloat,height:CGFloat) {
//        print("minY:\(self.publishTextView.frame.minY),maxY:\(self.publishTextView.frame.maxY)\n鍵盤Y:\(y),鍵盤高度:\(height)")
        UIView.animate(withDuration: 0.3) {
            if self.publishTextView.frame.maxY > y {
                self.publishTextView.frame.origin.y = self.publishTextView.frame.origin.y - (self.publishTextView.frame.maxY - y)
            }else{
                self.publishTextView.frame.origin.y = self.publishTextViewY
            }
        }
    }
}
