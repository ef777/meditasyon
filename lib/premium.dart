import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final InAppPurchase _iapConnection = InAppPurchase.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String selectedPlan = 'Basic';
  List<String> subscriptionPlans = ['Basic', 'Pro', 'Premium'];
  preimumsorgu() async {
    bool isPremiumActive = await _isPremiumActive();
    return isPremiumActive;
  }

  @override
  void initState() {
    preimumsorgu();
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _isPremiumActive() async {
    // Kullanıcının Premium aboneliklerini Firestore'dan al
    QuerySnapshot snapshot = await firestore
        .collection('subscriptions')
        .where('userId', isEqualTo: user!.uid)
        .where('plan', isEqualTo: 'Premium')
        .orderBy('timestamp', descending: true) // En son aboneliği almak için
        .limit(1) // Sadece en son aboneliği al
        .get();

    // Kullanıcının bir Premium aboneliği yoksa, false döndür
    if (snapshot.docs.isEmpty) {
      return false;
    }

    // En son Premium aboneliği al
    Map<String, dynamic> latestSubscription =
        snapshot.docs.first.data() as Map<String, dynamic>;

    // Aboneliğin başlangıç tarihini al
    DateTime subscriptionStart = latestSubscription['timestamp'].toDate();

    // Aboneliğin bitiş tarihini hesapla (genellikle başlangıç tarihinden 30 gün sonra)
    DateTime subscriptionEnd = subscriptionStart.add(Duration(days: 30));

    // Eğer mevcut tarih, aboneliğin bitiş tarihinden önceyse, abonelik hala aktif demektir
    return DateTime.now().isBefore(subscriptionEnd);
  }

  static List<ProductDetails> products = [];
  ProductDetails productDetails = products
      .firstWhere((element) => element.id == 'your_subscription_product_id');

  void _initialize() async {
    bool isAvailable = await _iapConnection.isAvailable();
    if (isAvailable) {
      await _getProducts();
    }
  }

  Future<void> _getProducts() async {
    Set<String> ids = {'your_subscription_product_id'};
    ProductDetailsResponse response =
        await _iapConnection.queryProductDetails(ids);
    products = response.productDetails;
    // Ürünlerin bilgilerini kullanarak UI'da gösterme
  }

  void _subscribeToPlan(String plan) async {
    PurchaseParam purchaseParam = PurchaseParam(
      productDetails: productDetails,
      applicationUserName: null, // Kullanıcı adı
      // Sandbox modu (Test sırasında true, canlıya geçtiğinizde false olarak değiştirin)
    );

    bool isAvailable = await _iapConnection.isAvailable();
    if (isAvailable) {
      try {
        await _iapConnection.buyNonConsumable(purchaseParam: purchaseParam);
        await _verifyAndSaveSubscription(plan);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Başarılı'),
            content: Text('Aboneliğiniz başarıyla kaydedildi.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          ),
        );
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Hata'),
            content: Text('Ödeme işlemi sırasında bir hata oluştu: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _verifyAndSaveSubscription(String plan) async {
    // Kullanıcının abonelik bilgilerini Firestore'a kaydetme
    firestore.collection('subscriptions').add({
      'userId': '${user!.uid}',
      'plan': plan,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> _fetchSubscriptionsByUser() async {
    QuerySnapshot snapshot = await firestore
        .collection('subscriptions')
        .where('userId', isEqualTo: user!.uid)
        .get();

    List<Map<String, dynamic>> subscriptions =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    return subscriptions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aylık Abonelik'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Planınızı Seçin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedPlan,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPlan = newValue!;
                });
              },
              items: subscriptionPlans
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _subscribeToPlan(selectedPlan);
              },
              child: Text('Abone Ol'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _fetchSubscriptionsByUser().then((subscriptions) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Aylık Abonelikler'),
                      content: Column(
                        children: subscriptions
                            .map((subscription) => ListTile(
                                  title: Text(subscription['plan']),
                                  subtitle: Text(subscription['timestamp']
                                      .toDate()
                                      .toString()),
                                ))
                            .toList(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Tamam'),
                        ),
                      ],
                    ),
                  );
                });
              },
              child: Text('Abonelikleri Kontrol Et'),
            ),
          ],
        ),
      ),
    );
  }
}
