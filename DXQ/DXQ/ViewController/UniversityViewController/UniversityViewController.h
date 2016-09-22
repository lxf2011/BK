//
//  UniversityViewController.h
//  DXQ
//
//  Created by rason on 8/6/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "BaseViewControllerNormal.h"

@interface UniversityViewController : BaseViewControllerNormal<UICollectionViewDelegate, UICollectionViewDataSource >{
    int countUniversity;
//    NSArray *arrayCell;
    NSArray *arraySearchResult;
    NSArray *arrayOrg;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) UISearchBar *searchBar;

// 搜索学校
@property (nonatomic, copy) NSString *query;

@end
