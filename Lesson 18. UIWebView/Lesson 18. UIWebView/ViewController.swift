//
//  ViewController.swift
//  Lesson 18. UIWebView
//
//  Created by Anton Rubenchik on 05.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    //MARK: - Property
    @IBOutlet weak var mainWebView: UIWebView!
    @IBOutlet weak var goAhaedItem: UIBarButtonItem!
    @IBOutlet weak var goBackItem: UIBarButtonItem!
    
    @IBOutlet weak var mainActivityIndcator: UIActivityIndicatorView!
    let application = UIApplication.shared // не разобрался
   
    override func viewDidLoad() {
        super.viewDidLoad()
        mainWebView.delegate = self
        createStartItems()
    }
    // MARK: - Delegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        application.isNetworkActivityIndicatorVisible = true
        isWorkIndicator(isAnimated: true, indicator: mainActivityIndcator)

        goAhaedItem.isEnabled = false
        goBackItem.isEnabled = false
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        application.isNetworkActivityIndicatorVisible = false
        isWorkIndicator(isAnimated: false, indicator: mainActivityIndcator)
        if mainWebView.canGoForward {
            goAhaedItem.isEnabled = true
        }
        if mainWebView.canGoBack {
            goBackItem.isEnabled = true
        }
    }

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("shouldStartLoadWith",request)
        return true
    }

    // MARK: - Action

    @IBAction func goBackAction(_ sender: Any) {
        if mainWebView.canGoBack {
            mainWebView.goBack()
        }
    }

    @IBAction func goAheadAction(_ sender: Any) {
        if mainWebView.canGoForward {
            mainWebView.goForward()
        }
    }


    @IBAction func refreshAction(_ sender: Any) {
        mainWebView.reload()
    }

    fileprivate func createStartItems() {
        // load website
        if let mainURL = URL(string: "https://www.google.ru") {
            let request = URLRequest(url: mainURL)
            mainWebView.loadRequest(request)
            print("port - ", mainURL.port,"scheme - ", mainURL.scheme,"absoluteURL - ", mainURL.absoluteURL,"user - ", mainURL.user)
        }
        // load .pdf

//        mainWebView.scalesPageToFit = true // поместить на экран
//        if let urlPdf = Bundle.main.url(forResource: "river", withExtension: "pdf") {
//            let request = URLRequest(url: urlPdf)
//            mainWebView.loadRequest(request)
//        }


    }
    func isWorkIndicator(isAnimated: Bool, indicator: UIActivityIndicatorView){
        if isAnimated {
            indicator.startAnimating()
            indicator.isHidden = false
        } else {
            indicator.stopAnimating()
            indicator.isHidden = true
        }


    }
    
    
}

