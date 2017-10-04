//
//  addItemVC.swift
//  theStandard
//
//  Created by RYAN DEATHRIDGE on 4/10/17.
//  Copyright © 2017 RYAN DEATHRIDGE. All rights reserved.
//

import UIKit
import CoreData

class addItemVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var spreadField: UITextField!
    @IBOutlet weak var thumbImg: UIImageView!
    
    
    var itemToEdit: Entry?
    var imagePicker: UIImagePickerController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        thumbImg.image = #imageLiteral(resourceName: "camera")

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if itemToEdit != nil {
            loadItemData()
        }
        
    }


    
    
    
    
    
    
    
    
    @IBAction func deleteBtnPressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        let todaysDate = Date()
      
        var item: Entry!
        let picture = Image(context: context)
        picture.image = thumbImg.image
        
        
        
        if itemToEdit == nil {
            item = Entry(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        
        if let spread = spreadField.text {
          
            item.spread = (spread as NSString).floatValue
            item.created = (todaysDate as NSDate)
           
            
        }
        ad.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            spreadField.text = "\(item.spread)"
            thumbImg.image = item.toImage?.image as? UIImage
            
        }
        
        
        
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImg.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
