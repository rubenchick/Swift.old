//
//  ViewController.swift
//  Lesson 17. UIScrollView
//
//  Created by Anton Rubenchik on 24.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//
//1+ Повторите то, что есть в видео.
//2+ Создать форму заполнения анкеты в свободной форме, анкета должна быть по высоте больше чем экран
//3+ Поместить форму из п2 на UIScrollVIew
//4. Если клавиатуры выезжает (при заполнение TextField допустим) увеличить ScrollVIew на размер клавиатуры
//
//Дополнительно:
//1+ Добавить возможность загрузки фото с камеры или фотопленки
//2+ С помощью ScrollView реализовать листание фото

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var firstLabel              = UILabel()
    var secondLabel             = UILabel()
    var myScrollView            = UIScrollView()
    var macImageView            = UIImageView()
    var titleLabel              = UILabel()
    var mainScrollView          = UIScrollView()
    var footScrollView          = UIScrollView()
    var takePhotoButton         = UIButton()
    var chooseFromLibraryButton = UIButton()
    var nickImageView           = UIImageView()
    var topView                 = UIView()
    var middleView              = UIView()
    var nameTextField           = UITextField()
    var phoneTextField          = UITextField()
    var emailTextField          = UITextField()
    var cityTextField           = UITextField()
    var adressTextField         = UITextField()
    var ageTextField            = UITextField()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createStartElements()
        UIApplication.shared.statusBarView?.backgroundColor = .white

        //createThreeImageAndScroll()
        //createScrollView()
        //testTwoLablels()
        
    }

    //MARK: - Create Elements
    
    func createStartElements() {
        view.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
        
        // create ScrollView
        mainScrollView = UIScrollView(frame: CGRect(x: 0, y: 54, width: Int(view.frame.width), height: Int(view.frame.height-54)))
        mainScrollView.contentSize = mainScrollView.frame.size
        mainScrollView.contentSize.height = 800
        mainScrollView.delegate = self
        
        // common Function
        createTitleLabel()
        createTopView()
        createMiddleView()
        createFootView()
        
        // Add Views on Scroll
        mainScrollView.addSubview(topView)
        mainScrollView.addSubview(middleView)
        mainScrollView.addSubview(footScrollView)
        
        //Add all elements on View
        
        view.addSubview(titleLabel)
        view.addSubview(mainScrollView)
        
    }
    func newImageView(image: UIImage,position: CGRect) -> UIImageView {
        let newImageView = UIImageView(image: image)
        newImageView.frame = position
        newImageView.contentMode = .scaleAspectFit //вписываем в отведенный размер
        return newImageView
    }
    
    fileprivate func createTitleLabel() {
        // create Top
        titleLabel.text = "Edit Info"
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: 0, y: 10, width: view.frame.width, height: 44)
        titleLabel.backgroundColor = .white
        titleLabel.textAlignment = .center
        titleLabel.baselineAdjustment = .alignCenters
    }
    
    func createLabel(text: String, position: CGRect)->UILabel {
        let newLabel = UILabel()
        newLabel.text = text
        newLabel.font = UIFont.boldSystemFont(ofSize: 20)
        newLabel.sizeToFit()
        newLabel.frame = position
        newLabel.baselineAdjustment = .alignCenters
        return newLabel
    }
    
    func newTextField(defaultText:String, position: CGRect, tag: Int)-> UITextField{
        let newTextField = UITextField()
        newTextField .frame = position
        newTextField .borderStyle = .none
        newTextField .textColor = UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 1)
        newTextField .tag = tag
        newTextField .text = defaultText
        newTextField .font = UIFont.boldSystemFont(ofSize: 20)
        newTextField .delegate = self
        return newTextField
    }
    
    fileprivate func createTopView() {
        // create TopView's elements
        // add Photo
        let nickImage = UIImage(named: "normal")
        nickImageView = UIImageView(image: nickImage)
        nickImageView.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        nickImageView.contentMode = .scaleAspectFill // не растягивать
        nickImageView.clipsToBounds = true // вписывать в рамку
        nickImageView.layer.borderColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1).cgColor
        nickImageView.layer.cornerRadius = 50
        nickImageView.layer.borderWidth = 4
        
        // add Buttons
        takePhotoButton = createButton(text: "Take Photo", position: CGRect(x: 144, y: 10, width: 200, height: 44))
        chooseFromLibraryButton = createButton(text: "Choose From Library", position: CGRect(x: 144, y: 64, width: 200, height: 44))
        chooseFromLibraryButton.addTarget(self, action: #selector(pressChooseButton), for: .touchUpInside)
        
        // Add TopViews
        topView.backgroundColor = .white
        topView.frame = CGRect(x: 0, y: 10, width: view.frame.width, height: 120)
        
        // Add Elements on topView
        topView.addSubview(nickImageView)
        topView.addSubview(takePhotoButton)
        topView.addSubview(chooseFromLibraryButton)
        
    }
    @objc func pressChooseButton() {
        let nickImage = UIImagePickerController()
        nickImage.delegate = self
        nickImage.sourceType = UIImagePickerControllerSourceType.photoLibrary
        nickImage.allowsEditing = false
        self.present(nickImage, animated: true)
        {
            //After it is complete
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if  let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            nickImageView.image = image
            footScrollView.isHidden = false
            
        }
        else {
            //error
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func createMiddleView() {
        // create middle View
        //create label
        let nameLabel = createLabel(text: "Name", position: CGRect(x: 10, y: 0, width: 80, height: 44))
        let phoneLabel = createLabel(text: "Phone", position: CGRect(x: 10, y: 45, width: 80, height: 44))
        let emailLabel = createLabel(text: "Email", position: CGRect(x: 10, y: 89, width: 80, height: 44))
        let cityLabel = createLabel(text: "City", position: CGRect(x: 10, y: 133, width: 80, height: 44))
        let adressLabel = createLabel(text: "Adress", position: CGRect(x: 10, y: 177, width: 80, height: 44))
        let ageLabel = createLabel(text: "Age", position: CGRect(x: 10, y: 221, width: 80, height: 44))
        //createTextField
        nameTextField = newTextField(defaultText: "Natali", position: CGRect(x: 110, y: 6, width: 300, height: 31), tag: 0)
        phoneTextField = newTextField(defaultText: "+7 937 265-00-12", position: CGRect(x: 110, y: 50, width: 300, height: 31), tag: 1)
        emailTextField = newTextField(defaultText: "portman@gmail.com", position: CGRect(x: 110, y: 94, width: 300, height: 31), tag: 2)
        cityTextField = newTextField(defaultText: "San Fransico", position: CGRect(x: 110, y: 138, width: 300, height: 31), tag: 3)
        adressTextField = newTextField(defaultText: "Lincoln str. 12", position: CGRect(x: 110, y: 182, width: 300, height: 31), tag: 4)
        ageTextField = newTextField(defaultText: "42", position: CGRect(x: 110, y: 226, width: 300, height: 31), tag: 5)
        
        
        
        // Add Views
        middleView.backgroundColor = .white
        middleView.frame = CGRect(x: 0, y: 160, width: view.frame.width, height: 264)
        
        // Add Elements on middleView
        middleView.addSubview(nameLabel)
        middleView.addSubview(phoneLabel)
        middleView.addSubview(emailLabel)
        middleView.addSubview(cityLabel)
        middleView.addSubview(adressLabel)
        middleView.addSubview(ageLabel)
        middleView.addSubview(nameTextField)
        middleView.addSubview(phoneTextField)
        middleView.addSubview(emailTextField)
        middleView.addSubview(cityTextField)
        middleView.addSubview(adressTextField)
        middleView.addSubview(ageTextField)
    }
    
    fileprivate func createFootView() {
        //create FootView
        footScrollView = UIScrollView(frame: CGRect(x: Int(mainScrollView.frame.maxX / 3), y: 430, width: Int(mainScrollView.frame.maxX / 3), height: Int(mainScrollView.frame.maxY - 430 - 60)))
        footScrollView.contentSize = footScrollView.frame.size
        var imageViewRect = footScrollView.bounds
        footScrollView.contentSize.width = footScrollView.frame.width * 4 // ширину зоны скролла увеличили на 4 фото
        footScrollView.isPagingEnabled = true
        footScrollView.isHidden = true
        footScrollView.delegate = self
        
        // create new Image
        let firstImage = UIImage(named: "portman4")
        let secondImage = UIImage(named: "portman2")
        let thirdImage = UIImage(named: "portman3")
        let forthImage = UIImage(named: "portman1")
        
        let firstImageView = newImageView(image: firstImage!, position: imageViewRect)
        
        imageViewRect.origin.x += imageViewRect.size.width
        let secondImageView = newImageView(image: secondImage!, position: imageViewRect)
        
        imageViewRect.origin.x += imageViewRect.size.width
        let thirdImageView = newImageView(image: thirdImage!, position: imageViewRect)
        
        imageViewRect.origin.x += imageViewRect.size.width
        let forthImageView = newImageView(image: forthImage!, position: imageViewRect)
        
        footScrollView.addSubview(firstImageView)
        footScrollView.addSubview(secondImageView)
        footScrollView.addSubview(thirdImageView)
        footScrollView.addSubview(forthImageView)
    }
    
    func createButton(text: String, position:CGRect) -> UIButton{
        let newButton = UIButton()
        newButton.backgroundColor = .white
        newButton.frame = position
        newButton.setTitle(text, for: .normal)
        newButton.setTitleColor(UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 1), for: .normal)
        newButton.setTitleColor(UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 0.2), for: .highlighted)
        newButton.layer.borderWidth = 2
        newButton.layer.cornerRadius = 5
        newButton.layer.borderColor = UIColor.gray.cgColor
  
        return newButton
    }
