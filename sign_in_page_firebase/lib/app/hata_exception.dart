class Hatalar {
  //static tanımlayınca sınıftan nesne üretmeden ulaşabileceğiiz bir metot tnımlamış oluyoruz
  static String goster(String hataKodu) {
    switch (hataKodu) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return "Bu mail adresi zaten kullanımda, lütfen farklı bir mail adresi kullanınız";
      case "ERROR_USER_NOT_FOUND":
        return "Bu kullanıcı sistemde bulunmamamktadır. Lütfen önce kullanıcı oluşturun";
      case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
        return "Facebook hesabınızdaki mail adresi daha önce gmail veya email yöntemi ile sisteme kaydedilmiştir. Lütfen bu mail adresi ile giriş yapın.";
      default:
        return "Bir hata oluştu";
    }
  }
}
