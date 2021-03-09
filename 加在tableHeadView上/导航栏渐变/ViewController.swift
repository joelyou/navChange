//
//  ViewController.swift
//  导航栏渐变
//
//  Created by ty on 16/1/3.
//  Copyright © 2016年 ty. All rights reserved.
//

import UIKit

// 顶部图片的高度
private let topImageHeight: CGFloat = 200
// 顶部图片
private var topImag: UIImageView?
// 自定义导航栏
private var customNavc: UIView?
// 自定义返回按钮
private var customBackBtn: UIButton?
// 当导航栏透明的时候 加载在view上的按钮
private var viewBackBtn: UIButton?
// 自定义导航栏标题
private var customTitleLabel: UILabel?
// // 当导航栏透明的时候 加载在view上的标题
private var viewTitleLabel: UILabel?

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    //顶部的图片和View
    lazy var headerImageViewTop:UIImageView = {
        let header = UIImageView(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:200))
        header.backgroundColor = UIColor.red
        header.image = UIImage(named: "ceshi.jpg")
        header.contentMode = UIView.ContentMode.scaleAspectFill
        header.clipsToBounds = true
        return header
    }()
    // 懒加载headerView
    lazy var headerBackView:UIView = {
        let headerView = UIView.init(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:200))
        headerView.backgroundColor = UIColor.lightGray
        return headerView
    }()
    
    
    
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        
        table.tableHeaderView = self.headerBackView
        self.headerBackView.addSubview(self.headerImageViewTop)
        return table
    }()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(tableView)

//        // tableView
//        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
//        tableView.delegate = self
//        tableView.dataSource = self;
//        view.addSubview(tableView)
//        tableView.contentInset = UIEdgeInsets(top: topImageHeight, left: 0, bottom: 0, right: 0)
//        tableView.addSubview(topImage)
        if #available(iOS 11.0, *) { //不加 则offset会多出statusBarFrame的高度
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        
        // 自定义导航栏
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 64))
        view.addSubview(backView)
        backView.backgroundColor = UIColor.white
        backView.alpha = 0.0
        customNavc = backView
        
        // 自定义返回按钮
        let backBtn = UIButton(frame: CGRect(x: 0, y: 20, width: 40, height: 44))
        backBtn.setImage(UIImage(named: "back_0"), for: .normal)
        backView.addSubview(backBtn)
        customBackBtn = backBtn
        
        // 返回按钮
        let btn = UIButton(frame: CGRect(x: 0, y: 20, width: 40, height: 44))
        btn.setImage(UIImage(named: "back_0"), for: .normal)
        view.addSubview(btn)
        viewBackBtn = btn
        
        // 自定义标题
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        titleLabel.center = CGPoint(x: view.frame.width / 2, y: 20 + 22)
        titleLabel.text = "标题"
        titleLabel.textColor = UIColor.white
        customTitleLabel = titleLabel
        customNavc?.addSubview(titleLabel)
        
        // 标题
        let viewTitleLabe = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        viewTitleLabe.center = CGPoint(x: view.frame.width / 2, y: 20 + 22)
        viewTitleLabe.text = "标题"
        viewTitleLabe.textColor = UIColor.black
        viewTitleLabel = viewTitleLabe
        view?.addSubview(titleLabel)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        cell!.textLabel!.text = "cell\(indexPath.row)"
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offY = scrollView.contentOffset.y
        print("offY = \(offY)")
        // 根据偏移量改变alpha的值
        customNavc?.alpha =  offY/(topImageHeight - 64)
        // 改变导航栏（自定义View）返回按钮的图片 和 标题颜色
        if offY >= 200 - 64 {
            customBackBtn?.setImage(UIImage(named: "back_1"), for: .normal)
            viewBackBtn?.isHidden = true
            customTitleLabel?.textColor = UIColor.black
        } else {
            customBackBtn?.setImage(UIImage(named: "back_0"), for: .normal)
            viewBackBtn?.isHidden = false
            customTitleLabel?.textColor = UIColor.white
        }
        
        let imageWeight:CGFloat = headerImageViewTop.frame.size.width
        //上下偏移量
        let imageOffsetY:CGFloat = scrollView.contentOffset.y
        //上移
        if imageOffsetY < 0 {
            let totalOffset:CGFloat = 200 + abs(imageOffsetY)
            if abs(imageOffsetY)>200 {
                return
            }
            self.headerImageViewTop.frame = CGRect(x:0,y:imageOffsetY,width: imageWeight,height:totalOffset)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

