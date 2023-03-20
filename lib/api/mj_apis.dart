class MJ_Apis{
  static const APP_BASE_URL = "https://absher.junaidali.tk/";
  // static const APP_BASE_URL = "http://127.0.0.1:8000/";
  static const BASE_URL = APP_BASE_URL+"api/v1/";
  static const storagePath = "storage/app/public/";
  /////////path to the images
  static const prefix = 'delivery-man';
  static const bannerImgPath = APP_BASE_URL+ storagePath+"banner/";
  static const restaurantCoverImgPath = APP_BASE_URL+ storagePath+"restaurant/cover/";
  static const restaurantImgPath = APP_BASE_URL+ storagePath+"restaurant/";
  static const productImgPath = APP_BASE_URL+ storagePath+"product/";
  static const categoryImgPath = APP_BASE_URL+ storagePath+"category/";
  static const serviceImgPath = APP_BASE_URL+ storagePath+"service/";
  static const profileImgPath = APP_BASE_URL+ storagePath+"profile/";
  static const signup = "auth/sign-up";
  static const login = "auth/${prefix}/login";
  static const profile = "${prefix}/profile";
  static const update_profile = "$prefix/update-profile"; //post request
  static const get_queries = "queries/get_queries"; //get request ?role=rider&parent_id=1
  static const send_request = "queries/send_request"; //post

  static const shifts = "${prefix}/shifts"; //POST date
  static const upcoming_shifts = "${prefix}/upcoming_shifts"; //POST date
  static const take_shift = "${prefix}/take_shift"; //POST date
  static const end_shift = "${prefix}/end_shift"; //GET date
  static const current_shift = "${prefix}/current_shift"; //POST date
  static const start_shift = "${prefix}/start_shift"; //POST date
  static const order_details = "${prefix}/order_details"; //Get date
  static const accept_order = "${prefix}/accept_order"; //Get date
  static const get_zone_id = "config/get-zone-id"; //Get date
}
