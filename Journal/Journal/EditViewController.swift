//
//  EditViewController.swift
//  Journal
//
//  Created by cindy on 2017/12/8.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class EditViewController: UIViewController ,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var articleTitle: UITextView!
    
    @IBOutlet weak var articleText: UITextView!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpSaveButton()
        
        setLongPressGesture()
        
        closeButton.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
       
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
        
        let newArticle = Article(
            
            title: articleTitle.text,
            
            text: articleText.text
        )
        
        
        articles.append(newArticle)
        
        print(articles)
        
        dismiss(animated: true, completion: nil)
    
    }
    
    @objc func closeViewController() {
        
        dismiss(animated: true, completion: nil)
        
    }


    

}
