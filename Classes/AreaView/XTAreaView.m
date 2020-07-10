//
//  XTAreaView.m
//  Sitech
//
//  Created by 张宇 on 2018/11/14.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

#import "XTAreaView.h"
#import "XTAreaModel.h"
#import "XTFontAndColorMacros.h"
#import "XTUtilsMacros.h"

@implementation XTAreaView
{
    UIView *blackBaseView;
    NSString *_provinceId;
    NSString *_cityId;
    NSString *_areaId;
    NSString *_streetId;
    UILabel *_provinceLab;
    UILabel *_cityLab;
    UILabel *_areaLab;
    UILabel *_streetLab;
    UIView *_lineView;
    NSIndexPath *_provinceIndex;
    NSIndexPath *_cityIndex;
    NSIndexPath *_areaIndex;
    NSIndexPath *_streetIndex;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame selectViewAccuracy:AreaSelectViewTypeCity];;
}

- (instancetype)initWithFrame:(CGRect)frame selectViewAccuracy:(AreaSelectViewType)selectViewAccuracy{
    if (self = [super initWithFrame:frame]) {
        self.autoresizesSubviews = NO;
        _provinceArray = [[NSMutableArray alloc]init];
        _cityArray = [[NSMutableArray alloc]init];
        _areaArray = [[NSMutableArray alloc]init];
        _streetArray = [[NSMutableArray alloc]init];
        _selectViewAccuracy = selectViewAccuracy;
        self.backgroundColor = KClearColor;
        [self creatBaseUI];
    }
    return self;
}


- (void)creatBaseUI
{
    blackBaseView = [[UIView alloc]initWithFrame:self.bounds];
    blackBaseView.backgroundColor = [UIColor blackColor];
    blackBaseView.alpha = 0;
    [self addSubview:blackBaseView];
    
    _areaWhiteBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight - kRealValue(360), KScreenWidth, kRealValue(360))];
    _areaWhiteBaseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_areaWhiteBaseView];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_areaWhiteBaseView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(kViewCornerRadius, kViewCornerRadius)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = _areaWhiteBaseView.bounds;
    shapeLayer.path = path.CGPath;
    _areaWhiteBaseView.layer.mask = shapeLayer;
    
    UIView *topBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, kRealValue(87))];
    topBgView.backgroundColor = KWhiteColor;
    [_areaWhiteBaseView addSubview:topBgView];
    
    UILabel *chooseTitle = [[UILabel alloc]initWithFrame:CGRectMake(kLargeMargin, kRealValue(15), kRealValue(200), kRealValue(25))];
    chooseTitle.font = Font_Large_Title;
    chooseTitle.textColor = kSystemTextColor(1);
    chooseTitle.text = @"选择所在地区";
    [topBgView addSubview:chooseTitle];
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - kRealValue(46), 0, kRealValue(46), kRealValue(50))];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(areaCloseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topBgView addSubview:closeBtn];

    CGFloat provinceW = [self getTextHeight:@"请选择"];
    _provinceLab = [[UILabel alloc]init];
    _provinceLab.frame = CGRectMake(kLargeMargin, kRealValue(55), provinceW, kRealValue(20));
    _provinceLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
    _provinceLab.font = Font_Regular_Text;
    _provinceLab.userInteractionEnabled = NO;
    _provinceLab.textAlignment = NSTextAlignmentLeft;
    _provinceLab.text = @"请选择";
    [topBgView addSubview:_provinceLab];
    
    UITapGestureRecognizer *provinceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(provinceTapAction:)];
    [_provinceLab addGestureRecognizer:provinceTap];
    
    CGFloat cityLabX = _provinceLab.frame.origin.x + _provinceLab.frame.size.width + kRealValue(30);
    _cityLab = [[UILabel alloc]init];
    _cityLab.frame = CGRectMake(cityLabX, kRealValue(55), 0, kRealValue(20));
    _cityLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
    _cityLab.font = Font_Regular_Text;
    _cityLab.userInteractionEnabled = NO;
    _cityLab.textAlignment = NSTextAlignmentLeft;
    [topBgView addSubview:_cityLab];
    UITapGestureRecognizer *cityTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityTapAction:)];
    [_cityLab addGestureRecognizer:cityTap];
    
   CGFloat areaLabX = cityLabX + _cityLab.frame.size.width + kRealValue(30);
    _areaLab = [[UILabel alloc]init];
    _areaLab.frame = CGRectMake(areaLabX, kRealValue(55), 0, kRealValue(20));
    _areaLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
    _areaLab.font = Font_Regular_Text;
    _areaLab.userInteractionEnabled = NO;
    _areaLab.textAlignment = NSTextAlignmentLeft;
    _areaLab.text = @"请选择";
    [topBgView addSubview:_areaLab];
    
    UITapGestureRecognizer *areaTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(areaTapAction:)];
    [_areaLab addGestureRecognizer:areaTap];
    
    CGFloat streetLabX = areaLabX + _areaLab.frame.size.width + kRealValue(30);
    _streetLab = [[UILabel alloc]init];
    _streetLab.frame = CGRectMake(streetLabX, kRealValue(55), 0, kRealValue(20));
    _streetLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
    _streetLab.font = Font_Regular_Text;
    _streetLab.userInteractionEnabled = NO;
    _streetLab.textAlignment = NSTextAlignmentLeft;
    [topBgView addSubview:_streetLab];
    UITapGestureRecognizer *streetTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(streetTapAction:)];
    [_streetLab addGestureRecognizer:streetTap];

    _lineView = [[UIView alloc]initWithFrame:CGRectMake(_provinceLab.frame.origin.x + kRealValue(3), kRealValue(84) - 1, provinceW - kRealValue(6), kRealValue(3))];
    _lineView.backgroundColor = kSystemColor(1);
