//
//  ViewController.swift
//  TestForDocumentation
//
//  Created by Anton Rubenchik on 16.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ManualViewController: UIViewController {
    let textArray = ["  Самая легкая и простая схема, но тем не менее, потребует от вас желания поучаствовать в этом процессе лично.",
                     "  Собрать одну сторону кубика Рубика и верхний пояс вы должны сами, для этого не требуется никаких формул, нужно только желание и внимательность.\n \n  С учетом цветов центральных квадратов (Рис. 1), соберите «объемный» крест (Рис. 2), а затем полностью верхнюю грань так, чтобы цвета верхнего пояса совпали с цветами центральных квадратов (Рис. 3).",
                     "  Формула: (НЛН’Л’)(Н’Ф’НФ) \n Чтобы собрать второй пояс, нужно найти подходящий кубик в третьем поясе, чтобы подходили оба цвета (если нужно покрутите третий пояс), и переместите его по диагонали во второй пояс. Если кубик встал неправильно, повторите формулу еще два раза.",
                     "  Теперь нужно собрать крест на противоположной стороне кубика Рубика. Крест собирается без учета цветов третьего пояса",
                     "  Формула: Ф П В П' В' Ф' \n На вашем кубике Рубика сейчас одна из четырех комбинаций. Переход от одной комбинации к другой происходит единой формулой. Эту формулу вам нужно повторить 1-3 раза в зависимости от того какая у вас комбинация.",
                     "  В результате этого этапа мы получим крест согласованный с цветами пояса. \n Вращайте верхний пояс, пока 2 цвета креста не совпадут со средними квадратами верхнего пояса. \n Возможны только две комбинации: цвета совпали линией  или цвета совпали углом.",
                     "  Формула при совпадении линии:\nП В П' В П ВВ П'\n Перемещаем неправильно размещенные кубики креста расположенные друг против друга (два противоположных конца креста).\n После выполнения этой формулы концы креста не встанут на свои места, но комбинация изменится на «цвета совпали углом»",
                     "  Формула при совпадении угла:\n П В П' В П ВВ П' В\n Меняем местами неправильно размещенные кубики креста расположенные по диагонали относительно друг друга (два смежные кубика креста).\n После выполнения этой формулы крест будет собран и его боковые цвета будут совпадать с цветами верхнего пояса. Если результат не достигнут, то повторите эту формулу еще раз, предварительно правильно сориентировав кубик.",
                     "  Угловые кубики расставляются двумя формулами. После применения этих формул угловые кубики будут стоять на своих местах (в своих углах), но могут быть развернуты неправильно. На Рисунке черной точкой отмечен кубик, который размещен на своем месте (в своем углу), но развернут неправильно. Разворачиваются кубики уже на следующем этапе.",
                     "  Формула правого разворота:\n (П’Ф’Л’Ф)(ПФ’ЛФ) ",
                     "  Формула левого разворота:\n (Ф’Л’ФП’)(Ф’ЛФП)",
                     "  Разворот угловых кубиков выполняется простой формулой П’Н’ПН, выполненной множество раз.\n После начала выполнения формулы кубик Рубика «разрушится» и окончательно соберется, только после того, как все угловые кубики будут правильно развернуты. Другими словами, все угловые кубики разворачиваются за одну операцию, которая потребует от вас внимательности и выдержки.",
                     "  Обратите внимание:\n\n 1) Формулу (из 8 ходов) нужно выполнить 1 или 2 раза, до тех пор пока угловой кубик не перевернется в правильную позицию.\n\n  Когда угловой кубик повернется в правильную позицию кубик Рубика «разрушится», не переживайте, кубик Рубика соберется, только когда вы закончите со всеми углами.\n\n  Не меняйте положение (не переворачивайте) кубик Рубика в руках до конца этого этапа.",
                     "  Когда первый угловой кубик уже правильно расположен, поверните верхний слой, чтобы в верхний правый угол переместился другой угловой кубик, если следующий угловой кубик повернут правильно, сделайте еще один поворот верхнего слоя.\n\n  Опять выполните формулу из 8-ми ходов (1 или 2 раза) и следуйте всем вышеуказанным рекомендациям. Эти действия нужно повторять до тех пор пока все углы не будут развернуты правильно – пока кубик Рубика не соберется целиком.",
                     "  Ну вот и все, кубик Рубика собран."]
    let illustrationImageArray : [UIImage] = [UIImage(named: "illustartionStep2")!,
                                              UIImage(named: "illustartionStep2")!,
                                              UIImage(named: "illustartionStep2")!,
                                              UIImage(named: "illustartionStep2")!,
                                              UIImage(named: "illustartionStep4")!,
                                              UIImage(named: "illustartionStep5")!,
                                              UIImage(named: "illustartionStep6")!,
                                              UIImage(named: "illustartionStep7")!,
                                              UIImage(named: "illustartionStep2")!,
                                              UIImage(named: "illustartionStep9")!,
                                              UIImage(named: "illustartionStep10")!,
                                              UIImage(named: "illustartionStep2")!,
                                              UIImage(named: "illustartionStep12")!,
                                              UIImage(named: "illustartionStep13")!,
                                              UIImage(named: "illustartionStep13")!]
    let manualImageArray : [UIImage] = [UIImage(named: "manualStep0")!,
                                        UIImage(named: "manualStep1")!,
                                        UIImage(named: "manualStep2")!,
                                        UIImage(named: "manualStep3")!,
                                        UIImage(named: "manualStep4")!,
                                        UIImage(named: "manualStep5")!,
                                        UIImage(named: "manualStep6")!,
                                        UIImage(named: "manualStep7")!,
                                        UIImage(named: "manualStep8")!,
                                        UIImage(named: "manualStep9")!,
                                        UIImage(named: "manualStep10")!,
                                        UIImage(named: "manualStep11")!,
                                        UIImage(named: "manualStep12")!,
                                        UIImage(named: "manualStep12")!,
                                        UIImage(named: "manualStep0")!]
    var nextButton = UIButton()
    var prevButton = UIButton()
    var text = UITextView()
    var titleLabel = UILabel()
    var manualImage = UIImage()
    var manualImageView = UIImageView()
    var illustrationImage = UIImage()
    var illustrationImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLabelAndTextAndImage()
        createStartElement()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if step == 0 { prevButton.isHidden = true }
        printStep()
    }
    
    func printStep() {
        titleLabel.text = "Шаг \(step + 1) из \(textArray.count)"
        text.text = textArray[step]

        manualImage = manualImageArray[step]
        manualImageView.image = manualImage
        
        if step == 0 || step == 1 || step == 3 || step == 8 || step == 11 || step == 14{
           manualImageView.frame = CGRect(x: 20, y: 130, width: view.frame.width - 40, height: 256)
           illustrationImageView.isHidden = true
        }
        else {
            manualImageView.frame =  CGRect(x: 20, y: 220, width: view.frame.width - 40, height: 180)
            illustrationImageView.isHidden = false
        }
        illustrationImage = illustrationImageArray[step]
        illustrationImageView.image = illustrationImage
        
        
    }

    @objc func pressExit() {
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: false)
    }

    fileprivate func createStartElement() {
        // createStartElement
        
        // createTitleImage
        let titleImageView = UIImageView()
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        titleImageView.contentMode = .scaleAspectFit
        let titleImage = UIImage(named: "rubik_small")
        titleImageView.image = titleImage
        self.navigationItem.titleView = titleImageView
        
        // create
        let navBar = UITabBarItem()
        navBar.image = UIImage(named: "instructions")
        navBar.title = "Инструкция"
        self.tabBarItem = navBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .done, target: self, action: #selector(pressExit))
        
        // create Image
//        image = UIImage(named: "rubik_big")!
//        imageView.image = image
        manualImageView.frame = CGRect(x: 20, y: 220, width: view.frame.width - 40, height: 180)
        //manualImageView.backgroundColor = UIColor.blue
        // old value
        //imageView.frame = CGRect(x: view.frame.midX - 128, y: 130, width: 256, height: 256)
 
        manualImageView.contentMode = .scaleAspectFit
        view.addSubview(manualImageView)
        
        // createIllustartion
       
        illustrationImageView.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 115)
     //   illustrationImageView.backgroundColor = UIColor.yellow
        illustrationImageView.contentMode = .scaleAspectFit
        view.addSubview(illustrationImageView)
        
        
        //create Button
        nextButton.setTitle("Далее", for: .normal)

        nextButton.setTitleColor(UIColor.white, for: .normal)
        nextButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        nextButton.layer.cornerRadius = 15
        nextButton.backgroundColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        nextButton.frame = CGRect(x: view.frame.maxX - 130, y: 620, width: 100, height: 44)
        nextButton.layer.shadowOpacity = 0.6
        nextButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        nextButton.layer.shadowRadius = 2
        
        prevButton.setTitle("Назад", for: .normal)
        prevButton.setTitleColor(UIColor.white, for: .normal)
        prevButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        prevButton.layer.cornerRadius = 15
        prevButton.backgroundColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        prevButton.frame = CGRect(x: 30, y: 620, width: 100, height: 44)
        
        nextButton.addTarget(self, action: #selector(pressNext), for: .touchUpInside)
        prevButton.addTarget(self, action: #selector(pressPrev), for: .touchUpInside)
        view.addSubview(nextButton)
        prevButton.layer.shadowOpacity = 0.6
        prevButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        prevButton.layer.shadowRadius = 2
        view.addSubview(prevButton)
        
    }
    
    @objc func pressNext() {
        if step == textArray.count - 2 {
            nextButton.isHidden = true
        }
        else {
            if step == 0 {
                prevButton.isHidden = false
            }
        }
        step += 1
        printStep()
            
    }
    
    @objc func pressPrev() {
        if step == 1 {
            prevButton.isHidden = true
        }
        else {
            if step == textArray.count - 1 {
               nextButton.isHidden = false
            }
        }
        step -= 1
        printStep()
    }
    
    fileprivate func createLabelAndTextAndImage() {
        // add text stepX
        // text.text = "GGGGGGGghk dsfjghkjsdfglkjsldkfg dsflkgn sdlkfjgjlksdfjg skdfgjlskdfjglksdf glkdsf sdlkfgj"
        text.frame = CGRect(x: 10, y: 400, width: view.frame.maxX-20, height: 200)
        text.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(text)
        
        // add Title step X
        titleLabel.text = "Шаг \(step + 1) из \(textArray.count)"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: 50, y: 50, width: titleLabel.frame.width + 50, height: 70)
        
        
        titleLabel.lineBreakMode = .byWordWrapping // type new lines
        titleLabel.numberOfLines = 0 // If need dinamic label. Many lines. default 1
        titleLabel.adjustsFontSizeToFitWidth = true // уменьшить шрифт, чтобы влез в в отведенное поле
        titleLabel.sizeToFit()
        // Shadow
        titleLabel.shadowColor = UIColor.gray
        titleLabel.shadowOffset = CGSize(width: 2, height: 2) // отсутп тени
        
        
        view.addSubview(titleLabel)
    }
}