//    func newImageView(image: UIImage, position: CGRect) -> UIImageView{
//        let newImageView = UIImageView(frame: position)
//        newImageView.contentMode = .scaleAspectFit // не растягивает, а вписывает
//        newImageView.image = image
//        return newImageView
//
//    }
    
    //MARK: - delegate
    // вызывается во время начала прокрутки прокрутки
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Start scroll")
        print(scrollView.contentOffset.y)
        print(mainScrollView.frame.origin.y)
//        scrollView.alpha = 0.5
        
    }
    // вызывается после прокрутки
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("Finish scroll")
//        scrollView.alpha = 1
    }
    // После перетаскивания, прокрутка может и не быть начата
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        print("Reserv scroll")
//        scrollView.alpha = 1
    }
    
//    fileprivate func testTwoLablels() {
//        firstLabel = UILabel(frame: CGRect(x: 20, y: 50, width: 200, height: 44))
//        firstLabel.text = "First sentense"
//
//        secondLabel = UILabel(frame: CGRect(x: 400, y: 550, width: 200, height: 44))
//        secondLabel.text = "Second sentense"
//        //        myScrollView = UIScrollView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: view.bounds.width, height: view.bounds.height+200)))
////        myScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height+200))
//
//        firstLabel = UILabel(frame: CGRect(x: 400, y: 50, width: 200, height: 44))
//        firstLabel.text = "First sentense"
//        myScrollView.frame = self.view.bounds
//        myScrollView.contentSize = CGSize(width: 500, height: 800)
//        myScrollView.addSubview(firstLabel)
//        view.addSubview(myScrollView)
//
//        myScrollView.addSubview(secondLabel)
//        view.addSubview(myScrollView)
//    }
    
