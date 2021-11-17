import 'package:flutter/material.dart';

//stateless widget yapıyoruz çünkü herhangi bir ver işleme durumu yok sadece bir görüntü
class SocialLoginButton extends StatelessWidget {
  final String
      butonText; //ileride atayacağımız değerler değişmeyecek o yüzden final tanımlıyoruz
  final Color butonColor;
  final Color textColor;
  final double radius; //kenarların ovalliği
  final double yukseklik;
  final Widget
      butonIcon; //buranın en üst sınıfı Widget yaptık oyuzden icon ya da bir görüntü yollayabiliyoruz
  final VoidCallback onPressed;

  const SocialLoginButton(
      {Key key,
      @required this.butonText,
      this.butonColor: Colors.purple,
      this.textColor: Colors.white,
      this.radius:
          16, //herhang bir değer verilmezse radius 16 olarak kabul edilsin
      this.yukseklik: 40,
      this.butonIcon,
      @required this.onPressed})
      : assert(butonText != null, onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: yukseklik,
        child: RaisedButton(
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Row(
              //row soldan sağa doğru elemanları diziyor
              mainAxisSize: MainAxisSize
                  .max, //burayı maz yaparsak bütün elemanlar soldan sağa doğru tüm alanı kaplar
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //spreads, Collection-if, Collection-For
                if (butonIcon != null) ...[
                  butonIcon,
                  Text(
                    butonText,
                    style: TextStyle(color: textColor),
                  ),
                  Opacity(opacity: 0, child: butonIcon)
                ],

                if (butonIcon == null) ...[
                  Container(),
                  Text(
                    butonText,
                    style: TextStyle(color: textColor),
                  ),
                  Container(),
                ]
              ],
            ),
            color: butonColor),
      ),
    );
  }
}
