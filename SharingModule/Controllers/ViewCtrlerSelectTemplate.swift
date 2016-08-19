//
//  ViewCtrlerSelectTemplate.swift
//  SharingModule
//
//  Created by User on 7/16/15.
//  Copyright (c) 2015 Steven. All rights reserved.
//

import UIKit

class ViewCtrlerSelectTemplate: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var m_arrayTblData = [ModelHTML5Template]()                // array for collectionview data
    
    // MARK: - controller params
    @IBOutlet var m_webView: UIWebView!                         // to display HTML5 template
    @IBOutlet var m_webView1: UIWebView!
    
    @IBOutlet var m_collectionView: UICollectionView!
    
    // MARK: - overide functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = NSURL(string: "http://baidu.com") //zanadu.cn
        let requestObj = NSURLRequest(URL: url!)
       
        if GlobData.getInstance().g_isAutherUser == true {
            m_collectionView.hidden = false;
            //m_webView.frame = CGRectMake(0, 68, 320, 309)
            m_webView1.hidden = true
            m_webView.hidden = false
             m_webView.loadRequest(requestObj)
        } else {
            m_collectionView.hidden = true;
            //m_webView.frame = CGRectMake(0, 68, 320, 434)
            m_webView1.hidden = false
            m_webView.hidden = true
            m_webView1.loadRequest(requestObj)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - background functions
    
    // to share template
    func shareTemplete() {
        let message:WXMediaMessage = WXMediaMessage.new()
        message.setThumbImage(UIImage(named: "sharingScreen.png"));
        
        let ext:WXImageObject = WXImageObject.new();
        let filePath:NSString = NSBundle.mainBundle().pathForResource("sharingScreen", ofType: "png")!      // Sharing image
        ext.imageData = UIImagePNGRepresentation(UIImage(named: "sharingScreen.png"))
        
        let extWeb:WXWebpageObject = WXWebpageObject.new()
        extWeb.webpageUrl = "https://itunes.apple.com/us/app/holy-bridal/id983950795?mt=8"                  // to move this url when tapping on wechat app
        
        message.mediaObject = ext
        message.mediaObject = extWeb
        
        let req:SendMessageToWXReq = SendMessageToWXReq.new()
        req.bText = false
        req.message = message
        if GlobData.getInstance().g_isSharingToMoment {
            req.scene = 1;                                                                                  // to share on moment
        } else {
            req.scene = 0;                                                                                  // to share to somebody
        }
        
        WXApi.sendReq(req)
    }

    // MARK: - button events
    
    @IBAction func onBtnCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onBtnPublish(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
        self.shareTemplete()
    }
    
    // MARK: - collectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 5;
        //return m_arrayTblData.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let alert = UIAlertController(title: "Alert", message: (NSString(format: "This is %dth row", indexPath.row)) as String, preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancelAction)
        presentViewController(alert, animated: true, completion: nil)
    }
}