//    fileprivate func createScrollView() {
//        // create ScrollView
//        let macImage = UIImage(named: "mac")
//        macImageView = UIImageView(image: macImage)
//        myScrollView = UIScrollView(frame: self.view.bounds)
//        myScrollView.addSubview(macImageView)
//        myScrollView.contentSize = macImageView.bounds.size
//        myScrollView.indicatorStyle = .black
//        myScrollView.delegate = self
//        view.addSubview(myScrollView)
//    }
    
//    fileprivate func createThreeImageAndScroll() {
//        let iPhoneImage = UIImage(named: "iphone")
//        let iPadImage = UIImage(named: "ipad")
//        let macImage = UIImage(named: "mac")
//
//        let scrollViewRect = self.view.bounds
//        // createScroll
//        myScrollView = UIScrollView(frame: scrollViewRect)
//        myScrollView.isPagingEnabled = true
//        myScrollView.contentSize = CGSize(width: scrollViewRect.width * 3, height: scrollViewRect.height)
//        view.addSubview(myScrollView)
//        var imageViewRect = self.view.bounds
//        let iPhoneImageView = self.newImageView(image: iPhoneImage!, position: imageViewRect)
//        myScrollView.addSubview(iPhoneImageView)
//
//        // nextPage
//        imageViewRect.origin.x += imageViewRect.size.width
//        let iPadImageView = self.newImageView(image: iPadImage!, position: imageViewRect)
//        myScrollView.addSubview(iPadImageView)
//
//        // nextPage
//        imageViewRect.origin.x += imageViewRect.size.width
//        let macImageView = self.newImageView(image: macImage!, position: imageViewRect)
//        myScrollView.addSubview(macImageView)
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 { phoneTextField.becomeFirstResponder() }
            switch textField.tag {
            case 0: phoneTextField.becomeFirstResponder()
            case 1: emailTextField.becomeFirstResponder()
            case 2: cityTextField.becomeFirstResponder()
            case 3: adressTextField.becomeFirstResponder()
            case 4: ageTextField.becomeFirstResponder()
            case 5: do {
                mainScrollView.contentOffset.y -= 150
                textField.resignFirstResponder()
                }
            default:
                break
            }
        if textField.tag > 1 && textField.tag < 5 { mainScrollView.contentOffset.y += 50 }
            return true
        }
}


extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

