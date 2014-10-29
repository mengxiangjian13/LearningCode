//
//  ViewController.swift
//  AutoSizedCollectionView
//
//  Created by Xiangjian Meng on 14/10/29.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var wordList = [String]();
    
    func allWords() -> [String]
    {
        var words = [String]();
        
        if let path = NSBundle.mainBundle().pathForResource("words", ofType: "txt")
        {
            let string = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil);
            if let string = string
            {
                words = string.componentsSeparatedByString("\n");
            }
        }
        return words;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        wordList = allWords();
        
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.estimatedItemSize = CGSizeMake(150, 50);
        }
        
    }
    
    // MARK:- datasource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordList.count;
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as WordCollectionViewCell;
        cell.wordLabel.text = wordList[indexPath.item];
        return cell;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

