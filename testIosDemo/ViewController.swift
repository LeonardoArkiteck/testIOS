//
//  ViewController.swift
//  testIosDemo
//
//  Created by AKMAC01 on 18/5/17.
//  Copyright © 2017 AKMAC01. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
    let dataLocal:NSUserDefaults = NSUserDefaults.standardUserDefaults() // to pass data between controllers
    
    @IBOutlet weak var collectionProducts: UICollectionView!
    
    @IBOutlet weak var stock: UIBarButtonItem!
    
    var dataProducts = [[String: AnyObject]]()
    var dataProductsAux = [[String: AnyObject]]()
    var dataList = [[String: AnyObject]]()
    let reuseIdentifier = "productsCell"
    var score: Int = 0
    var bill: Float = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionProducts.delegate = self;
        collectionProducts.dataSource = self;
        list()
        scoreCorner()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToList(sender: AnyObject) {
        performSegueWithIdentifier("MyList", sender: nil)
    }
    
    func list(){
        //dataProducts
        
        let value = dataLocal.valueForKey("dataProducts")
        let list = dataLocal.valueForKey("dataList")
        if value == nil{
            dataProductsAux = [
                [
                    "id":1,
                    "name":"Movistar tv",
                    "price":20.5,
                    "stock":20
                ],
                [
                    "id":2,
                    "name":"Decodificador HD",
                    "price":14,
                    "stock":30
                ],
                [
                    "id":3,
                    "name":"Antena",
                    "price":8.7,
                    "stock":62
                ],
                [
                    "id":4,
                    "name":"Descodificador Basico",
                    "price":20.5,
                    "stock":20
                ],
                [
                    "id":5,
                    "name":"Cargador inalambrico",
                    "price":10.5,
                    "stock":60
                ],
                [
                    "id":6,
                    "name":"Bam internet portatil",
                    "price":50,
                    "stock":82
                ],
                [
                    "id":7,
                    "name":"Laptop HP",
                    "price":142,
                    "stock":8
                ],
                [
                    "id":8,
                    "name":"Microfono siragon",
                    "price":26,
                    "stock":200
                ],
                [
                    "id":9,
                    "name":"Altavoces envolventes",
                    "price":33,
                    "stock":125
                ],
                [
                    "id":10,
                    "name":"Memoria USB 16GB",
                    "price":5,
                    "stock":600
                ],
                [
                    "id":11,
                    "name":"Disco duro 1TB",
                    "price":520,
                    "stock":15
                ],
                [  
                    "id":12,
                    "name":"Memoria RAM 4GB",
                    "price":130,
                    "stock":63
                ],
                [  
                    "id":13,
                    "name":"Mouse USB",
                    "price":15,
                    "stock":400
                ],
                [  
                    "id":14,
                    "name":"Teclado inalambrico",
                    "price":30,
                    "stock":587
                ],
                [  
                    "id":15,
                    "name":"Camara web",
                    "price":30,
                    "stock":65
                ],
                [  
                    "id":16,
                    "name":"Monitor LCD 20 p ",
                    "price":230,
                    "stock":123
                ],
                [  
                    "id":17,
                    "name":"Disco duro 500GB",
                    "price":340,
                    "stock":69
                ],
                [  
                    "id":18,
                    "name":"Motorola MOTO G 2da generacion",
                    "price":120,
                    "stock":64
                ],
                [  
                    "id":19,
                    "name":"Monitor LG 30p",
                    "price":290,
                    "stock":15
                ],
                [  
                    "id":20,
                    "name":"Memoria USB 128GB",
                    "price":50,
                    "stock":36
                ],
                [  
                    "id":21,
                    "name":"Laptop DELL",
                    "price":290,
                    "stock":87
                ]
            ]
            dataProducts = dataProductsAux
        }else{
            dataProductsAux = value as! [[String: AnyObject]]
            for item in dataProductsAux{
                if item["stock"] as! Int > 0{
                    dataProducts.append(item)
                }
            }
            
        }
        if list != nil{
            dataList = list as! [[String: AnyObject]]
        }
        collectionProducts.reloadData()
    }
    
    
    
    //MARK colecction views...
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var screenWidth = collectionProducts.bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        let screenwidthaux = UIScreen.mainScreen().bounds.size.width
        if screenwidthaux <= screenHeight{
            screenWidth = collectionProducts.bounds.size.width
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
                forIndexPath: indexPath) as! productCell
            
            let details = dataProducts[indexPath.row]

            cell.nameProduct.text = details["name"] as? String
            
            cell.price.text = String("Price: \(details["price"] as! Float) $")
            cell.stock.text = String("Stock: \(details["stock"] as! Int)")
            
            
            cell.buy.tag = indexPath.row
            cell.buy.addTarget(self, action: "addToList:", forControlEvents: UIControlEvents.TouchUpInside)
            
            
            return cell
    }
    
    func addToList(sender: UIButton){
        var item = dataProducts[sender.tag]
        let newStock: Int = (item["stock"] as! Int) - 1
        dataList.append(["id": item["id"]!, "name": item["name"]!, "price": item["price"]!, "stock": 1])
        dataProducts[sender.tag] = ["id": item["id"]!, "name": item["name"]!, "price": item["price"]!, "stock": newStock]
        
        dataLocal.setValue(dataProducts, forKey: "dataProducts")
        dataLocal.setValue(dataList, forKey: "dataList")
        
        bill = Float(bill + (item["price"] as! Float))
        score++
        dataLocal.setValue(bill, forKey: "bill")
        dataLocal.setValue(score, forKey: "score")
        scoreCorner()
        list()
        collectionProducts.reloadData()
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

