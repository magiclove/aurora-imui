//
//  MyUser.swift
//  IMUIChat
//
//  Created by oshumini on 2017/4/9.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import Foundation
import UIKit

open class RCTUser: NSObject, IMUIUserProtocol {
  open var rUserId: String?
  open var rDisplayName: String?
  open var rAvatarFilePath: String?
  
  public override init() {
    super.init()
  }
  
  @objc convenience init(userDic: NSDictionary) {
    self.init()
    self.rUserId = userDic.object(forKey: "userId") as? String
    self.rDisplayName = userDic.object(forKey: "displayName") as? String
    self.rAvatarFilePath = userDic.object(forKey: "avatarPath") as? String
  }
  
  public func userId() -> String {
    if let rUserId = self.rUserId {
      return rUserId
    } else {
      return ""
    }
  }
  
  public func displayName() -> String {
    if let rDisplayName = self.rDisplayName {
      return rDisplayName
    } else {
      return ""
    }
  }
  
    public func Avatar() -> UIImage {
        
        
        let defaultImagePath = Bundle.imuiBundle().path(forResource: "default_header", ofType: "png")
        
        let defaulImage = UIImage(contentsOfFile: defaultImagePath!);
        
        
        if self.rAvatarFilePath == nil || (self.rAvatarFilePath?.isEmpty)!  {
            
            if defaulImage != nil {
                return defaulImage!
            }
            return UIImage()
        }
        
        if let path = self.rAvatarFilePath {
            
            //请求网络获取图片
            let url: URL! = URL(string: path)
            
            var image: UIImage? = nil
            
            if url != nil {
                
                do {
                    
                    let imageData = try Data(contentsOf: url)
                    
                    image = UIImage(data: imageData)
                    
                    if image != nil {
                        return image!
                    } else {
                        
                        if defaulImage != nil {
                            return defaulImage!
                        }
                        return UIImage()
                        
                    }
                    
                } catch {
                    
                    if defaulImage != nil {
                        return defaulImage!
                    }
                    return UIImage()
                }
                
                
            } else {
                if defaulImage != nil {
                    return defaulImage!
                }
                return UIImage()
            }
            
            
        }
        
        
        let image =  UIImage(named: "default_header")
        if image != nil {
            return image!
        }
        
        return UIImage()
    }
    
    
}
