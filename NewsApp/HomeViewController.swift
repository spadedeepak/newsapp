//
//  HomeViewController.swift
//  NewsApp
//
//  Created by deepak on 15/09/23.
//

import UIKit



class HomeViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var colview: UICollectionView!
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    @IBOutlet weak var flow: UICollectionViewFlowLayout!
    
    @IBOutlet var tblview: UITableView!
    var cat = [String]()
    var currentCountry = "";
   var countryList = [String]()
    var happy : Happy!
    var url = "";
    override func viewDidLoad() {
        super.viewDidLoad()

       
        currentCountry = "in"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        cat = ["India","US","China"]
        countryList = ["in","us","cn"]
        self.title = "NEWS"
        colview.delegate = self
        colview.dataSource = self
        tblview.delegate = self
        tblview.dataSource = self
        
       fetchingapi()
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let actioncell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell" , for: indexPath) as! CollectionViewCell
        
        actioncell.Categories.text = cat[indexPath.row]
        return actioncell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentCountry = countryList[indexPath.row]
        
        fetchingapi()
    }
    
    

    func fetchingapi() {
        showIndicator()
         url = "https://newsapi.org/v2/top-headlines?country=\(currentCountry)&apiKey=dd89776864d94db8a9953606244cd60e"
       
        let urlstring = URL(string: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlstring!, completionHandler: handle(data:response:error:))
        
        task.resume()
        
    }
    func showIndicator()
    {
        indicator.startAnimating()
        indicator.isHidden = false
        tblview.isHidden = true
    }
    
    func stopIndicator()
    {
        indicator.stopAnimating()
        indicator.isHidden = true
        tblview.isHidden = false
    }
    
    func handle(data : Data? , response : URLResponse? , error : Error?){
        
     
      
        if error == nil{
            if data != nil {
                do{
                    let result = try JSONDecoder().decode(Happy.self, from: data!)
                  
               
                    self.happy = result
                    
                    DispatchQueue.main.sync {
                        self.stopIndicator()
                        
                        self.tblview.reloadData()
                        print("data received")
                    }
                    
                }catch{
                    print (error)
                }
            }else {
                print ("no data")
            }
            
        }else{
            print(error!)
        }
        
    }
    
    
    
    
     

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         if let _ = happy{
             return happy.articles.count
         }else{
             return 0
         }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tablecell" , for: indexPath) as! TableCell

        
        let obj = happy.articles[indexPath.row]
        cell.title?.text = obj.title
        
        if obj.urlToImage != nil {
            cell.img?.setImageFromUrl(urlString: obj.urlToImage!)
            
        }else {
            cell.img?.image = UIImage(named: "no-photo")
        }
        
        return cell

    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
         tableView.deselectRow(at: indexPath, animated: true)
         
         let obj = happy.articles[indexPath.row]
        let nextpage = self.storyboard?.instantiateViewController(withIdentifier: "newpage")as! MainViewController
         nextpage.currentobject = obj
        self.navigationController?.pushViewController(nextpage, animated: true)
        
       
    }
    
   
   

}


struct Happy : Codable {
    
    var status : String
    var totalResults : Int
    var articles : [Sad]
}

struct Sad : Codable {

    let source : source
    let author : String?
    let title : String?
    let description : String?
    let url : String?
    let urlToImage : String?
    let publishedAt : String?
    let content : String?

}

struct source : Codable {
     let id : String?
     let name : String

}

