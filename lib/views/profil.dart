import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meditasyon/controllers/config.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:meditasyon/views/hesapdegistir.dart';
import 'package:meditasyon/views/otherloginpage.dart';
import 'package:meditasyon/views/sifredegistir.dart';
import 'package:meditasyon/wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

/*      Color.fromRGBO(43, 43, 64, 1),
                              Color.fromRGBO(109, 116, 161, 1), */
import '../widgets/modalbottom.dart';
import 'premiumayrıcalık.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class CustomListTile extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onTap;

  const CustomListTile({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4.0),
      child: ListTile(
        leading: Container(
          width: size.width * 0.1,
          height: size.width * 0.1,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.1),
            shape: BoxShape.circle,
          ),
          child: icon, // Use the provided icon widget
        ),
        title: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: size.width * 0.037,
          ),
        ),
        trailing: SvgPicture.asset(
          'assets/arrow.svg',
          width: 18,
          height: 18,
        ),
        onTap: onTap,
      ),
    );
  }
}

class _ProfilState extends State<Profil> {
  String kullanici =
      """ <p>Spiritya Kullan&#305;c&#305; S&ouml;zle&#351;mesi</p>

<p>1. TARAFLAR &#304;&#351;bu &Uuml;yelik S&ouml;zle&#351;mesi (bundan sonra &ldquo;S&ouml;zle&#351;me&rdquo; olarak an&#305;lacakt&#305;r.) Spiritya E&#287;itim ve Dan&#305;&#351;manl&#305;k A.&#350;. (Mersis No: 925080218600001), (bundan sonra &ldquo;Spiritya&rdquo; olarak an&#305;lacakt&#305;r) ile spiritya.com adresinden ve/veya mobil cihaz, ak&#305;ll&#305; televizyon ve benzeri cihazlar &uuml;zerinde yer alan uygulamalar&#305;ndan Spiritya&rsquo;n&#305;n sundu&#287;u &uuml;cretli ve/veya &uuml;cretsiz video, m&uuml;zik, canl&#305; TV yay&#305;n&#305;, oyun ve benzeri i&ccedil;erik hizmetlerinden (bundan sonra &ldquo;Dijital &#304;&ccedil;erik&rdquo; olarak an&#305;lacakt&#305;r) kendisi ve/veya kanuni temsilcisi oldu&#287;u k&uuml;&ccedil;&uuml;kler i&ccedil;in faydalanmak amac&#305;yla i&#351;bu S&ouml;zle&#351;meyi onaylamak isteyen t&uuml;ketici (bundan sonra &ldquo;ALICI&rdquo; olarak an&#305;lacakt&#305;r) aras&#305;nda ALICI&rsquo;n&#305;n elektronik ortamda bulunan &ldquo;&Uuml;yelik S&ouml;zle&#351;mesini Kabul Ediyorum&rdquo; butonunu t&#305;klamas&#305; ve kabul beyan&#305;n&#305;n Spiritya kay&#305;tlar&#305;na ge&ccedil;ti&#287;i an kurulmu&#351; ve y&uuml;r&uuml;rl&uuml;&#287;e girmi&#351;tir.</p>

<p>2. &Ouml;N B&#304;LG&#304;LEND&#304;RME TEY&#304;D&#304; ALICI, Mesafeli S&ouml;zle&#351;meler Y&ouml;netmeli&#287;i&rsquo;ne uygun olarak sat&#305;&#351;a konu dijital i&ccedil;erik hizmetlerin temel nitelikleri, bedelsiz olup olmad&#305;&#287;&#305; sat&#305;&#351; bedeli, &ouml;deme &#351;ekli ve di&#287;er t&uuml;m hususlarda bilgi sahibi oldu&#287;unu ve kendisine &ouml;n bilgilendirmenin yap&#305;lm&#305;&#351; oldu&#287;unu ve i&#351;bu S&ouml;zle&#351;me&rsquo;nin ba&#287;lay&#305;c&#305; oldu&#287;unu kabul ve beyan eder. Mesafeli S&ouml;zle&#351;meler Y&ouml;netmeli&#287;i&rsquo;ne uygun olarak dijital i&ccedil;erik hizmetlerin temel nitelikleri, bedeli, &ouml;deme &#351;ekli ve di&#287;er t&uuml;m hususlar uygulamada yer almaktad&#305;r.</p>

<p></p>

<p>3. S&Ouml;ZLE&#350;ME KONUSU H&#304;ZMETLER VE &Ouml;ZELL&#304;KLER&#304; &#304;&#351;bu S&ouml;zle&#351;menin konusu ALICI&rsquo;n&#305;n, Dijital &#304;&ccedil;erik Hizmetleri&rsquo;ne abone olmas&#305;n&#305;n &#351;ekil ve &#351;artlar&#305;n&#305;n ve taraflar&#305;n kar&#351;&#305;l&#305;kl&#305; hak ve y&uuml;k&uuml;ml&uuml;l&uuml;klerinin tespitidir. Dijital &#304;&ccedil;erik Hizmetleri&rsquo;nin &ouml;zellikleri ve kullan&#305;m ko&#351;ullar&#305; spiritya.com adl&#305; web sitesindeki tan&#305;t&#305;m sayfas&#305;nda ve/veya uygulama ekran&#305;nda belirtildi&#287;i gibidir. &#304;&#351;bu S&ouml;zle&#351;me ile Spiritya, spiritya.com adresinde ve/veya mobil cihaz, ak&#305;ll&#305; televizyon ve benzeri cihazlar &uuml;zerinde yer alan uygulamalar&#305;ndan Spiritya&rsquo;n&#305;n sundu&#287;u ve kendisinin tek tarafl&#305; takdir hakk&#305;na ba&#287;l&#305; olarak belirlenecek Dijital &#304;&ccedil;erik Hizmetlerini, se&ccedil;ilen hizmet kategorisine ili&#351;kin lisans s&#305;n&#305;rlamalar&#305; dahilinde, &ouml;nceden belirtilen fiyat ve ko&#351;ullarda ALICI&rsquo;ya sunmay&#305;; ALICI&rsquo;da kullan&#305;m &#351;artlar&#305;n&#305; kabul ederek hizmet bedelini tam ve zaman&#305;nda Spiritya&rsquo;a &ouml;demeyi taahh&uuml;t eder. ALICI, Dijital &#304;&ccedil;erik Hizmetleri&rsquo;nin fiziksel bir teslimat&#305;n&#305;n olmad&#305;&#287;&#305;n&#305;, gayri maddi nitelikte olan Dijital &#304;&ccedil;erik Hizmetleri&rsquo;nin elektronik ortamda sunulaca&#287;&#305;n&#305; ve teslim edilece&#287;ini kabul eder.</p>

<p> 4. S&Ouml;ZLE&#350;ME TAR&#304;H&#304; &#304;&#351;bu S&ouml;zle&#351;me, ALICI taraf&#305;ndan S&ouml;zle&#351;me&rsquo;nin okundu&#287;unun ve kabul edildi&#287;inin beyan edilmesiyle akdedilmi&#351; olup ve bu andan itibaren h&uuml;k&uuml;m ve sonu&ccedil; do&#287;uracakt&#305;r.</p>

<p> 5. &Uuml;YEL&#304;K &#304;&#350;LEMLER&#304; a. ALICI, kay&#305;t s&#305;ras&#305;nda vermi&#351; oldu&#287;u elektronik posta adresi ile bir &uuml;yelik olu&#351;turma imkan&#305;na sahiptir. Ayn&#305; elektronik posta adresi ile birden fazla &uuml;yelik olu&#351;turulamaz. ALICI, kay&#305;t s&#305;ras&#305;nda vermi&#351; oldu&#287;u elektronik posta adresini kullan&#305;c&#305; ad&#305; olarak kullanacak ve kendi belirleyece&#287;i &#351;ifreye sahip olacakt&#305;r. ALICI, &#351;ifresini diledi&#287;i zaman de&#287;i&#351;tirebilir. &#350;ifre se&ccedil;imi, de&#287;i&#351;imi ve korunmas&#305;na dair sorumluluk tamamen ALICI&rsquo;ya aittir.</p>

<p>b. ALICI, &uuml;yelik olu&#351;turulmas&#305; ve hizmetlerin kullan&#305;lmas&#305; s&#305;ras&#305;nda, gerek kendisi gerek velisi oldu&#287;u k&uuml;&ccedil;&uuml;kler i&ccedil;in alt kullan&#305;c&#305;lar olu&#351;turabilir. ALICI, Spiritya&rsquo;a bildirdi&#287;i t&uuml;m bilgilerin do&#287;ru oldu&#287;unu ve bu bilgilerin gerekli oldu&#287;u durumlarda hatal&#305; veya noksan olmas&#305;ndan kaynaklanabilecek sorunlardan Spiritya&rsquo;n&#305;n bir sorumlulu&#287;u bulunmad&#305;&#287;&#305;n&#305; kabul, beyan ve taahh&uuml;t eder. ALICI&rsquo;n&#305;n bilgilerinde de&#287;i&#351;iklik olmas&#305; halinde s&ouml;z konusu bilgilerin g&uuml;ncellenmesi ALICI&rsquo;n&#305;n sorumlulu&#287;undad&#305;r.</p>

<p>c. ALICI, S&ouml;zle&#351;me konusu Dijital &#304;&ccedil;erik Hizmetleri&rsquo;ni belirledi&#287;i kullan&#305;c&#305; ad&#305; ve &#351;ifrenin girilmesi suretiyle kullanabilece&#287;ini, kullan&#305;c&#305; ad&#305; ve/veya &#351;ifrenin hatal&#305; girilmesi nedeniyle hizmetlerin kullan&#305;lamamas&#305;ndan Spiritya&rsquo;n&#305;n sorumlu olmad&#305;&#287;&#305;n&#305; kabul, beyan ve taahh&uuml;t eder.</p>

<p>d. ALICI, &#351;ifre ve kullan&#305;c&#305; ad&#305;n&#305;n gizli kalmas&#305; i&ccedil;in gerekli dikkat ve &ouml;zeni g&ouml;sterece&#287;ini, &#351;ifreyi ve kullan&#305;c&#305; ad&#305;n&#305; herhangi bir &uuml;&ccedil;&uuml;nc&uuml; ki&#351;iye a&ccedil;&#305;klamayaca&#287;&#305;n&#305;, kulland&#305;rmayaca&#287;&#305;n&#305;, &#351;ifresinin yetkisiz &uuml;&ccedil;&uuml;nc&uuml; ki&#351;iler taraf&#305;ndan ele ge&ccedil;irildi&#287;ini &ouml;&#287;renmesi veya bundan &#351;&uuml;phelenmesi halinde derhal Spiritya&rsquo;a haber verece&#287;ini, &#351;ifre ve kullan&#305;c&#305; ad&#305;n&#305;n &uuml;&ccedil;&uuml;nc&uuml; &#351;ah&#305;slar taraf&#305;ndan kullan&#305;lmas&#305; sebebiyle do&#287;acak zararlardan Spiritya&rsquo;n&#305;n sorumlu olmayaca&#287;&#305;n&#305; kabul ve taahh&uuml;t eder.</p>

<p> 6. TARAFLARIN BEYAN VE TAAHH&Uuml;TLER&#304; a. ALICI, i&#351;bu S&ouml;zle&#351;me&rsquo;nin y&uuml;r&uuml;rl&uuml;&#287;e girmesiyle birlikte, S&ouml;zle&#351;me konusu Dijital &#304;&ccedil;erik Hizmetleri&rsquo;ni sat&#305;n alarak, spiritya.com ve uygulamalar&#305;nda belirtilen kullan&#305;m &#351;artlar&#305; ve s&#305;n&#305;rland&#305;rmalar kapsam&#305;nda hizmet alma hakk&#305;n&#305; elde etmi&#351;tir.</p>

<p>b. ALICI, Spiritya&rsquo;n&#305;n sundu&#287;u ve 5846 say&#305;l&#305; Fikir ve Sanat Eserleri Kanunu&rsquo;na uygun olarak mali haklar&#305;na/kullan&#305;m yetkisine/lisans haklar&#305;na sahip oldu&#287;u Dijital &#304;&ccedil;erik Hizmetleri&rsquo;nin ancak i&#351;bu S&ouml;zle&#351;me &#351;artlar&#305; kapsam&#305;nda bireysel ama&ccedil;la kullan&#305;labilece&#287;ini ve S&ouml;zle&#351;me ile a&ccedil;&#305;k&ccedil;a belirtilmemi&#351; hi&ccedil;bir yetkinin ALICI&rsquo;ya devredilmemi&#351; oldu&#287;unu kabul, beyan ve taahh&uuml;t eder.</p>

<p>c. Spiritya&rsquo;n&#305;n i&#351;bu S&ouml;zle&#351;me kapsam&#305;nda Dijital &#304;&ccedil;erik Hizmetleri sunuyor olmas&#305;n&#305;n, ALICI&rsquo;ya donan&#305;m ve/veya yaz&#305;l&#305;m temini veya mevcut donan&#305;m ve/veya yaz&#305;l&#305;m&#305;n d&uuml;zg&uuml;n &ccedil;al&#305;&#351;mas&#305; konusunda bir taahh&uuml;t ya da garanti verdi&#287;i anlam&#305;na gelmemektedir.</p>

<p>d. Spiritya teknik sorun ve/veya geli&#351;tirmelerden kaynaklanan nedenlerle herhangi bir zamanda sistemin &ccedil;al&#305;&#351;mas&#305;n&#305; ve hizmetlerin verilmesini ge&ccedil;ici olarak ask&#305;ya alabilecek veya tamamen durdurabilecektir. ALICI, bu nedenle hizmetlerin ge&ccedil;ici bir s&uuml;re i&ccedil;in ask&#305;ya al&#305;nmas&#305;ndan dolay&#305; Spiritya&rsquo;dan herhangi bir nam alt&#305;nda tazminat ve benzeri hak ve bedel talep etmeyece&#287;ini kabul, beyan ve taahh&uuml;t eder.</p>

<p>e. Spiritya&rsquo;n&#305;n sundu&#287;u Dijital &#304;&ccedil;erik Hizmetleri, sekt&ouml;rel standartlar paralelinde, m&uuml;mk&uuml;n oldu&#287;unca kesintisiz, s&uuml;rekli, g&uuml;venli ve kaliteli olacakt&#305;r. ALICI, internette ya&#351;anan kesintiler, h&#305;z d&uuml;&#351;mesi ve benzeri sebeplerle hizmette ya&#351;anacak kesinti, g&ouml;r&uuml;nt&uuml; kalitesi ve g&uuml;venlik problemlerinden ve/veya &uuml;lkede genel bir kar&#305;&#351;&#305;kl&#305;&#287;&#305;n ortaya &ccedil;&#305;kmas&#305; sava&#351;, ter&ouml;r, grev, genel elektrik kesintisi, deprem, su bask&#305;n&#305;, ola&#287;an&uuml;st&uuml; hal, siber sald&#305;r&#305;, cihazlara vir&uuml;s bula&#351;m&#305;&#351; olmas&#305; veya benzeri bir m&uuml;cbir sebeple hizmetin verilmesine ili&#351;kin ya&#351;anacak sorunlardan Spiritya&rsquo;n&#305;n sorumlu olmayaca&#287;&#305;n&#305; kabul ve taahh&uuml;t eder.</p>

<p>f. Spiritya Dijital &#304;&ccedil;erik Hizmetlerini sundu&#287;u internet sitesine ait alan ad&#305;n&#305; ve internet sitesi ve/veya uygulamalar&#305;n g&ouml;r&uuml;n&uuml;m&uuml;n&uuml;, i&ccedil;eri&#287;ini ve dijital i&ccedil;erikleri her zaman i&ccedil;in de&#287;i&#351;tirme hakk&#305;n&#305; sakl&#305; tutar.</p>

<p>g. ALICI, Spiritya&rsquo;n&#305;n teknik zorunluluklar veya mevzuatta meydana gelecek de&#287;i&#351;iklikler ve benzeri zorlay&#305;c&#305; sebeplerle, i&#351;bu S&ouml;zle&#351;me h&uuml;k&uuml;mlerini tek tarafl&#305; olarak de&#287;i&#351;tirebilece&#287;ini, yeni maddeler ekleyebilece&#287;ini veya maddeleri &ccedil;&#305;karabilece&#287;ini kabul, beyan ve taahh&uuml;t eder.</p>

<p>h. ALICI, i&#351;bu S&ouml;zle&#351;me ile faydalanmak istedi&#287;i &uuml;cretli hizmetlerden faydalanabilmek i&ccedil;in bilgisayar&#305;n&#305;n yahut &uuml;r&uuml;n ve/veya hizmeti kullanaca&#287;&#305; di&#287;er elektronik cihazlar ile teknik donan&#305;m&#305;n&#305;n hizmetlere uygun gerekli asgari kriterleri kar&#351;&#305;lad&#305;&#287;&#305;n&#305;, bu kriterlere uygun olmayan bilgisayar ve/veya teknik donan&#305;m sebebiyle hizmetlerden faydalanamama durumunda, Spiritya&rsquo;dan herhangi bir sorumlulu&#287;unun olmad&#305;&#287;&#305;n&#305;, herhangi bir nam alt&#305;nda Spiritya&rsquo;dan herhangi bir talepte bulunmayaca&#287;&#305;n&#305; kabul, beyan ve taahh&uuml;t eder.</p>

<p>i. ALICI, verilen hizmetin internet &uuml;zerinden veri ak&#305;&#351;&#305; ile ger&ccedil;ekle&#351;en bir hizmet oldu&#287;unu, ALICI&rsquo;n&#305;n hizmetlerden yararland&#305;&#287;&#305; s&#305;rada ba&#287;lant&#305; kurdu&#287;u internet paketinin kotas&#305;n&#305;n bu durumdan etkilenece&#287;ini ve Spiritya&rsquo;n&#305;n olu&#351;abilecek eri&#351;im giderleri, kota a&#351;&#305;m&#305; ve sonu&ccedil;lar&#305;ndan sorumlu olmad&#305;&#287;&#305;n&#305; kabul, beyan ve taahh&uuml;t eder.</p>

<p></p>

<p>7. K&#304;&#350;&#304;SEL VER&#304;LER&#304;N KORUNMASI a. Spiritya, ALICI&rsquo;ya daha iyi hizmet verebilmek ve &uuml;r&uuml;n sunabilmek ad&#305;na ve ALICI&rsquo;n&#305;n beklentilerine daha uygun i&ccedil;erikler sa&#287;lamak amac&#305;yla, 6698 say&#305;l&#305; Ki&#351;isel Verilerin Korunmas&#305; Kanunu, 6563 Say&#305;l&#305; Elektronik Ticaretin D&uuml;zenlenmesi Hakk&#305;nda Kanun, 5237 Say&#305;l&#305; T&uuml;rk Ceza Kanunu 6502 say&#305;l&#305; T&uuml;keticinin Korunmas&#305; Hakk&#305;nda Kanun ve Mesafeli S&ouml;zle&#351;meler Y&ouml;netmeli&#287;i&rsquo;nden do&#287;an y&uuml;k&uuml;ml&uuml;l&uuml;kleri kapsam&#305;nda spiritya.com ve uygulamalar&#305; veya &ccedil;a&#287;r&#305; merkezi &uuml;zerinden ALICI&rsquo;n&#305;n yahut kanuni temsilcisi oldu&#287;u alt kullan&#305;c&#305;lar&#305;n alt ad&#305;, soyad&#305;, do&#287;um tarihi, adresi, telefon numaras&#305;, elektronik posta adresi gibi &ouml;zel nitelikli olmayan ki&#351;isel verileri kaydetmektedir.</p>

<p>b. Spiritya, ki&#351;isel veri sahibi olan ALICI&rsquo;y&#305; ayd&#305;nlatmakla y&uuml;k&uuml;ml&uuml; olup, bu kapsamda ALICI, i&#351;bu s&ouml;zle&#351;meyi, spiritya.com internet sayfas&#305;nda yer alan Gizlilik ve ilgili Politikalar&#305;n&#305; okudu&#287;unu ve Spiritya&rsquo;n&#305;n 6698 say&#305;l&#305; Ki&#351;isel Verilerin Korunmas&#305; Kanunu (bundan sonra&ldquo;KVKK&rdquo; olarak an&#305;lacakt&#305;r.)&rsquo;ndan do&#287;an ayd&#305;nlatma y&uuml;k&uuml;ml&uuml;l&uuml;&#287;&uuml;n&uuml; yerine getirdi&#287;ini kabul ve beyan eder. ALICI, i&#351;bu s&ouml;zle&#351;meyi kabul etmesiyle beraber ki&#351;isel verilerinin i&#351;lenmesine, aktar&#305;lmas&#305;na ve saklanmas&#305;na icazet etmi&#351; say&#305;l&#305;r.</p>

<p>c. ALICI, &uuml;yelik s&uuml;resince kendisi taraf&#305;ndan aktar&#305;lan ki&#351;isel verilerinin do&#287;ru ve gerekti&#287;inde g&uuml;ncel olmas&#305;n&#305; sa&#287;lama y&uuml;k&uuml;ml&uuml;l&uuml;&#287;&uuml;n&uuml; kabul ve taahh&uuml;t eder.</p>

<p>d. Spiritya, ALICI&rsquo;n&#305;n aktard&#305;&#287;&#305; ki&#351;isel verileri (kendisinin ve kanuni temsilcisi oldu&#287;u k&uuml;&ccedil;&uuml;klerin), i&#351;bu S&ouml;zle&#351;me kapsam&#305; ve amac&#305; ile s&#305;n&#305;rl&#305; olarak i&#351;leyece&#287;ini, aktaraca&#287;&#305;n&#305; ve saklayaca&#287;&#305;n&#305; kabul ve taahh&uuml;t eder. Spiritya, i&#351;bu S&ouml;zle&#351;me kapsam&#305;nda kendisine aktar&#305;lan ki&#351;isel verileri &uuml;r&uuml;n ve hizmetlerin do&#287;ru bir &#351;ekilde sunulmas&#305; amac&#305; ile ve t&uuml;ketici sorular&#305;na yan&#305;t vermek &uuml;zere, elektronik posta, posta veya telefon yoluyla kullanabilir. Spiritya, ALICI&rsquo;n&#305;n kendisine aktard&#305;&#287;&#305; ki&#351;isel verileri pazarlama faaliyetleri ve benzeri ama&ccedil;larla yasal s&#305;n&#305;rlamalar dahilinde haberle&#351;me amac&#305; ile, e-posta, posta veya telefon yoluyla kullanabilir.</p>

<p>Spiritya, ALICI&rsquo;lara daha iyi hizmet verebilmek amac&#305;yla ve yasal y&uuml;k&uuml;ml&uuml;l&uuml;&#287;&uuml; &ccedil;er&ccedil;evesinde, i&#351;bu S&ouml;zle&#351;menin eki olan Ki&#351;isel Verilerin Korunmas&#305; Hakk&#305;nda A&ccedil;&#305;klama metninde belirlenen ama&ccedil;lar ve kapsam d&#305;&#351;&#305;nda kullan&#305;lmamak kayd&#305; ile gezinme bilgilerinizi toplayacak, i&#351;leyecek, &uuml;&ccedil;&uuml;nc&uuml; ki&#351;ilerle payla&#351;acak ve g&uuml;venli olarak saklayacakt&#305;r.</p>

<p>Uygulama &ccedil;erezleri; g&uuml;nl&uuml;k dosyalar&#305;, bo&#351; gif dosyalar&#305; ve/veya &uuml;&ccedil;&uuml;nc&uuml; taraf kaynaklar&#305; yoluyla toplad&#305;&#287;&#305; bilgileri tercihlerinizle ilgili bir &ouml;zet olu&#351;turmak amac&#305;yla depolar. Uygulamada ALICI&rsquo;ya yahut alt kullan&#305;c&#305;lara &ouml;zel tan&#305;t&#305;m yapmak, promosyonlar ve pazarlama teklifleri sunmak, web sitesinin veya mobil uygulaman&#305;n i&ccedil;eri&#287;ini iyile&#351;tirmek ve/veya tercihlerini belirlemek amac&#305;yla; uygulamada gezinme bilgilerini ve/veya kullan&#305;m ge&ccedil;mi&#351;ini izleyebilmektedir.</p>

<p>&ccedil;evrimi&ccedil;i ve &ccedil;evrimd&#305;&#351;&#305; olarak toplanan bilgiler farkl&#305; y&ouml;ntemlerle veya farkl&#305; zamanlarda Uygulama &uuml;zerinde toplanan bilgileri e&#351;le&#351;tirebilir ve bu bilgileri &uuml;&ccedil;&uuml;nc&uuml; taraflar gibi ba&#351;ka kaynaklardan al&#305;nan bilgilerle birlikte kullanabilir</p>

<p>e. Spiritya, ALICI bilgilerini 3. ki&#351;ilere aktarabilir. ALICI verilerinin aktar&#305;m&#305; hususunda Ki&#351;isel Verilerin Korunmas&#305; ve &#304;&#351;lenmesi Politikas&#305;&rsquo;na yer alan usul ve esaslar uygulan&#305;r. 3. ki&#351;iler ile payla&#351;&#305;lan ki&#351;isel veriler &uuml;r&uuml;n ve hizmetlerin sunumu ve hizmet kalitesinin art&#305;r&#305;lmas&#305; amac&#305;na y&ouml;neliktir. ALICI&rsquo;n&#305;n ki&#351;isel verileri i&#351;bu S&ouml;zle&#351;me&rsquo;nin amac&#305; d&#305;&#351;&#305;nda i&#351;lenemez. Spiritya, ALICI&rsquo;n&#305;n ki&#351;isel verilerini i&#351;bu s&ouml;zle&#351;mede mezkur ama&ccedil;lar d&#305;&#351;&#305;nda kullanmalar&#305;na olanak verecek &#351;ekilde satmayacak ve a&ccedil;&#305;klamayacakt&#305;r. KVKK&rsquo;da &ouml;ng&ouml;r&uuml;len istisnai haklar sakl&#305;d&#305;r.</p>

<p>f. Spiritya, KVKK&rsquo;n&#305;n &ouml;ng&ouml;rd&uuml;&#287;&uuml; i&ccedil; ve d&#305;&#351; denetimleri yapt&#305;raca&#287;&#305;n&#305; taahh&uuml;t eder.</p>

<p>g. ALICI&rsquo;n&#305;n, bir &uuml;crete tabi olmadan ki&#351;isel verilerine eri&#351;im hakk&#305; bulunmaktad&#305;r. ALICI, spiritya.com adresinden (veya internet sitesinde bulunan form arac&#305;l&#305;&#287;&#305; ile) irtibata ge&ccedil;erek; KVKK&rsquo;dan do&#287;an haklar&#305;n&#305; talep edebilir. Spiritya, ALICI&rsquo;ya makul s&uuml;re i&ccedil;erisinde cevap verecektir.</p>

<p>h. ALICI&rsquo;n&#305;n &ccedil;erez uygulamalar&#305;n&#305; kabul etmesi halinde &ccedil;erezler, spiritya.com internet adresinde yer alan &Ccedil;erez Politikas&#305;&rsquo;na uygun &#351;ekilde ALICI&rsquo;n&#305;n cihaz&#305;na yerle&#351;tirilir.</p>

<p>i. Spiritya, ALICI taraf&#305;ndan yap&#305;lan ki&#351;isel verilerinin i&#351;lenmesi, aktar&#305;lmas&#305; ve/veya muhafaza edilmesi ile ilgili talepleri niteli&#287;ine g&ouml;re en k&#305;sa s&uuml;rede ve her hal&uuml;karda en ge&ccedil; 30 (otuz) g&uuml;n i&ccedil;inde &uuml;cretsiz olarak sonu&ccedil;land&#305;r&#305;r. Bu s&uuml;renin ba&#351;layabilmesi i&ccedil;in ALICI talebini yaz&#305;l&#305; veya Ki&#351;isel Verileri Koruma Kurulu&rsquo;nun belirledi&#287;i di&#287;er y&ouml;ntemlerle Spiritya&rsquo;a g&ouml;ndermelidir. Talebin Spiritya taraf&#305;ndan reddedilmesi, verilen cevab&#305;n yetersiz bulunmas&#305; veya s&uuml;resinde cevap verilmemesi hallerinde; ALICI cevab&#305; &ouml;&#287;rendi&#287;i tarihten itibaren 30 (otuz) g&uuml;n ve her hal&uuml;karda ba&#351;vuru tarihinden itibaren 60 (altm&#305;&#351;) g&uuml;n i&ccedil;inde Ki&#351;isel Verileri Koruma Kurulu&rsquo;na &#351;ikayette bulunabilir.</p>

<p></p>

<p>8. H&#304;ZMET BEDEL&#304; ALICI, se&ccedil;ti&#287;i Dijital &#304;&ccedil;erik hizmet kategorisine g&ouml;re spiritya.com web sitesinde Spiritya taraf&#305;ndan a&ccedil;&#305;klanan, taahh&uuml;tl&uuml; veya pe&#351;in olarak sunulan &uuml;cretli i&ccedil;erik hizmetlerine ili&#351;kin hizmet bedellerini, bildirilen &#351;ekillerde &ouml;demeyi, bu &ouml;demeyi yapmad&#305;k&ccedil;a Spiritya&rsquo;n&#305;n sunmu&#351; oldu&#287;u hizmetlerden yararlanamayaca&#287;&#305;n&#305; kabul ve taahh&uuml;t eder.</p>

<p>ALICI, i&#351;bu S&ouml;zle&#351;me kapsam&#305;nda sat&#305;n alaca&#287;&#305; hizmetin spiritya.com web sitesinde yay&#305;nlanm&#305;&#351; olan hizmet bedelinin &ouml;demesini Kredi Kart&#305; bilgileri ile online olarak veya banka havalesi/EFT/FAST/SW&#304;FT yollar&#305;ndan biriyle yapacakt&#305;r. Hizmet bedellerinde veya vergi oranlar&#305;nda meydana gelen de&#287;i&#351;iklikler Spiritya taraf&#305;ndan hizmet bedellerine yans&#305;t&#305;lacakt&#305;r. Bunlarla s&#305;n&#305;rl&#305; kalmamak &uuml;zere Spiritya her zaman &uuml;r&uuml;n ve/veya hizmet bedellerinde de&#287;i&#351;iklik yapma hakk&#305;na sahiptir. ALICI, hizmet bedellerinde meydana gelebilecek bu de&#287;i&#351;iklikleri kabul etmedi&#287;i takdirde i&#351;bu S&ouml;zle&#351;me&rsquo;yi 5 g&uuml;n i&ccedil;erisinde feshetmek hakk&#305;n&#305; haizdir. Bu s&uuml;re i&ccedil;erisinde i&#351;bu S&ouml;zle&#351;me&rsquo;yi feshetmeyen ALICI, hizmet bedeline ili&#351;kin de&#287;i&#351;ikli&#287;i kabul etmi&#351; kabul edilecektir.</p>

<p></p>

<p>9. DAMGA VERG&#304;S&#304; &#304;&#351;bu S&ouml;zle&#351;me&rsquo;nin ALICI taraf&#305;ndan kabul edilmesi halinde, tahakkuk edecek damga vergisi tutar&#305;n&#305;n yar&#305;s&#305; ALICI&rsquo;n&#305;n hizmet bedeli faturas&#305;na yans&#305;t&#305;larak ALICI&rsquo;dan tahsil edilecektir.</p>

<p></p>

<p>10. CAYMA HAKKI VE ALICININ H&#304;ZMET&#304; SONLANDIRMASI Spiritya&rsquo;n&#305;n i&#351;bu S&ouml;zle&#351;me konusu &uuml;r&uuml;n ve/veya hizmetleri Mesafeli S&ouml;zle&#351;meler Y&ouml;netmeli&#287;i&rsquo;nin 15/&#287; h&uuml;km&uuml; gere&#287;ince elektronik ortamda an&#305;nda ifa edilen ve t&uuml;keticiye an&#305;nda teslim edilen gayri maddi mal niteli&#287;inde oldu&#287;undan Cayma Hakk&#305; kapsam&#305;nda bulunmamaktad&#305;r. ALICI, bu hususu en ba&#351;&#305;ndan bildi&#287;ini ve Cayma Hakk&#305; talep etmeyece&#287;ini kabul ve taahh&uuml;t eder.</p>

<p></p>

<p>11. TEMERR&Uuml;T HAL&#304; VE HUKUK&#304; SONU&Ccedil;LARI ALICI, faturalar&#305;n&#305; zaman&#305;nda, gere&#287;i gibi veya hi&ccedil; &ouml;dememesi halinde temerr&uuml;de d&uuml;&#351;m&uuml;&#351; say&#305;lacakt&#305;r. ALICI&rsquo;n&#305;n temerr&uuml;de d&uuml;&#351;mesi halinde, ALICI ayl&#305;k %3 oran&#305;nda akdi gecikme faizi ile birlikte s&ouml;z konusu faturalar&#305; &ouml;demekle sorumlu olacakt&#305;r. Gecikme bedeli, gecikmenin ilgili oldu&#287;u faturan&#305;n &ouml;denmesinden sonra g&uuml;nl&uuml;k olarak hesaplan&#305;p ALICI&rsquo;n&#305;n takip eden ilk faturas&#305;na yans&#305;t&#305;l&#305;r. S&ouml;z konusu faiz oran&#305;ndaki de&#287;i&#351;ikliklere faturada yer verilecek olup, gecikme durumunda de&#287;i&#351;en yeni oran uygulanacakt&#305;r.</p>

<p></p>

<p>12. S&Ouml;ZLE&#350;MEN&#304;N SONA ERMES&#304; VE FES&#304;H Spiritya, ALICI&rsquo;n&#305;n i&#351;bu S&ouml;zle&#351;me&rsquo;den do&#287;an y&uuml;k&uuml;ml&uuml;l&uuml;klerini &Ouml;n Bilgilendirme Formu ve i&#351;bu s&ouml;zle&#351;me&rsquo;de belirtilen &#351;ekilde yerine getirmemesi halinde s&uuml;re vermeksizin s&ouml;zle&#351;meyi feshedebilir. Ayr&#305;ca Spiritya, i&#351; modellerindeki de&#287;i&#351;ikliklere ba&#287;l&#305; olarak tamamen ve tek tarafl&#305; karar&#305; ile i&#351;bu S&ouml;zle&#351;me konusu &uuml;r&uuml;n ve/veya hizmeti &uuml;yelerine sunmaktan vazge&ccedil;ebilir ve hizmet sunumunu sona erdirebilir. Bu durumda ALICI&rsquo;n&#305;n hi&ccedil;bir nam alt&#305;nda Spiritya&rsquo;dan herhangi bir bedel talep etme hakk&#305; olmayacakt&#305;r.</p>

<p>ALICI, Dijital &#304;&ccedil;erik Hizmetlerini hi&ccedil;bir &#351;ekilde bireysel kullan&#305;m amac&#305; d&#305;&#351;&#305;nda kullanamaz ve/veya kulland&#305;ramaz, 3. ki&#351;i ve/veya kurumlara iletemez, kulland&#305;ramaz ve/veya devredemez. Spiritya taraf&#305;ndan yetkisiz bir kullan&#305;m&#305;n tespiti halinde i&#351;bu S&ouml;zle&#351;me kapsam&#305;nda sunulan hizmetler derhal durdurulabilir ve i&#351;bu S&ouml;zle&#351;me hi&ccedil;bir ihtara gerek kalmaks&#305;z&#305;n tek tarafl&#305; olarak feshedilebilir. Bu durumda Spiritya zararlar&#305;n&#305;n tazminini ve sair yasal haklar&#305;n&#305; talep etme hakk&#305; sakl&#305;d&#305;r. &#304;&#351;bu s&ouml;zle&#351;me konusu haklar ALICI taraf&#305;ndan hi&ccedil;bir surette ticari ama&ccedil;lara konu yap&#305;lamaz.</p>

<p>ALICI, i&#351;bu S&ouml;zle&#351;meyi feshetmek istedi&#287;i takdirde Spiritya&rsquo;a yaz&#305;l&#305; bildirimde bulunmak suretiyle &uuml;yeli&#287;ini sonland&#305;rabilir. B&ouml;yle bir durumda ALICI, ilgili aya ili&#351;kin olarak &ouml;demi&#351; oldu&#287;u hizmet bedelinin geri verilmesini talep etmeyece&#287;ini, kampanya kapsam&#305;nda taahh&uuml;t s&uuml;resinden evvel &uuml;yeli&#287;ini iptal etmesi halinde yararland&#305;&#287;&#305; indirim ve avantajlar&#305;n kendisine faturalanaca&#287;&#305;n&#305; kabul ve taahh&uuml;t eder.</p>

<p>ALICI, tek tarafl&#305; olarak &uuml;yeli&#287;ini sonland&#305;rd&#305;&#287;&#305;nda, i&#351;bu S&ouml;zle&#351;me kapsam&#305;nda verdi&#287;i ki&#351;isel verilerinin silinmesini, yok edilmesini veya anonim hale getirilmesini talep edebilir. ALICI&rsquo;n&#305;n ki&#351;isel verilerinin silinmesine, yok edilmesine veya anonimle&#351;tirilmesine ili&#351;kin talepler Spiritya&rsquo;n&#305;n Ki&#351;isel Verilerin Korunmas&#305; ve &#304;&#351;lenmesi Politikas&#305; taraf&#305;ndan &ouml;ng&ouml;r&uuml;len usul ve esaslara g&ouml;re de&#287;erlendirilir.</p>

<p>13. UYU&#350;MAZLIKLARIN &Ccedil;&Ouml;Z&Uuml;M&Uuml; &#304;&#351;bu S&ouml;zle&#351;meden kaynaklanabilecek ihtilaflarda &#304;stanbul (&Ccedil;a&#287;layan) Mahkemeleri ve &#304;cra Daireleri yetkilidir. Ayr&#305;ca ALICI, &#351;ikayet ve itirazlar&#305; konusundaki ba&#351;vurular&#305;n&#305;, Bakanl&#305;k&ccedil;a her y&#305;l Aral&#305;k ay&#305;nda belirlenen parasal s&#305;n&#305;rlar dahilinde mal veya hizmeti sat&#305;n ald&#305;&#287;&#305; veya ikametgah&#305;n&#305;n bulundu&#287;u yerdeki t&uuml;ketici sorunlar&#305; hakem heyetine veya t&uuml;ketici mahkemesine yapabilecektir. Ki&#351;isel verilere ili&#351;kin taleplerde 6698 say&#305;l&#305; Kanun&rsquo;un &ouml;ng&ouml;rd&uuml;&#287;&uuml; &#351;ikayet ve itiraz usulleri sakl&#305;d&#305;r.</p>

<p>14. Y&Uuml;R&Uuml;RL&Uuml;K &#304;&#351;bu S&ouml;zle&#351;me, ALICI taraf&#305;ndan okunarak, kabul edildi&#287;i anda y&uuml;r&uuml;rl&uuml;&#287;e girecek ve Taraflardan herhangi biri taraf&#305;ndan feshedilinceye kadar y&uuml;r&uuml;rl&uuml;kte kalacakt&#305;r</p>

<p></p> 
""";

