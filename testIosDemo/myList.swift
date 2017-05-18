//
//  myList.swift
//  testIosDemo
//
//  Created by AKMAC01 on 18/5/17.
//  Copyright © 2017 AKMAC01. All rights reserved.
//

import UIKit

class myList: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    let dataLocal:NSUserDefaults = NSUserDefaults.standardUserDefaults() // to pass data between controllers
    
    @IBOutlet weak var collectionBuy: UICollectionView!
    @IBOutlet weak var stock: UIBarButtonItem!
    
    let reuseIdentifier = "buyCell"
    var dataProducts = [[String: AnyObject]]()
    var dataProductsAux = [[String: AnyObject]]()
    var dataList = [[String: AnyObject]]()
    var score: Int = 0
    var bill: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionBuy.delegate = self;
        collectionBuy.dataSource = self;
        list()
        scoreCorner()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func list(){
        let value = dataLocal.valueForKey("dataList")
        if value != nil{
            dataProductsAux = value as! [[String: AnyObject]]
            dataProducts = dataProductsAux
        }
        collectionBuy.reloadData()
    }

    
    @IBAction func back(sender: AnyObject) {
        performSegueWithIdentifier("Home", sender: nil)
    }
    
    //MARK colecction views...
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var screenWidth = collectionBuy.bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        let screenwidthaux = UIScreen.mainScreen().bounds.size.width
        if screenwidthaux <= screenHeight{
            screenWidth = collectionBuy.bounds.size.width
        }else if screenwidthaux > screenHeight{
            screenWidth = screenHeight
        }
        return CGSize(width: screenWidth, height: 100)
    }
    
    func numberOfSectionsInCollectionView(collectionView:
        UICollectionView) -> Int {
            return 1
    }
    
    func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            return dataProducts.count
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) ->
        UICollectionViewCell {
            //let aliasMe = dataSession.valueForKey("alias") as? String
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier,
                forIndexPath: indexPath) as! buyCell
            
            let details = dataProducts[indexPath.row]
            cell.nameProduct.text = details["name"] as? String
            cell.price.text = String("Price: \(details["price"] as! Float) $")
            cell.cancel.tag = indexPath.row
            cell.cancel.addTarget(self, action: "addToList:", forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
    }
    func addToList(sender: UIButton){
        var item = dataProducts[sender.tag]
        dataList = dataLocal.valueForKey("dataProducts") as! [[String: AnyObject]]
        var count = 0
        var indexL = 0
        for itemList in dataList{
            if itemList["id"] as! Int == item["id"] as! Int{
                indexL = count
            }
            count++
        }
        let newD = dataList[indexL]
        var newStoc = (newD["stock"] as! Int)
        newStoc++
        dataList[indexL] = ["id": newD["id"]!, "name": newD["name"]!, "price": newD["price"]!, "stock":  newStoc]
        print(dataList[indexL])
        
        bill = Float(bill - (item["price"] as! Float))
        score--
        
        dataProducts.removeAtIndex(sender.tag)
        
        dataLocal.setValue(dataProducts, forKey: "dataList")
        
        dataLocal.setValue(dataList, forKey: "dataProducts")
        
        
        dataLocal.setValue(bill, forKey: "bill")
        dataLocal.setValue(score, forKey: "score")
        scoreCorner()
        list()
        collectionBuy.reloadData()
    }
    func scoreCorner(){
        let lscore = dataLocal.valueForKey("score")
        let lbill = dataLocal.valueForKey("bill")
        if lscore != nil && lbill != nil{
            score = lscore as! Int
            bill = lbill as! Float
        }
        stock.title = "score: \(score), $: \(bill)"
    }

}
