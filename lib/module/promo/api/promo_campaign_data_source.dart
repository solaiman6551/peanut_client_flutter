import 'package:peanut_client_app/module/promo/api/promo_campaign_model.dart';
import 'package:xml/xml.dart';
import '../../../core/base/base_data_source.dart';
import '../../../core/base/base_result.dart';

abstract class PromoDataSource {
  Future<BaseResult<List<PromoCampaign>>> getPromos();
}

class PromoDataSourceImpl extends BaseDataSource implements PromoDataSource {
  PromoDataSourceImpl(super.dio);

  @override
  Future<BaseResult<List<PromoCampaign>>> getPromos() {
    const String url = "https://api-forexcopy.contentdatapro.com/Services/CabinetMicroService.svc";

    const String soapAction = '"http://tempuri.org/ICabinetMicroService/GetCCPromo"';

    const String xmlBody = '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/"><soapenv:Header/><soapenv:Body><tem:GetCCPromo><tem:lang>en</tem:lang></tem:GetCCPromo></soapenv:Body></soapenv:Envelope>''';

    return getSoapResult(
      postSoap(url, xmlBody, soapAction),
          (xmlString) => _parsePromoXml(xmlString),
    );
  }

  List<PromoCampaign> _parsePromoXml(String xmlString) {
    final document = XmlDocument.parse(xmlString);

    final items = document.descendants
        .whereType<XmlElement>()
        .where((e) => e.name.local == 'CCPromoInfo');

    return items.map((node) {
      String getVal(String tag) => node.findElements(tag).firstOrNull?.innerText ?? "";

      String imageUrl = getVal('Image');
      if (imageUrl.contains('forex-images.instaforex.com')) {
        imageUrl = imageUrl.replaceAll('forex-images.instaforex.com', 'forex-images.ifxdb.com');
      }

      return PromoCampaign(
        title: getVal('Title'),
        link: getVal('Link'),
        imageUrl: imageUrl,
      );
    }).toList();
  }

}