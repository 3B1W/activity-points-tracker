//package com.example.activitypointstracker.mapper;
//
//import com.example.activitypointstracker.dto.UserRegistrationDto;
//import com.example.activitypointstracker.entity.User;
//
//public class UserMapper {
//    public static UserRegistrationDto mapUsertoDto(User usernew){
//        return new UserRegistrationDto(
//                usernew.getId(),
//                usernew.getFname(),
//                usernew.getLname(),
//                usernew.getEmail(),
//                usernew.getPassword(),
//                usernew.getRoles()
//        );
//    }
//
//    public static User mapUserDtotoUser(UserRegistrationDto usernew){
//        return new User(
//                usernew.getId(),
//                usernew.getFname(),
//                usernew.getLname(),
//                usernew.getEmail(),
//                usernew.getPassword(),
//                usernew.getRoles()
//        );
//    }
//}