//    _lineView.layer.cornerRadius = kRealValue(1.5);
    [_areaWhiteBaseView addSubview:_lineView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kLargeMargin, kRealValue(87)-1, KScreenWidth - kLargeMargin*2, 1)];
    line.backgroundColor = kLineViewColor;
    [_areaWhiteBaseView addSubview:line];

    _areaScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kRealValue(87), KScreenWidth, kRealValue(360-87))];
    _areaScrollView.delegate = self;
    _areaScrollView.contentSize = CGSizeMake(KScreenWidth * 1, kRealValue(360-87));
    _areaScrollView.pagingEnabled = YES;
    _areaScrollView.showsVerticalScrollIndicator = NO;
    _areaScrollView.showsHorizontalScrollIndicator = NO;
    [_areaWhiteBaseView addSubview:_areaScrollView];

    for (int i = 0; i <= _selectViewAccuracy; i++) {
        UITableView *area_tableView = [[UITableView alloc]initWithFrame:CGRectMake(KScreenWidth * i, 0, KScreenWidth, kRealValue(360-87)) style:UITableViewStylePlain];
        area_tableView.backgroundColor = KWhiteColor;
        area_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        area_tableView.delegate = self;
        area_tableView.dataSource = self;
        area_tableView.tag = 200 + i;
        area_tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 0)];
        area_tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, kRealValue(26))];
        [_areaScrollView addSubview:area_tableView];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHidenGes)];
    [blackBaseView addGestureRecognizer:tap];
}
#pragma mark - tapHidenGes
- (void)tapHidenGes
{
    [self hidenAreaView];
}
//#pragma mark - areaBtnAction
//- (void)areaLabAction:(UITapGestureRecognizer *)tap
//{
//    UILabel *areaLab = (UILabel *)tap.view;
//    areaLab.textColor = KUIColorFromRGB(0x0156ff);
//    [UIView animateWithDuration:0.5 animations:^{
//        _areaScrollView.contentOffset = CGPointMake(KScreenWidth * (tap.view.tag - 100), 0);
//    }];
//}
- (void)setProvinceArray:(NSMutableArray *)provinceArray
{
    _provinceArray = provinceArray;
    UITableView *tableView = [_areaScrollView viewWithTag:200];
    [tableView reloadData];
}
- (void)setCityArray:(NSMutableArray *)cityArray
{
    _cityArray = cityArray;
    UITableView *tableView = [_areaScrollView viewWithTag:201];
    [tableView reloadData];
    _areaScrollView.contentSize = CGSizeMake(KScreenWidth * 2, kRealValue(300));
    [UIView animateWithDuration:0.5 animations:^{
        _areaScrollView.contentOffset = CGPointMake(KScreenWidth, 0);
    }];
}

