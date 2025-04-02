import 'package:flutter/material.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';
import 'package:salt_ware_tax/profile/model/name_model.dart';
import 'package:salt_ware_tax/profile/model/profile_model.dart';
import 'package:salt_ware_tax/profile/repository/profile_repository.dart';


class ProfileViewModel extends ChangeNotifier {
  final ProfileRepository _profileRepository = ProfileRepository();

  ProfileResponse? _userProfileDetails;
  ProfileResponse? get userProfileDetails => _userProfileDetails;

  NameResponse? _userNameDetails;
  NameResponse? get userNameDetails => _userNameDetails;

  //userProfileDetails
  Future<void> getProfileDetails(String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _profileRepository.getProfileDetails(userId);
      if (response.status == 200) {
        _setUserProfileDetails(response.data.first);
        getUserNameDetails(userId, context);
      }
    } catch (e) {
      _showErrorMessage("Wrong..!", context);
      CustomLoader.hideLoader();
    }
  }

  //userNameDetails
  Future<void> getUserNameDetails(String userId, BuildContext context) async {
    try {
      final response = await _profileRepository.getNameDetails(userId);
      if (response.status == 200) {
        _setUserNameDetails(response.data.first);
      }
    } catch (e) {
      _showErrorMessage("Wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
    }
  }

  // //deleteDoctorProfileDetails
  // Future<void> deleteDoctorDetails(
  //     String doctorId, String userId, BuildContext context) async {
  //   _setLoading(true);
  //   try {
  //     final response =
  //         await _doctorProfileRepository.deleteDoctorProfile(doctorId, userId);
  //     if (response.status == 200) {
  //       _setLoading(false);
  //       Navigator.of(context).pop(true);
  //     }
  //   } catch (e) {
  //     _showErrorMessage("Wrong..!", context);
  //     _setLoading(false);
  //   }
  // }

  void _setUserProfileDetails(ProfileResponse profileResponse) {
    _userProfileDetails = profileResponse;
    notifyListeners();
  }

  void _setUserNameDetails(NameResponse nameResponse) {
    _userNameDetails = nameResponse;
    notifyListeners();
  }

  //error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
