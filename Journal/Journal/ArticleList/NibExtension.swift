//
//  NibExtension.swift
//  Journal
//
//  Created by cindy on 2017/12/8.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

public extension UINib {
    
    /**
     A convenience method loads a local xib file.
     
     - Author: Roy Hsu
     
     - Parameter nibName: The name of xib file.
     
     - Parameter bundle: The bundle xib file located. Default is nil.
     
     - Returns: The loaded instance.
     */
    
    public class func load(nibName name: String, bundle: Bundle? = nil) -> Any? {
        
        return UINib(nibName: name, bundle: bundle)
            .instantiate(withOwner: nil, options: nil)
            .first
        
    }
    
}

public extension UIView {
    
    /**
     A convenience method loads a view from local xib file.
     
     - Author: Roy Hsu
     
     - Parameter nibName: The name of xib file.
     
     - Parameter bundle: The bundle xib file located. Default is nil.
     
     - Returns: The view instance.
     */
    
    public class func load(nibName name: String, bundle: Bundle? = nil) -> UIView? {
        
        return UINib.load(nibName: name, bundle: bundle) as? UIView
        
    }
    
}

extension UIViewController {
    
    static func load<VC: UIViewController>(_ type: VC.Type, from storyboard: UIStoryboard) -> VC {
        
        let identifier = String(describing: type)
        
        let controller = storyboard
            .instantiateViewController(withIdentifier: identifier)
        
        // swiftlint:disable force_cast
        return controller as! VC
        // swiftlint:enable force_cast
        
    }
    
}

extension UIStoryboard {
    
    // MARK: Property
    
    static let edit = UIStoryboard(name: "Edit", bundle: nil)
    
    static let update = UIStoryboard(name: "Update", bundle: nil)
    
}

