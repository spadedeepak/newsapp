//
//  MainViewController.swift
//  NewsApp
//
//  Created by deepak on 15/09/23.
//

import UIKit



class MainViewController: UIViewController {

    var currentobject : Sad!
   
    

    @IBOutlet weak var scroll: UIScrollView!
    
    
    @IBOutlet weak var headline: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    
    @IBOutlet weak var picture: UIImageView!
    
    
    @IBOutlet weak var contents: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.

        guard let _ = currentobject
        else {return }
        
        headline.text  = currentobject.title
        if currentobject.author != nil {
            author.text =  "\(currentobject.author!) --- AUTHOR"
        }else{
            author.text = "AUTHOR NOT MENTIONED"
        }
        if currentobject.urlToImage != nil{
            picture.setImageFromUrl(urlString: currentobject.urlToImage!)
            
        }else {
            picture.image = UIImage(named: "no-photo")
        }
        
        contents.text = currentobject.content
       
        
    
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
}
