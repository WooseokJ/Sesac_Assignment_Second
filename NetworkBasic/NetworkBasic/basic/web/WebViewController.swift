//
//  WebViewController.swift
//  NetworkBasic
//
//  Created by useok on 2022/07/28.
//

import UIKit
import WebKit // webview가 uikit에없어서
class WebViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
  
    
    var destinationURL:String = "http://www.apple.com" // App transport security settings   , http로는 안뜨게 애플에서 설정함.
    //http로 접속되는법: info -> App Transport Security Setting -> Allow Arbitrary Load ->YES
    override func viewDidLoad() {
        super.viewDidLoad()
        openWebPage(url:destinationURL)
        searchBar.delegate = self

    }
    //MARK: 뒤로가기
    @IBAction func goBackButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoBack{
            webView.goBack()
        }
    }
    //MARK: 새로고침
    @IBAction func reloadButtonClicked(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    //MARK: 앞으로가기
    @IBAction func goForwardButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    //MARK: 웹사이트열기
    func openWebPage(url:String){
        guard let url = URL(string: url) else{ //우선 유효한 URL인지 확인
            print("Invalid URL") //유효하지않은 URL
            return
        }
        let request = URLRequest(url:url) //url통해 요청할게
        webView.load(request)
    }
}
//MARK: 서치바 관련 이벤크
extension WebViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(url: searchBar.text!)
    }
}
