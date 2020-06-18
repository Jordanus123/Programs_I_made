
import 'dart:io';

class UserRegistrationModel{

  String name, jobTitle, school, address, userId, bio,
   emailAddress, password, latitude, longitude, age, contactNumber, gender;

  File userImage;
	String fileExtention, imageUrl;

  void setUserId(userId) => this.userId = userId;
  void setBio(bio) => this.bio = bio;
  void setName(name) => this.name = name;
  void setJobTitle(jobTitle) => this.jobTitle = jobTitle;
  void setSchool(school) => this.school = school;
  void setAddress(address) => this.address = address;
  void setEmailAddress(emailAddress) => this.emailAddress = emailAddress;
  void setPassword(password) => this.password = password;
  void setContactNumber(contactNumber) => this.contactNumber = contactNumber;
  void setGender(gender) => this.gender = gender;

  void setLatitude(latitude) => this.latitude = latitude;
  void setLongitude(longitude) => this.longitude = longitude;
  void setAge(age) => this.age = age;

  void setUserImage(userImage) => this.userImage = userImage;
  void setFileExtention(fileExtention) => this.fileExtention = fileExtention;
  void setImageUrl(imageUrl) => this.imageUrl = imageUrl;

  UserRegistrationModel({
    this.name = "",
    this.bio = "",
    this.jobTitle = "",
    this.school = "",
    this.address = "",
    this.userId = "",
    this.latitude = "",
    this.longitude = "",
    this.emailAddress = "",
    this.password = "",
    this.contactNumber = "",
    this.gender = "",
    this.age = "",
    this.userImage,
    this.fileExtention = "",
    this.imageUrl = "",
  });

}