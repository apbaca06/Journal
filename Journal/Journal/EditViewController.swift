//
//  EditViewController.swift
//  Journal
//
//  Created by cindy on 2017/12/8.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController ,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var articleTitle: UITextView!
    
    @IBOutlet weak var articleText: UITextView!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    let gradientLayer = CAGradientLayer()
    
    private let gradientView = UIView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
        
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpSaveButton()
        
        setLongPressGesture()
        
        setUpGradientColor()

        
        closeButton.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        
        articleImage.image?.withRenderingMode(.alwaysTemplate)
        
        articleImage.tintColor = .white
    
        
    }
    
    func setLongPressGesture() {
        
        let longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(longPress(press:))
        )
        
        longPressGesture.minimumPressDuration = 1.0
        
        articleImage.addGestureRecognizer(longPressGesture)
        
        articleImage.isUserInteractionEnabled = true
    }
    
    @objc func longPress(press:UILongPressGestureRecognizer){
        
        if press.state == .began {
        
            changePhoto()
            
        }
    }
    
    func changePhoto() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let controller = UIImagePickerController()
            
            controller.delegate = self
            
            controller.sourceType = .photoLibrary
            
            self.present(controller, animated: true, completion: nil)
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        guard
            let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        else { return }
        
    
        articleImage.image = selectedImage
        articleImage.contentMode = .scaleAspectFit
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func setUpSaveButton() {
        
        saveButton.clipsToBounds = true
        
        saveButton.layer.cornerRadius = 22
        
        saveButton.layer.shadowColor = UIColor(red: 247/255, green: 174/255, blue: 163/255, alpha: 1).cgColor
        
        saveButton.layer.shadowPath = UIBezierPath(rect: saveButton.bounds).cgPath
        
        saveButton.addTarget(self, action: #selector(saveArticle), for: .touchUpInside)
    }
    
    @objc func saveArticle() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Article",
                                                in: managedContext)!
        
        let article = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        article.setValue(articleTitle.text, forKeyPath: "title")
        
        article.setValue(articleText.text, forKeyPath: "text")
        
        let date = Date()
        
        article.setValue(date.format(), forKeyPath: "timestamp")
        
        guard
            let image = articleImage.image,
            let imgData = UIImageJPEGRepresentation(image, 1)
        
        else { return }
        
        article.setValue(imgData, forKey: "image")
        
        do {
            try managedContext.save()
            
            print(article)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        
        dismiss(animated: true, completion: nil)
    
    }
    
    @objc func closeViewController() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func setUpGradientColor() {

//        gradientLayer.colors = [
//            UIColor(red: 67.0 / 255.0, green: 87.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0).cgColor,
//            UIColor(red: 26.0 / 255.0, green: 34.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0).cgColor
//        ]
//
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//
//        gradientView.layer.insertSublayer(
//            gradientLayer,
//            at: 0
//        )
//
//        gradientView.frame = articleImage.bounds
//
//        articleImage.addSubview(gradientView)
    }


    

}
