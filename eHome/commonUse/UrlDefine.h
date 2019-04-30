//
//  UrlDefine.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/15.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#ifndef UrlDefine_h
#define UrlDefine_h


// 控制测试环境和真实环境之间的切换
// 测试环境：0
// 真实环境：1
#define IS_FORMAL 0
#if IS_FORMAL
#define DefaultUrl @"https://www.baojinsuo.com/"
#else
#define DefaultUrl @"http://192.168.34.3:8080/ehome/"
#endif
#define GetBannerList ([NSString stringWithFormat:@"%@manage/service/Manage.getBannerList.json",DefaultUrl])
#define GetInfoList ([NSString stringWithFormat:@"%@manage/service/Manage.getInfoList.json",DefaultUrl])
#define GetBookList ([NSString stringWithFormat:@"%@manage/service/Manage.getBookList.json",DefaultUrl])
#define GetBookInfo ([NSString stringWithFormat:@"%@app/service/App.getBook.json",DefaultUrl])

//获取行动详情
#define getActionDetail ([NSString stringWithFormat:@"%@app/service/App.getActionDetail.json",DefaultUrl])
//获取行动接口
#define GetActionList ([NSString stringWithFormat:@"%@manage/service/Manage.getActionList.json",DefaultUrl])

//上传图书信息
#define UploadImage ([NSString stringWithFormat:@"%@app/service/App.addBook.json",DefaultUrl])

//收藏和取消收藏
#define ChangeCollection ([NSString stringWithFormat:@"%@app/service/App.changeCollection.json",DefaultUrl])

//点赞和取消点赞
#define ChangeSupport ([NSString stringWithFormat:@"%@app/service/App.changeSupport.json",DefaultUrl])
//添加评论接口
#define AddComment ([NSString stringWithFormat:@"%@app/service/App.addComment.json",DefaultUrl])

//获取评论列表
#define getCommentList ([NSString stringWithFormat:@"%@app/service/App.getCommentList.json",DefaultUrl])

//上传发现了没
#define addDiscorvey ([NSString stringWithFormat:@"%@app/service/App.addDiscovery.json",DefaultUrl])
//获取发现了没列表
#define getDiscorveyList ([NSString stringWithFormat:@"%@app/service/App.getDiscoveryList.json",DefaultUrl])


//上传步数
#define sendStepCount ([NSString stringWithFormat:@"%@app/service/App.sendStepCount.json",DefaultUrl])

//获取最近几天步数排名
#define getStepRankingList ([NSString stringWithFormat:@"%@app/service/App.getUserStepRanking.json",DefaultUrl])
//获取某天步数详细排名
#define getStepRankingByDate ([NSString stringWithFormat:@"%@app/service/App.getStepRankingByDate.json",DefaultUrl])


//步数点赞
#define addStepSupport ([NSString stringWithFormat:@"%@app/service/App.addStepSupport.json",DefaultUrl])

//登录
#define UserLogin ([NSString stringWithFormat:@"%@manage/service/Manage.login.json",DefaultUrl])

//修改密码
#define updatePassword ([NSString stringWithFormat:@"%@app/service/App.updatePassword.json",DefaultUrl])


//获取收藏图书列表
#define getMyBookList ([NSString stringWithFormat:@"%@app/service/App.getMyBookList.json",DefaultUrl])
//上传头像
#define addImageHeader ([NSString stringWithFormat:@"%@app/service/App.addImageHeader.json",DefaultUrl])

//修改用户信息
#define updateUserInfo ([NSString stringWithFormat:@"%@app/service/App.updateUserInfo.json",DefaultUrl])

//获取消息列表
#define getMyMessageList ([NSString stringWithFormat:@"%@app/service/App.getMyMessageList.json",DefaultUrl])

#endif /* UrlDefine_h */