  String gizlilik = """
<p>Gizlilik Politikas&#305;</p>

<p>G&#304;ZL&#304;L&#304;K POL&#304;T&#304;KASI VE K&#304;&#350;&#304;SEL VER&#304;LER&#304;N KORUNMASI HAKKINDA A&Ccedil;IKLAMA</p>

<p>Bu Gizlilik Politikas&#305; ve Ki&#351;isel Verilerin Korunmas&#305; Hakk&#305;nda A&ccedil;&#305;klama; Spiritya E&#287;itim ve Dan&#305;&#351;manl&#305;k A.&#350;. (Spiritya) taraf&#305;ndan yay&#305;nlanan websitesi ve Websitesi ve Mobil Uygulamay&#305; (&ldquo;Websitesi ve Mobil Uygulama&rdquo; olarak an&#305;lacakt&#305;r) kullan&#305;rken ve an&#305;lan hizmetlerden yararlan&#305;rken payla&#351;m&#305;&#351; oldu&#287;unuz ki&#351;isel bilgilerin kay&#305;t alt&#305;na al&#305;nma, saklanma, kullan&#305;m ve a&ccedil;&#305;klanma &#351;artlar&#305;n&#305; d&uuml;zenlemektedir.</p>

<p>Spiritya'ya aktar&#305;lan ki&#351;isel verilerin korunmas&#305; konusundaki temel bilgilere a&#351;a&#287;&#305;da yer verilmi&#351;tir. Spiritya, 6698 say&#305;l&#305; Ki&#351;isel Verilerin Korunmas&#305; Kanunu (&ldquo;KVKK&rdquo;) madde 10&rsquo;dan do&#287;an ayd&#305;nlatma y&uuml;k&uuml;ml&uuml;l&uuml;&#287;&uuml;n&uuml; yerine getirmek amac&#305;yla a&#351;a&#287;&#305;daki a&ccedil;&#305;klamalar&#305; m&uuml;&#351;terilerimizin Websitesi ve Mobil Uygulamalar&#305;m&#305;z&#305; kullanan 3. ki&#351;ilerin dikkatine sunar.</p>

<p>Websitesi ve Mobil Uygulamalar&#305; kullanarak bu Gizlilik Politikas&#305;n&#305; anlad&#305;&#287;&#305;n&#305;z ve kabul etti&#287;iniz kabul edilir. Spiritya, Gizlilik Politikas&#305;&rsquo;n&#305; &ouml;ncesinde bir bildirimde veya ihtarda bulunmaks&#305;z&#305;n diledi&#287;i zaman de&#287;i&#351;tirebilir. Gizlilik Politikas&#305;&rsquo;na ili&#351;kin ger&ccedil;ekle&#351;ecek de&#287;i&#351;iklikler spiritya.com adresinden ve/veya mobil cihaz, ak&#305;ll&#305; televizyon ve benzeri cihazlar &uuml;zerinde yer alan uygulama &uuml;zerinden yay&#305;nlanacak olup, yay&#305;mland&#305;&#287;&#305; tarihten itibaren ge&ccedil;erli olacakt&#305;r. Spiritya hizmetlerinin kullan&#305;m&#305;n&#305;n devam etmesi takdirde, de&#287;i&#351;ikliklerin yay&#305;m tarihinden itibaren taraf&#305;n&#305;zca onayland&#305;&#287;&#305; kabul edilir.</p>

<p>1) Spiritya&rsquo;n&#305;n Ki&#351;isel Verileri Toplamas&#305;n&#305;n Yasal Dayana&#287;&#305; Nedir?</p>

<p>Kullan&#305;c&#305;lar&#305;m&#305;z&#305;n ki&#351;isel verilerinin kullan&#305;lmas&#305; konusunda &ccedil;e&#351;itli kanunlarda d&uuml;zenlemeler bulunmaktad&#305;r. En ba&#351;ta KVKK ile ki&#351;isel verilerin korunmas&#305; esaslar&#305; belirlenmi&#351;tir. Ayr&#305;ca 6563 Say&#305;l&#305; Elektronik Ticaretin D&uuml;zenlenmesi Hakk&#305;nda Kanun da ki&#351;isel verilerin korunmas&#305;na ili&#351;kin h&uuml;k&uuml;m i&ccedil;ermektedir. 5237 Say&#305;l&#305; T&uuml;rk Ceza Kanunu h&uuml;k&uuml;mleri yoluyla da ki&#351;isel verilerin korunmas&#305; i&ccedil;in baz&#305; hallerde cezai yapt&#305;r&#305;mlar &ouml;ng&ouml;r&uuml;lm&uuml;&#351;t&uuml;r. Di&#287;er yandan, 6502 say&#305;l&#305; T&uuml;keticinin Korunmas&#305; Hakk&#305;nda Kanun ve Mesafeli S&ouml;zle&#351;meler Y&ouml;netmeli&#287;i&rsquo;nden do&#287;an y&uuml;k&uuml;ml&uuml;l&uuml;klerimizin ifas&#305; amac&#305;yla verilerin toplanmas&#305; ve kullan&#305;lmas&#305; gerekmektedir.</p>

<p>2) Spiritya Ki&#351;isel Verilerin Toplanmas&#305;nda Hangi Y&ouml;ntemleri Kullan&#305;yor?</p>

<p>Websitesi ve Mobil Uygulamalar&#305; kullanan kullan&#305;c&#305;lar&#305;m&#305;z&#305;n verdikleri veriler, kullan&#305;c&#305;lar&#305;m&#305;z&#305;n r&#305;zalar&#305; ve mevzuat h&uuml;k&uuml;mleri uyar&#305;nca Spiritya taraf&#305;ndan i&#351;lenmektedir.</p>

<p>Websitesi ve Mobil Uygulamada &ccedil;erez (cookie) kullan&#305;lmaktad&#305;r. &Ccedil;erez; kullan&#305;lmakta olan cihaz&#305;n internet taray&#305;c&#305;s&#305;na ya da sabit diskine depolanarak s&ouml;z konusu cihaz&#305;n tespit edilmesine olanak tan&#305;yan, &ccedil;o&#287;unlukla harf ve say&#305;lardan olu&#351;an bir dosyad&#305;r.</p>

<p>Websitesi ve Mobil Uygulama kullan&#305;c&#305;lar&#305;na daha iyi hizmet verebilmek amac&#305;yla ve yasal y&uuml;k&uuml;ml&uuml;l&uuml;&#287;&uuml; &ccedil;er&ccedil;evesinde, i&#351;bu Ki&#351;isel Verilerin Korunmas&#305; Hakk&#305;nda A&ccedil;&#305;klama metninde belirlenen ama&ccedil;lar ve kapsam d&#305;&#351;&#305;nda kullan&#305;lmamak kayd&#305; ile gezinme bilgilerinizi toplayacak, i&#351;leyecek, &uuml;&ccedil;&uuml;nc&uuml; ki&#351;ilerle payla&#351;acak ve g&uuml;venli olarak saklayacakt&#305;r.</p>

<p>&Ccedil;erezler; g&uuml;nl&uuml;k dosyalar&#305;, bo&#351; gif dosyalar&#305; ve/veya &uuml;&ccedil;&uuml;nc&uuml; taraf kaynaklar&#305; yoluyla toplad&#305;&#287;&#305; bilgileri tercihlerinizle ilgili bir &ouml;zet olu&#351;turmak amac&#305;yla depolar. Websitesi ve Mobil Uygulamada size &ouml;zel tan&#305;t&#305;m yapmak, promosyonlar ve pazarlama teklifleri sunmak Websitesi ve Mobil Uygulaman&#305;n i&ccedil;eri&#287;ini size g&ouml;re iyile&#351;tirmek ve/veya tercihlerinizi belirlemek amac&#305;yla; uygulamada gezinme bilgilerinizi ve/veya kullan&#305;m ge&ccedil;mi&#351;inizi izleyebilmektedir.</p>

<p>Websitesi ve Mobil Uygulama &uuml;zerinden &ccedil;evrimi&ccedil;i ve &ccedil;evrimd&#305;&#351;&#305; olarak toplanan bilgiler gibi farkl&#305; y&ouml;ntemlerle veya farkl&#305; zamanlarda sizden toplanan bilgileri e&#351;le&#351;tirebilir ve bu bilgileri &uuml;&ccedil;&uuml;nc&uuml; taraflar gibi ba&#351;ka kaynaklardan al&#305;nan bilgilerle birlikte kullanabilir.</p>

<p>3) &Ccedil;erezler Nas&#305;l Kullan&#305;lmaktad&#305;r? &Ccedil;erezler; yapt&#305;&#287;&#305;n&#305;z tercihleri hat&#305;rlamak ve Websitesi ve Mobil Uygulama kullan&#305;m&#305;n&#305;z&#305; ki&#351;iselle&#351;tirmek i&ccedil;in kullan&#305;r. Bu kullan&#305;m parolan&#305;z&#305; kaydeden ve Websitesi ve Mobil Uygulama oturumunuzun s&uuml;rekli a&ccedil;&#305;k kalmas&#305;n&#305; sa&#287;layan, b&ouml;ylece her ziyaretinizde birden fazla kez parola girme zahmetinden kurtaran &ccedil;erezleri ve Websitesi ve Mobil Uygulamaya daha sonraki ziyaretlerinizde sizi hat&#305;rlayan ve tan&#305;yan &ccedil;erezleri i&ccedil;erir. Uygulamaya nereden ba&#287;land&#305;&#287;&#305;n&#305;z, Websitesi ve Mobil Uygulama &uuml;zerinde hangi i&ccedil;eri&#287;i g&ouml;r&uuml;nt&uuml;ledi&#287;iniz ve ziyaretinizin s&uuml;resi gibi Websitesi ve Mobil Uygulamay&#305; nas&#305;l kulland&#305;&#287;&#305;n&#305;z&#305;n izlenmesi dahil olmak &uuml;zere; Websitesi ve Mobil Uygulamay&#305; nas&#305;l kulland&#305;&#287;&#305;n&#305;z&#305; belirlemek i&ccedil;in kullan&#305;r. &Ccedil;erezler ilgi alanlar&#305;n&#305;za ve size daha uygun i&ccedil;erik ve reklamlar&#305; sunmak i&ccedil;in reklam/tan&#305;t&#305;m amac&#305;yla kullan&#305;l&#305;r. Bu &#351;ekilde, Websitesi ve Mobil Uygulamas&#305;n&#305; kulland&#305;&#287;&#305;n&#305;zda size daha uygun i&ccedil;erikleri, ki&#351;iye &ouml;zel kampanya ve &uuml;r&uuml;nleri sunar ve daha &ouml;nceden istemedi&#287;inizi belirtti&#287;iniz i&ccedil;erik veya f&#305;rsatlar&#305; bir daha sunmaz.</p>

<p>4) Websitesi ve Mobil Uygulama &Uuml;&ccedil;&uuml;nc&uuml; Taraf &Ccedil;erezlerini Reklam ve Yeniden Hedefleme &#304;&ccedil;in Nas&#305;l Kullanmaktad&#305;r? Websitesi ve Mobil Uygulama &ccedil;erezleri ayr&#305;ca; arama motorlar&#305;n&#305;, web sitesi, Websitesi ve Mobil Uygulamas&#305;n&#305; ve/veya Websitesi ve Mobil Uygulaman&#305;n reklam verdi&#287;i internet sitelerini ziyaret etti&#287;inizde ilginizi &ccedil;ekebilece&#287;ini d&uuml;&#351;&uuml;nd&uuml;&#287;&uuml; reklamlar&#305; size sunabilmek i&ccedil;in &ldquo;reklam teknolojisini&rdquo; devreye sokmak amac&#305;yla kullanabilir. Reklam teknolojisi, size &ouml;zel reklamlar sunabilmek i&ccedil;in Websitesi ve Mobil Uygulamaya reklam verdi&#287;i web sitelerine/Websitesi ve Mobil Uygulamalar&#305;na yapt&#305;&#287;&#305;n&#305;z &ouml;nceki ziyaretlerle ilgili bilgileri kullan&#305;r. Bu reklamlar&#305; sunarken, Websitesi ve Mobil Uygulaman&#305;n sizi tan&#305;yabilmesi amac&#305;yla taray&#305;c&#305;n&#305;za benzersiz bir &uuml;&ccedil;&uuml;nc&uuml; taraf &ccedil;erezi yerle&#351;tirilebilir.</p>

<p>5) Spiritya Ki&#351;isel Verileri Hangi Ama&ccedil;larla Kullan&#305;yor? Spiritya, mevzuat&#305;n izin verdi&#287;i durumlarda ve &ouml;l&ccedil;&uuml;de ki&#351;isel bilgilerinizi kaydedebilecek, saklayabilecek, g&uuml;ncelleyebilecek, &uuml;&ccedil;&uuml;nc&uuml; ki&#351;ilere a&ccedil;&#305;klayabilecek, devredebilecek, s&#305;n&#305;fland&#305;rabilecek ve i&#351;leyebilecektir. Ki&#351;isel verileriniz &#351;u ama&ccedil;larla kullan&#305;lmaktad&#305;r: Hizmetleri, i&ccedil;erikleri ve tan&#305;t&#305;mlar&#305; ki&#351;iselle&#351;tirmek, &ouml;l&ccedil;mek ve geli&#351;tirmek. Talep etti&#287;iniz hizmetleri ve kullan&#305;c&#305; deste&#287;ini sa&#287;lamak. Uyu&#351;mazl&#305;klar&#305; ve Sitedeki aksakl&#305;klar&#305; &ccedil;&ouml;z&uuml;mlemek, Yasaklanma ihtimali olan veya yasaklanm&#305;&#351; i&#351;lemleri veya kanuna ayk&#305;r&#305; faaliyetleri &ouml;nlemek, bulmak ve ara&#351;t&#305;rmak, kamu g&uuml;venli&#287;ine ili&#351;kin hususlarda talep halinde ve mevzuat gere&#287;i kamu g&ouml;revlilerine bilgi verebilmek, Spiritya &Uuml;r&uuml;nlerine ili&#351;kin hizmetleri, hedeflenen pazarlama, hizmet g&uuml;ncelle&#351;tirilmeleri ve promosyon teklifleri ile ilgili tercih etti&#287;iniz ileti&#351;im kanallar&#305; &ccedil;er&ccedil;evesinde sizlere bilgiler vermek. Elektronik posta ile pazarlama ama&ccedil;l&#305; tan&#305;t&#305;mlar g&ouml;ndermek. (Tan&#305;t&#305;mlar&#305;n&#305;n g&ouml;nderilmemesi ile ilgili talimatlar g&ouml;nderilen elektronik posta da yer almaktad&#305;r.) Bilgileri do&#287;rulu&#287;unu teyit etmek amac&#305;yla kar&#351;&#305;la&#351;t&#305;rmak ve bu bilgileri &uuml;&ccedil;&uuml;nc&uuml; ki&#351;iler ile do&#287;rulamak. ileti&#351;im i&ccedil;in adres ve di&#287;er gerekli bilgileri kaydetmek, elektronik (internet/mobil vs.) veya ka&#287;&#305;t ortam&#305;nda i&#351;leme dayanak olacak t&uuml;m kay&#305;t ve belgeleri d&uuml;zenlemek, hizmetlerimiz ile ilgili m&uuml;&#351;teri &#351;ikayet ve &ouml;nerilerini de&#287;erlendirebilmek, yasal y&uuml;k&uuml;ml&uuml;l&uuml;klerimizi yerine getirebilmek ve y&uuml;r&uuml;rl&uuml;kteki mevzuattan do&#287;an haklar&#305;m&#305;z&#305; kullanabilmek</p>

<p>6) Spiritya Ki&#351;isel Verilerinizi Nas&#305;l Koruyor? Spiritya ile payla&#351;&#305;lan ki&#351;isel veriler, Spiritya g&ouml;zetimi ve kontrol&uuml; alt&#305;ndad&#305;r. Spiritya, y&uuml;r&uuml;rl&uuml;kteki ilgili mevzuat h&uuml;k&uuml;mleri gere&#287;ince bilginin gizlili&#287;inin ve b&uuml;t&uuml;nl&uuml;&#287;&uuml;n&uuml;n korunmas&#305; amac&#305;yla gerekli organizasyonu kurmak ve teknik &ouml;nlemleri almak ve uyarlamak konusunda veri sorumlusu s&#305;fat&#305;yla sorumlulu&#287;u &uuml;stlenmi&#351;tir. Bu konudaki y&uuml;k&uuml;ml&uuml;l&uuml;&#287;&uuml;m&uuml;z&uuml;n bilincinde olarak veri gizlili&#287;ini konu alan uluslararas&#305; ve ulusal teknik standartlara uygun surette periyodik aral&#305;klarda s&#305;zma testleri yapt&#305;r&#305;lmakta ve bu kapsamda veri i&#351;leme politikalar&#305;m&#305;z&#305; her zaman g&uuml;ncelledi&#287;imizi bilginize sunar&#305;z.</p>

<p>7) Spiritya Ki&#351;isel Verilerinizi Payla&#351;&#305;yor Mu? Kullan&#305;c&#305;lar&#305;m&#305;za ait ki&#351;isel verilerin &uuml;&ccedil;&uuml;nc&uuml; ki&#351;iler ile payla&#351;&#305;m&#305;, kullan&#305;c&#305;lar&#305;n izni &ccedil;er&ccedil;evesinde ger&ccedil;ekle&#351;mekte ve kural olarak kullan&#305;c&#305;lar&#305;m&#305;z&#305;n onay&#305; olmaks&#305;z&#305;n ki&#351;isel verileri &uuml;&ccedil;&uuml;nc&uuml; ki&#351;ilere aktar&#305;lmamaktad&#305;r. &Ouml;te yandan, yasal y&uuml;k&uuml;ml&uuml;l&uuml;klerimiz nedeniyle ve bunlarla s&#305;n&#305;rl&#305; olmak &uuml;zere mahkemeler ve di&#287;er kamu kurumlar&#305; ile ki&#351;isel veriler payla&#351;&#305;lmaktad&#305;r. Ayr&#305;ca, taahh&uuml;t etti&#287;imiz hizmetleri sa&#287;layabilmek ve verilen hizmetlerin kalite kontrol&uuml;n&uuml; yapabilmek i&ccedil;in anla&#351;mal&#305; &uuml;&ccedil;&uuml;nc&uuml; ki&#351;ilere ki&#351;isel veri aktar&#305;m&#305; yap&#305;lmaktad&#305;r. &Uuml;&ccedil;&uuml;nc&uuml; ki&#351;ilere veri aktar&#305;m&#305; s&#305;ras&#305;nda hak ihlallerini &ouml;nlemek i&ccedil;in gerekli teknik ve hukuki &ouml;nlemler al&#305;nmaktad&#305;r. Bununla birlikte, ki&#351;isel verileri alan &uuml;&ccedil;&uuml;nc&uuml; ki&#351;inin veri koruma politikalar&#305;ndan dolay&#305; ve &uuml;&ccedil;&uuml;nc&uuml; ki&#351;inin sorumlulu&#287;undaki risk alan&#305;nda meydana gelen ihlallerden Spiritya sorumlu de&#287;ildir. Ki&#351;isel verileriniz Spiritya&rsquo;n&#305;n hissedarlar&#305;yla, do&#287;rudan/dolayl&#305; yurti&ccedil;i/yurtd&#305;&#351;&#305; i&#351;tiraklerimize, faaliyetlerimizi y&uuml;r&uuml;tebilmek i&ccedil;in i&#351;birli&#287;i yapt&#305;&#287;&#305;m&#305;z program orta&#287;&#305; kurum, kurulu&#351;larla, verilerin bulut ortam&#305;nda saklanmas&#305; hizmeti ald&#305;&#287;&#305;m&#305;z yurti&ccedil;i/yurtd&#305;&#351;&#305; ki&#351;i ve kurumlarla, m&uuml;&#351;terilerimize ticari elektronik iletilerin g&ouml;nderilmesi konusunda anla&#351;mal&#305; oldu&#287;umuz yurti&ccedil;i/yurtd&#305;&#351;&#305;ndaki kurulu&#351;larla, Bankalararas&#305; Kart Merkeziyle, anla&#351;mal&#305; oldu&#287;umuz bankalarla ve sizlere daha iyi hizmet sunabilmek ve m&uuml;&#351;teri memnuniyetini sa&#287;layabilmek i&ccedil;in &ccedil;e&#351;itli pazarlama faaliyetleri kapsam&#305;nda yurti&ccedil;i ve yurtd&#305;&#351;&#305;ndaki &ccedil;e&#351;itli ajans, reklam &#351;irketleri ve anket &#351;irketleriyle ve yurti&ccedil;i/yurtd&#305;&#351;&#305; di&#287;er &uuml;&ccedil;&uuml;nc&uuml; ki&#351;ilerle ve ilgili i&#351; ortaklar&#305;m&#305;zla payla&#351;&#305;labilmektedir.</p>

<p>8) G&uuml;venlik &Uuml;yelik i&#351;lemlerinin tamamlanmas&#305; sonucunda verilen &Uuml;ye ad&#305; ve olu&#351;turulan &#351;ifrenin &Uuml;ye taraf&#305;ndan gizli tutulmas&#305; ve 3. ki&#351;iler ile payla&#351;&#305;lmamas&#305; gerekmektedir. &Uuml;yelerin, sisteme giri&#351; ara&ccedil;lar&#305;n&#305;n g&uuml;venli&#287;i, saklanmas&#305;, &uuml;&ccedil;&uuml;nc&uuml; ki&#351;ilerin bilgisinden uzak tutulmas&#305;, kullan&#305;lmas&#305; gibi hususlardaki t&uuml;m ihmal ve kusurlar&#305;ndan dolay&#305; &Uuml;ye&rsquo;nin ve/veya &uuml;&ccedil;&uuml;nc&uuml; ki&#351;ilerin u&#287;rad&#305;&#287;&#305; veya u&#287;rayabilece&#287;i zararlara istinaden Spiritya&rsquo;n&#305;n do&#287;rudan veya dolayl&#305;, herhangi bir sorumlulu&#287;u yoktur.</p>

<p>9) Ki&#351;isel Bilgilere Eri&#351;ilmesi, Ki&#351;isel Bilgilerin G&ouml;r&uuml;nt&uuml;lenmesi ve De&#287;i&#351;tirilmesi Websitesi ve Mobil Uygulamaya giri&#351; yaparak, ki&#351;isel bilgilerinizi g&ouml;rebilir ve de&#287;i&#351;tirebilirsiniz. Spiritya kullan&#305;c&#305; kimlik bilgilerinin do&#287;rulu&#287;una ili&#351;kin bir i&ccedil;erik denetimi ger&ccedil;ekle&#351;tirmemektedir. Bu nedenle, ki&#351;isel bilgilerinizin de&#287;i&#351;mesi gerekti&#287;inde veya bu bilgilerin do&#287;ru olmamas&#305; halinde bu bilgileri derhal g&uuml;ncelle&#351;tirmelisiniz. Kapat&#305;lan hesaplara ait ki&#351;isel bilgiler, yasal gereklilikler, doland&#305;r&#305;c&#305;l&#305;&#287;&#305;n &ouml;nlenmesi, uyu&#351;mazl&#305;klar&#305;n &ccedil;&ouml;z&uuml;lmesi, ar&#305;zalar&#305;n giderilmesi, soru&#351;turmalara yard&#305;mc&#305; olunmas&#305;, Spiritya Kullan&#305;m Ko&#351;ullar&#305;&rsquo;n&#305;n uygulanmas&#305; ve yasalarca izin verilen di&#287;er t&uuml;m eylemler i&ccedil;in muhafaza edilmektedir.</p>

<p>10) &Uuml;&ccedil;&uuml;nc&uuml; Ki&#351;iler Aksi a&ccedil;&#305;k&ccedil;a belirtilmedik&ccedil;e, bu Gizlilik Politikas&#305;, yaln&#305;zca taraf&#305;m&#305;zca toplanan ki&#351;isel bilgilerinizin kullan&#305;lmas&#305; ve a&ccedil;&#305;klanmas&#305;na ili&#351;kindir. Web sitesi veya ba&#351;ka internet sitelerinde di&#287;er ki&#351;ilere ki&#351;isel bilgilerinizi a&ccedil;&#305;klaman&#305;z halinde, bu bilgilerin di&#287;er ki&#351;iler taraf&#305;ndan kullan&#305;lmas&#305; veya a&ccedil;&#305;klanmas&#305; farkl&#305; kurallara tabi olabilir. Spiritya taraf&#305;ndan &uuml;&ccedil;&uuml;nc&uuml; ki&#351;ilere ait gizlilik politikalar&#305;n&#305; denetlenmemektedir.</p>

<p>11) Verinin g&uuml;ncel ve do&#287;ru tutuldu&#287;undan nas&#305;l emin olabilirim? KVKK&rsquo;n&#305;n 4. maddesi uyar&#305;nca Spiritya&rsquo;n&#305;n ki&#351;isel verilerinizi do&#287;ru ve g&uuml;ncel olarak tutma y&uuml;k&uuml;ml&uuml;l&uuml;&#287;&uuml; bulundu&#287;undan kullan&#305;c&#305;lar&#305;m&#305;z&#305;n Spiritya ile do&#287;ru ve g&uuml;ncel verilerini payla&#351;mas&#305; gerekmektedir. Verilerinizin herhangi bir surette de&#287;i&#351;ikli&#287;e u&#287;ramas&#305; halinde verilerinizi g&uuml;ncellemenizi rica ederiz.</p>

<p>12) &#304;leti&#351;im Bu Gizlilik Politikas&#305; ile ilgili ba&#351;kaca soru, kayd&#305; veya &ouml;nerileriniz olmas&#305; halinde l&uuml;tfen bizimle destek@spiritya.com adresinden ileti&#351;ime ge&ccedil;iniz.</p>
""";