- (void)setAreaArray:(NSMutableArray *)areaArray
{
    _areaArray = areaArray;
    UITableView *tableView = [_areaScrollView viewWithTag:202];
    [tableView reloadData];
    _areaScrollView.contentSize = CGSizeMake(KScreenWidth * 3, kRealValue(300));
    [UIView animateWithDuration:0.5 animations:^{
        _areaScrollView.contentOffset = CGPointMake(KScreenWidth*2, 0);
    }];
}

- (void)setStreetArray:(NSMutableArray *)streetArray
{
    _streetArray = streetArray;
    UITableView *tableView = [_areaScrollView viewWithTag:203];
    [tableView reloadData];
    _areaScrollView.contentSize = CGSizeMake(KScreenWidth * 4, kRealValue(300));
    [UIView animateWithDuration:0.5 animations:^{
        _areaScrollView.contentOffset = CGPointMake(KScreenWidth*3, 0);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag - 200) {
        case AreaSelectViewTypeProvinces:
        {
            return _provinceArray.count;
        }
            break;
        case AreaSelectViewTypeCity:
        {
            return _cityArray.count;
        }
            break;
        case AreaSelectViewTypeArea:
        {
            return _areaArray.count;
        }
            break;
        case AreaSelectViewTypeStreet:
        {
            return _streetArray.count;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRealValue(44);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"area_cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"area_cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(kLargeMargin, kRealValue(24), KScreenWidth - kRealValue(32), kRealValue(20))];
        titleLab.tag = 500;
        titleLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
        titleLab.font = Font_Regular_Text;
        [cell.contentView addSubview:titleLab];
    }
    cell.backgroundColor = KWhiteColor;
    UILabel *titleLab = [cell.contentView viewWithTag:500];
    switch (tableView.tag - 200) {
        case AreaSelectViewTypeProvinces:
        {
            if (_provinceIndex.row == indexPath.row) {
                titleLab.textColor = KUIColorHexValue(0x4A90E2, 1);
            }else{
                titleLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
            }
            XTAreaModel *addressAreaModel = _provinceArray[indexPath.row];
            titleLab.text = addressAreaModel.areaName;
        }
            break;
        case AreaSelectViewTypeCity:
        {
            if (_cityIndex) {
                if (_cityIndex.row == indexPath.row) {
                    titleLab.textColor = KUIColorHexValue(0x4A90E2, 1);
                }else{
                    titleLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
                }
            }else{
                titleLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
            }
            
            XTAreaModel *addressAreaModel = _cityArray[indexPath.row];
            titleLab.text = addressAreaModel.areaName;
        }
            break;
        case AreaSelectViewTypeArea:
        {
            if (_cityIndex) {
                if (_cityIndex.row == indexPath.row) {
                    titleLab.textColor = KUIColorHexValue(0x4A90E2, 1);
                }else{
                    titleLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
                }
            }else{
                titleLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
            }
            
            XTAreaModel *addressAreaModel = _areaArray[indexPath.row];
            titleLab.text = addressAreaModel.areaName;
        }
            break;
        case AreaSelectViewTypeStreet:
        {
            if (_cityIndex) {
                if (_cityIndex.row == indexPath.row) {
                    titleLab.textColor = KUIColorHexValue(0x4A90E2, 1);
                }else{
                    titleLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
                }
            }else{
                titleLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
            }
            
            XTAreaModel *addressAreaModel = _streetArray[indexPath.row];
            titleLab.text = addressAreaModel.areaName;
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *titleLab = [cell.contentView viewWithTag:500];
    titleLab.textColor = KUIColorHexValue(0x4A90E2, 1);
    switch (tableView.tag - 200) {
        case AreaSelectViewTypeProvinces:
        {
            if (_provinceIndex) {
                UITableViewCell *provinceCell = [tableView cellForRowAtIndexPath:_provinceIndex];
                UILabel *provinceLab = [provinceCell.contentView viewWithTag:500];
                provinceLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
            }
            if (_provinceIndex != indexPath) {
                _provinceIndex = indexPath;
                _cityIndex = nil;
            }

            XTAreaModel *addressAreaModel = _provinceArray[indexPath.row];
            
            CGFloat provinceW = [self getTextHeight:addressAreaModel.areaName];
            _provinceLab.frame = CGRectMake(kLargeMargin, kRealValue(55), provinceW, kRealValue(20));
            _provinceLab.textColor = kSystemTextColor(1);
            _provinceLab.text = addressAreaModel.areaName;
            _provinceId = [NSString stringWithFormat:@"%@",addressAreaModel.areaId];
            
            if (_selectViewAccuracy<= AreaSelectViewTypeProvinces) {
                _lineView.frame = CGRectMake(_cityLab.frame.origin.x + kRealValue(3), kRealValue(84) - 1, provinceW - kRealValue(6), kRealValue(3));
                [self hidenAreaView];
                if ([self.address_delegate respondsToSelector:@selector(getSelectProvince:withProvinceId:)]) {
                    [self.address_delegate getSelectProvince:_provinceLab.text withProvinceId:_provinceId];
                }
            }else{
                _provinceLab.userInteractionEnabled = YES;
                _cityLab.userInteractionEnabled = YES;
                _cityLab.text = @"请选择";
                
                CGFloat cityLabX = _provinceLab.frame.origin.x + _provinceLab.frame.size.width + kRealValue(30);
                _cityLab.frame = CGRectMake(cityLabX, kRealValue(55), [self getTextHeight:@"请选择"], kRealValue(20));
                
                CGFloat cityW = [self getTextHeight:@"请选择"];
                _lineView.frame = CGRectMake(_cityLab.frame.origin.x + kRealValue(3), kRealValue(84) - 1, cityW - kRealValue(6), kRealValue(3));
                
                _provinceLab.text = addressAreaModel.areaName;
                _provinceId = [NSString stringWithFormat:@"%@",addressAreaModel.areaId];
                if ([self.address_delegate respondsToSelector:@selector(selectIndex:selectID:)]) {
                    [self.address_delegate selectIndex:tableView.tag - 200+1 selectID:addressAreaModel.areaId];
                }
            }
            
        }
            break;
        case AreaSelectViewTypeCity:
        {
            if (_cityIndex) {
                UITableViewCell *cityCell = [tableView cellForRowAtIndexPath:_cityIndex];
                UILabel *cityLab = [cityCell.contentView viewWithTag:500];
                cityLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
            }
            _cityIndex = indexPath;
            
            XTAreaModel *addressAreaModel = _cityArray[indexPath.row];
            
            _cityLab.text = addressAreaModel.areaName;
            CGFloat cityW = [self getTextHeight:addressAreaModel.areaName];
            _cityId = [NSString stringWithFormat:@"%@",addressAreaModel.areaId];
            _cityLab.frame = CGRectMake(_cityLab.frame.origin.x, _cityLab.frame.origin.y,cityW , kRealValue(20));
            _cityLab.textColor = kSystemTextColor(1);
            
            if (_selectViewAccuracy<=AreaSelectViewTypeCity) {
                _lineView.frame = CGRectMake(_lineView.frame.origin.x, kRealValue(84) - 1, cityW - kRealValue(6), kRealValue(3));
                [self hidenAreaView];
                if ([self.address_delegate respondsToSelector:@selector(getSelectProvince:withCity:withProvinceId:withCityId:)]) {
                    [self.address_delegate getSelectProvince:_provinceLab.text withCity:_cityLab.text withProvinceId:_provinceId withCityId:_cityId];
                }
            }else{
                _areaLab.userInteractionEnabled = YES;
                _areaLab.text = @"请选择";
                CGFloat areaW = [self getTextHeight:@"请选择"];
                CGFloat areaLabX = _cityLab.frame.origin.x + _cityLab.frame.size.width + kRealValue(30);
                _areaLab.frame = CGRectMake(areaLabX, kRealValue(55), areaW, kRealValue(20));
                
                _lineView.frame = CGRectMake(areaLabX + kRealValue(3), kRealValue(84) - 1, areaW - kRealValue(6), kRealValue(3));
                if ([self.address_delegate respondsToSelector:@selector(selectIndex:selectID:)]) {
                [self.address_delegate selectIndex:tableView.tag - 200+1 selectID:addressAreaModel.areaId];
                }
            }
        }
            break;
        case AreaSelectViewTypeArea:
        {
            if (_areaIndex) {
                UITableViewCell *areaCell = [tableView cellForRowAtIndexPath:_areaIndex];
                UILabel *areaLab = [areaCell.contentView viewWithTag:500];
                areaLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
            }
            _areaIndex = indexPath;
            
            XTAreaModel *addressAreaModel = _areaArray[indexPath.row];
            
            _areaLab.text = addressAreaModel.areaName;
            _areaId = [NSString stringWithFormat:@"%@",addressAreaModel.areaId];
            _areaLab.textColor = kSystemTextColor(1);

            CGFloat areaW = [self getTextHeight:addressAreaModel.areaName];
            _areaLab.frame = CGRectMake(_areaLab.frame.origin.x, kRealValue(55), [self getTextHeight:addressAreaModel.areaName], kRealValue(20));
            
            if (_selectViewAccuracy<=AreaSelectViewTypeArea) {
                 _lineView.frame = CGRectMake(_lineView.frame.origin.x, kRealValue(84) - 1, areaW + kRealValue(3), kRealValue(3));
                [self hidenAreaView];
                if ([self.address_delegate respondsToSelector:@selector(getSelectProvince:withCity:withArea:withProvinceId:withCityId:withAreaId:)]) {
                    [self.address_delegate getSelectProvince:_provinceLab.text withCity:_cityLab.text withProvinceId:_provinceId withCityId:_cityId];
                    [self.address_delegate getSelectProvince:_provinceLab.text withCity:_cityLab.text withArea:_areaLab.text withProvinceId:_provinceId withCityId:_cityId withAreaId:_areaId];
                }
            }else{
                _streetLab.userInteractionEnabled = YES;
                _streetLab.text = @"请选择";
                CGFloat streetW = [self getTextHeight:@"请选择"];
                CGFloat streetLabX = _areaLab.frame.origin.x + areaW + kRealValue(30);
                _streetLab.frame = CGRectMake(streetLabX, kRealValue(55), streetW, kRealValue(20));
                
                _lineView.frame = CGRectMake(streetLabX + kRealValue(3), kRealValue(84) - 1, streetW - kRealValue(6), kRealValue(3));
                
                if ([self.address_delegate respondsToSelector:@selector(selectIndex:selectID:)]) {
                [self.address_delegate selectIndex:tableView.tag - 200+1 selectID:addressAreaModel.areaId];
                }
            }
        }
            break;
        case AreaSelectViewTypeStreet:
        {
            if (_streetIndex) {
                UITableViewCell *cityCell = [tableView cellForRowAtIndexPath:_streetIndex];
                UILabel *cityLab = [cityCell.contentView viewWithTag:500];
                cityLab.textColor = KUIColorHexValue(0x272f3d, 0.7);
            }
            _streetIndex = indexPath;
            
            XTAreaModel *addressAreaModel = _streetArray[indexPath.row];
            
            _streetLab.text = addressAreaModel.areaName;
            _streetLab.textColor = kSystemTextColor(1);
            _streetId = [NSString stringWithFormat:@"%@",addressAreaModel.areaId];

            CGFloat streetLabX = _areaLab.frame.origin.x + _areaLab.frame.size.width + kRealValue(30);
            _streetLab.frame = CGRectMake(streetLabX, kRealValue(55), [self getTextHeight:addressAreaModel.areaName], kRealValue(20));
            
            CGFloat streetW = [self getTextHeight:addressAreaModel.areaName];
            _lineView.frame = CGRectMake(streetLabX + kRealValue(3), kRealValue(84) - 1, streetW - kRealValue(6), kRealValue(3));
            
            if (_selectViewAccuracy<=AreaSelectViewTypeStreet) {
                [self hidenAreaView];
                if ([self.address_delegate respondsToSelector:@selector(getSelectProvince:withCity:withArea:withStreet:withProvinceId:withCityId:withAreaId:withStreetId:)]) {
                    [self.address_delegate getSelectProvince:_provinceLab.text withCity:_cityLab.text withArea:_areaLab.text withStreet:_streetLab.text withProvinceId:_provinceId withCityId:_cityId withAreaId:_areaId withStreetId:_streetId];
                }
            }
        }
            break;
            
        default:
            break;
    }
    [tableView reloadData];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _areaScrollView) {
        int index = scrollView.contentOffset.x / KScreenWidth ;
        switch (index) {
            case AreaSelectViewTypeProvinces:
                _lineView.frame = CGRectMake(_provinceLab.frame.origin.x + kRealValue(3), kRealValue(84) - 1, _provinceLab.frame.size.width - kRealValue(6), kRealValue(3));
                break;
                
            case AreaSelectViewTypeCity:
                _lineView.frame = CGRectMake(_cityLab.frame.origin.x + kRealValue(3), kRealValue(84) - 1, _cityLab.frame.size.width - kRealValue(6), kRealValue(3));
            break;
            
            case AreaSelectViewTypeArea:
                _lineView.frame = CGRectMake(_areaLab.frame.origin.x + kRealValue(3), kRealValue(84) - 1, _areaLab.frame.size.width - kRealValue(6), kRealValue(3));
            break;
            
            case AreaSelectViewTypeStreet:
                _lineView.frame = CGRectMake(_streetLab.frame.origin.x + kRealValue(3), kRealValue(84) - 1, _streetLab.frame.size.width - kRealValue(6), kRealValue(3));
            break;
            
            default:
                break;
        }
    }
}
#pragma mark - showAreaView
- (void)showAreaView
{
    UIWindow *wind = [UIApplication sharedApplication].keyWindow;
    [wind addSubview:self];
    [UIView animateWithDuration:0.35 animations:^{
        blackBaseView.alpha = 0.3;
        _areaWhiteBaseView.frame = CGRectMake(0, KScreenHeight - kRealValue(360), KScreenWidth, kRealValue(360));
    }];
}

#pragma mark - hidenAreaView
- (void)hidenAreaView
{
    [UIView animateWithDuration:0.35 animations:^{
        blackBaseView.alpha = 0;
        _areaWhiteBaseView.frame = CGRectMake(0, KScreenHeight, KScreenWidth, kRealValue(360));
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)provinceTapAction:(UITapGestureRecognizer *)tap
{
    _cityLab.text = @"";
    _areaLab.text = @"";
    _streetLab.text = @"";
    _cityLab.userInteractionEnabled = NO;
    _areaLab.userInteractionEnabled = NO;
    _streetLab.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _areaScrollView.contentOffset = CGPointMake(0, 0);
    }];
}

- (void)cityTapAction:(UITapGestureRecognizer *)tap
{
    _areaLab.text = @"";
    _streetLab.text = @"";
    _areaLab.userInteractionEnabled = NO;
    _streetLab.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _areaScrollView.contentOffset = CGPointMake(KScreenWidth, 0);
    }];
}

- (void)areaTapAction:(UITapGestureRecognizer *)tap
{
    _streetLab.text = @"";
    _streetLab.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _areaScrollView.contentOffset = CGPointMake(KScreenWidth*2, 0);
    }];
}


- (void)streetTapAction:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.5 animations:^{
        _areaScrollView.contentOffset = CGPointMake(KScreenWidth*3, 0);
    }];
}

- (void)areaCloseBtnAction
{
    [self hidenAreaView];
}
//获取文本的高度
- (float)getTextHeight:(NSString *)text
{
    if (text && text.length != 0)
    {
        CGSize constraint = CGSizeMake(CGFLOAT_MAX, kRealValue(20));
        UIFont *font = Font_Regular_Text;
        CGRect sizeToFit = [text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
        return sizeToFit.size.width;
    }
    return 0;
}

@end
