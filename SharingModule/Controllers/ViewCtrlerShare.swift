//
//  ViewCtrlerShare.swift
//  SharingModule
//
//  Created by User on 7/16/15.
//  Copyright (c) 2015 Steven. All rights reserved.
//

import UIKit

class ViewCtrlerShare: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, WXApiDelegate {
    
    var m_selectedCollectionIndex:NSInteger = -1
    
    // MARK: - controller params
    
    @IBOutlet var m_btnBack: UIButton!
    @IBOutlet var m_imageViewSharedStatus: UIImageView!     // to display sharing result:  green icon - when success
    @IBOutlet var m_lblSharedStatus: UILabel!               // to display sharing result:  green icon - when success
    @IBOutlet var m_collectionView: UICollectionView!
    @IBOutlet var m_viewBottom: UIView!                     // bottom view that has sharing button
    
    // MARK: - overide functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if GlobData.getInstance().g_isAutherUser {
            m_viewBottom.hidden = false;
            m_btnBack.hidden = true
        } else {
            m_viewBottom.hidden = true;
            m_btnBack.hidden = false
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        m_selectedCollectionIndex = -1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - backend functions
    
    func shareResult(result: Bool) {
        
        let label:UIView = self.view .viewWithTag(101) as UIView!
        let imageview:UIView = self.view.viewWithTag(102) as UIView!
        
        if result {
            label.hidden = false
            imageview.hidden = false
        } else {
            label.hidden = true;
            imageview.hidden = true
        }
    }
    
    //MARK: - control events
    
    @IBAction func onBtnShare(sender: AnyObject) {
        let alert:UIAlertView = UIAlertView(title: nil, message: "To return to the home screen!" as String, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    //MARK: - collection view
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 2;
        //return m_arrayTblData.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell:UICollectionViewCell
        if indexPath.row == 0 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell_0", forIndexPath: indexPath) as! UICollectionViewCell
        } else {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell_1", forIndexPath: indexPath) as! UICollectionViewCell
        }
        
        let image:UIView = cell.viewWithTag(3)!
        if indexPath.row == m_selectedCollectionIndex {
            image.hidden = false
        }
        else {
            image.hidden = true
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        //let indexPath:NSIndexPath = NSIndexPath.new().indexPathByAddingIndex(indexPath.row)
        
        m_selectedCollectionIndex = indexPath.row
        if indexPath.row == 0   {
            GlobData.getInstance().g_isSharingToMoment = false;
        } else if indexPath.row == 1 {
            GlobData.getInstance().g_isSharingToMoment = true
        }
        
        m_collectionView .reloadData()

        self.performSegueWithIdentifier("sequeToSelectTemplate", sender: nil)
    }
    
    // MARK: - WXApi delegate
    
    //  response to check if sharing is success or not
    func onResp(resp: BaseResp!) {
        
        var strTitle = resp.errCode != 0 ? "Error" : "Success"
        var strError:NSString = "There was an issue sharing your message. Please try again."
        var strSuccess:NSString = "Your message was successfully shared!"
        var strMessage:NSString = resp.errCode != 0 ? strError : strSuccess
        
        let alert:UIAlertView = UIAlertView(title: strTitle, message: strMessage as String, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        
        var isSuccess = resp.errCode != 0 ? false : true
        self.shareResult(isSuccess)
        
    }
    
    

}
