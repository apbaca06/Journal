//
//  UpdateViewController.swift
//  Journal
//
//  Created by cindy on 2017/12/8.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import CoreData

class UpdateViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, ArticleCellDelegate {
    
    func manager(_ manager: ArticleListTableViewController, didGet article: NSManagedObject) {
        self.updatedArticle = article
    }
    

    
    var updatedArticle: NSManagedObject?

    
    
    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var articleText: UITextView!
    
    @IBOutlet weak var articleTitle: UITextView!
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var separator: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpUpdateButton()
        
        setLongPressGesture()
        
        closeButton.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showArticle()
    }
    
    func showArticle() {

        
        articleTitle.text = updatedArticle?.value(forKeyPath: "title") as? String
        
        articleText.text = updatedArticle?.value(forKeyPath: "text") as? String
        
        
        guard
            let imageData = updatedArticle?.value(forKeyPath: "image") as? Data
            
            else { return }

        articleImage.image = UIImage(data: imageData)
        
        articleImage.contentMode = .scaleAspectFill

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
    
    func setUpUpdateButton() {
        
        updateButton.clipsToBounds = true
        
        updateButton.layer.cornerRadius = 22
        
        updateButton.layer.shadowColor = UIColor(red: 247/255, green: 174/255, blue: 163/255, alpha: 1).cgColor
        
        updateButton.layer.shadowPath = UIBezierPath(rect: updateButton.bounds).cgPath
        
        updateButton.addTarget(self, action: #selector(updateArticle), for: .touchUpInside)
    }
    
    @objc func updateArticle() {
        
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
}
