//
//  File.swift
//  NewsApp
//
//  Created by deepak on 22/09/23.
//

import Foundation
import UIKit

extension  UIImageView
{
    func setImageFromUrl(urlString : String)
    {
        guard let url = URL (string: urlString) else {return}
        
        if self.image != nil
        {
            print("image already found")
            return
        }
        self.image = UIImage (named: "placeholder")
        
        let oldFileName : String  = urlString.components(separatedBy: "/").last!
        let fileName : String = urlString.components(separatedBy: "/").joined(separator: "--")
        
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let path = cacheDirectory.appendingPathComponent(fileName)
        
        let fileUrl = URL (string: path.absoluteString)
        
        if FileManager.default.fileExists(atPath: fileUrl!.path)
        {
            DispatchQueue.global(priority: .background).async {
                do {
                    let nsData : Data = try Data (contentsOf: path)
                    
                    let img : UIImage = UIImage (data: nsData) ?? UIImage()
                    
                    DispatchQueue.main.async {
                        self.image = img
                    }
                    
                }catch {
                    
                }
            }
        }else
        {
            DispatchQueue.global().async {
                
                let url : URL = URL (string: urlString)!
                do {
                    let nsData : Data = try Data(contentsOf: url)
                    let img : UIImage = UIImage (data: nsData)!
                    
                    do {
                        
                        try img.pngData()?.write(to: path)
                        DispatchQueue.main.async {
                             
                            self.image = img
                        }
                    }catch {
                        
                    }
                    
                    
                    
                }catch {
                    
                }
            }
            
        }
    }
}