  var yardimurl = "https://www.spiritya.com/destek/";
  Future<bool?> showDeleteConfirmationDialog() {
    return Get.dialog<bool>(
      AlertDialog(
        title: Text('Hesabınızı silmek istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Hayır'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text('Evet'),
          ),
        ],
      ),
    );
  }

  void deleteAccount() async {
    bool? confirmDelete = await showDeleteConfirmationDialog();

    if (confirmDelete == true) {
      // Hesabı silme işlemleri burada gerçekleştirilir
      try {
        // Firestore'da kullanıcı dokümanını sil
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          final userDocRef =
              FirebaseFirestore.instance.collection('users').doc(userId);
          await userDocRef.delete();
        }

        // Firebase Authentication'dan kullanıcıyı sil
        await FirebaseAuth.instance.currentUser?.delete();

        // Hesap silme işlemi başarılı olduysa diğer işlemler gerçekleştirilir
        AppConfig.logind = false;
        AppConfig.login.value = false;
        AppConfig.premium = false;
        AppConfig.isim = "Misafir";
        FirebaseAuth.instance.signOut();
        Get.snackbar(   backgroundColor: Colors.white.withOpacity(0.9),
          colorText: Colors.black,'Tamamlandı', 'Hesap silme işlemi başarılı oldu.');

        Get.offAll(Wrapper());
      } catch (error) {
        // Hesap silme işlemi başarısız olduysa hata mesajı gösterilir
        Get.snackbar('Hata', 'Hesap silme işlemi başarısız oldu.');
      }
    } else {
      // Kullanıcı hesabı silmeyi onaylamadı
      // İsteğe bağlı olarak yapılacak işlemler buraya eklenir
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            height: size.height * 0.4,
            width: size.width,
            child: Image.asset(
              'assets/backg1.png',
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(0.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient:SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,  colors: [
                    AppConfig.main.withOpacity(0),
                    AppConfig.main.withOpacity(0),
                    Colors.transparent,
                  ],
                ),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    expandedHeight: size.height * 0.26,
                    flexibleSpace: FlexibleSpaceBar(background: Container()),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        height: AppConfig.logind == true
                            ? size.height * 0.70
                            : size.height * 0.68,
                        decoration: BoxDecoration(
                          gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,   colors: [
                              /*   Color.fromRGBO(43, 43, 64, 1),
                              Color.fromRGBO(95, 95, 125, 1), */

                              Color.fromRGBO(43, 43, 64, 1),
                              Color.fromRGBO(109, 116, 161, 1),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Visibility(
                              visible: !AppConfig.logind,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 40, 15, 25),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Kişiselleştirilmiş Deneyim için ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => OtherLoginPage(),
                                            transition: Transition.cupertino);
                                      },
                                      child: Text(
                                        "Üye Ol / Giriş Yap",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: AppConfig.logind,
                              child: CustomListTile(
                                icon: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                      image: AssetImage('assets/geri.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                text: "Satın alma işlemini geri yükle",
                                onTap: () {
                                  Get.to(Premiumayricalik(premium: ""),
                                      transition: Transition.cupertino);
                                },
                              ),
                            ),
                            Visibility(
                              visible: AppConfig.logind,
                              child: CustomListTile(
                                icon: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/hesap.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                text: "Hesap İşlemleri",
                                onTap: () async {
                                  String? result =
                                      await showBottomModal<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 30, 10, 5),
                                        decoration: BoxDecoration(
                                          gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,  colors: [
                                              Color.fromRGBO(43, 43, 64, 1),
                                              Color.fromRGBO(109, 116, 161, 1),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12.0),
                                            topRight: Radius.circular(12.0),
                                          ),
                                        ),
                                        height: size.height * 0.7,
                                        child: Center(
                                            child: Column(children: [
                                          CustomListTile(
                                            icon: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/hesap.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            text: "Hesap Bilgileri Değiştir",
                                            onTap: () async {
                                              Get.to(HesapDegistir(),
                                                  transition:
                                                      Transition.cupertino);
                                            },
                                          ),
                                          CustomListTile(
                                            icon: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/gizlilik.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            text: "Şifre Degistir",
                                            onTap: () {
                                              Get.to(PassChangePage(),
                                                  transition:
                                                      Transition.cupertino);
                                            },
                                          ),
                                          CustomListTile(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.white60,
                                            ),
                                            text: "Hesabı Sil",
                                            onTap: () async {
                                              deleteAccount();
                                            },
                                          ),
                                        ])),
                                      );
                                    },
                                  );
                                  print('Alt modal sonucu: $result');
                                },
                              ),
                            ),
                            CustomListTile(
                              icon: Container(
                                padding: EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/help.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              text: "Yardım Ve Destek",
                              onTap: () async {
                                if (await canLaunch(yardimurl)) {
                                  await launch(yardimurl);
                                } else {
                                  Get.snackbar(   backgroundColor: Colors.white.withOpacity(0.9),
          colorText: Colors.black,'Hata', '');
                                  throw 'Could not launch ';
                                }
                              },
                            ),
                            CustomListTile(
                              icon: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/gizlilik.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              text: "Gizlilik Politikası",
                              onTap: () async {
                                String? result = await showBottomModal<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding:
                                          EdgeInsets.fromLTRB(5, 30, 10, 5),
                                      decoration: BoxDecoration(
                                        gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,  colors: [
                                            Color.fromRGBO(43, 43, 64, 1),
                                            Color.fromRGBO(109, 116, 161, 1),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                        ),
                                      ),
                                      height: size.height * 0.7,
                                      child: Center(
                                          child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Html(
                                          style: {
                                            '*': Style(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                            ),
                                            'body': Style(
                                                fontFamily: 'Montserrat',
                                                color: Colors
                                                    .white), // Tüm metni beyaz renkte göstermek için
                                            'p': Style(
                                                fontFamily: 'Montserrat',
                                                color: Colors
                                                    .white), // Paragrafları beyaz renkte göstermek için
                                            // Diğer etiketler ve stiller buraya eklenebilir
                                          },
                                          data: gizlilik,
                                        ),
                                      )),
                                    );
                                  },
                                );
                                print('Alt modal sonucu: $result');
                              },
                            ),
                            CustomListTile(
                              icon: Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/sozles.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              text: "Kullanıcı Sözleşmesi",
                              onTap: () async {
                                String? result = await showBottomModal<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding:
                                          EdgeInsets.fromLTRB(5, 30, 10, 5),
                                      decoration: BoxDecoration(
                                        gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,  colors: [
                                            Color.fromRGBO(43, 43, 64, 1),
                                            Color.fromRGBO(109, 116, 161, 1),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                        ),
                                      ),
                                      height: size.height * 0.7,
                                      child: Center(
                                          child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Html(
                                          style: {
                                            '*': Style(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                            ),
                                            'body': Style(
                                                fontFamily: 'Montserrat',
                                                color: Colors
                                                    .white), // Tüm metni beyaz renkte göstermek için
                                            'p': Style(
                                                fontFamily: 'Montserrat',
                                                color: Colors
                                                    .white), // Paragrafları beyaz renkte göstermek için
                                            // Diğer etiketler ve stiller buraya eklenebilir
                                          },
                                          data: kullanici,
                                        ),
                                      )),
                                    );
                                  },
                                );
                                print('Alt modal sonucu: $result');
                              },
                            ),
                            Visibility(
                              visible: true,
                              child: Container(
                                margin: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,   colors: [
                                      Color.fromRGBO(148, 147, 233, 1),
                                      Color.fromRGBO(132, 173, 234, 1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(26.0),
                                ),
                                child: Container(
                                  width: size.width * 0.9,
                                  height: size.height * 0.06,
                                  child: MaterialButton(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    onPressed: () {
                                      Get.to(Premiumayricalik(premium: ""),
                                          transition: Transition.cupertino);
                                    },
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,   colors: [
                                            Color.fromRGBO(148, 147, 233, 1),
                                            Color.fromRGBO(132, 173, 234, 1),
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: AppConfig.premium
                                            ? Text(
                                                'Premium Üye Oldunuz',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontSize: size.width * 0.042,
                                                ),
                                              )
                                            : Text(
                                                'Premium Üye Ol',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontSize: size.width * 0.042,
                                                ),
                                              ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: AppConfig.logind,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/Light.png'),
                                  TextButton(
                                    child: Text(
                                      "Çıkış Yap",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Montserrat',
                                        color: Colors.grey,
                                        fontSize: size.width * 0.04,
                                      ),
                                    ),
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                      AppConfig.logind = false;
                                      AppConfig.login.value = false;
                                      AppConfig.premium = false;
                                      AppConfig.isim = "Misafir";
                                      Get.offAll(Wrapper());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
