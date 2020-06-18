
class ScreensModel{
  
  String userId, userName;
  int selectedTabIndex;

  void setUserId(userId) => this.userId = userId;
  void setUserName(userName) => this.userId = userName;
  void setSelectedTabIndex(selectedTabIndex) => this.selectedTabIndex = selectedTabIndex;

  ScreensModel({
    this.userId,
    this.userName,
    this.selectedTabIndex
  });

}