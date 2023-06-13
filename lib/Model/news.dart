class News {
  String? status;
  String? copyright;
  String? section;
  String? lastUpdated;
  int? numResults;
  List<Results>? results;

  News({
    this.status,
    this.copyright,
    this.section,
    this.lastUpdated,
    this.numResults,
    this.results,
  });

  News.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String;
    copyright = json['copyright'] as String;
    section = json['section'] as String;
    lastUpdated = json['last_updated'] as String;
    numResults = json['num_results'] as int;
    results = (json['results'] as List?)?.map((dynamic e) => Results.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['copyright'] = copyright;
    json['section'] = section;
    json['last_updated'] = lastUpdated;
    json['num_results'] = numResults;
    json['results'] = results?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Results {
  String? section;
  String? subsection;
  String? title;
  String? abstract;
  String? url;
  String? uri;
  String? byline;
  String? itemType;
  String? updatedDate;
  String? createdDate;
  String? publishedDate;
  String? materialTypeFacet;
  String? kicker;
  List<String>? desFacet;
  List<String>? orgFacet;
  List<String>? perFacet;
  List<dynamic>? geoFacet;
  List<Multimedia>? multimedia;
  String? shortUrl;

  Results({
    this.section,
    this.subsection,
    this.title,
    this.abstract,
    this.url,
    this.uri,
    this.byline,
    this.itemType,
    this.updatedDate,
    this.createdDate,
    this.publishedDate,
    this.materialTypeFacet,
    this.kicker,
    this.desFacet,
    this.orgFacet,
    this.perFacet,
    this.geoFacet,
    this.multimedia,
    this.shortUrl,
  });

  Results.fromJson(Map<String, dynamic> json) {
    section = json['section'] as String?;
    subsection = json['subsection'] as String?;
    title = json['title'] as String?;
    abstract = json['abstract'] as String?;
    url = json['url'] as String?;
    uri = json['uri'] as String?;
    byline = json['byline'] as String?;
    itemType = json['item_type'] as String?;
    updatedDate = json['updated_date'] as String?;
    createdDate = json['created_date'] as String?;
    publishedDate = json['published_date'] as String?;
    materialTypeFacet = json['material_type_facet'] as String?;
    kicker = json['kicker'] as String?;
    desFacet = (json['des_facet'] as List?)?.map((dynamic e) => e as String).toList();
    orgFacet = (json['org_facet'] as List?)?.map((dynamic e) => e as String).toList();
    perFacet = (json['per_facet'] as List?)?.map((dynamic e) => e as String).toList();
    geoFacet = json['geo_facet'] as List?;
    multimedia = (json['multimedia'] as List?)?.map((dynamic e) => Multimedia.fromJson(e as Map<String,dynamic>)).toList();
    shortUrl = json['short_url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['section'] = section;
    json['subsection'] = subsection;
    json['title'] = title;
    json['abstract'] = abstract;
    json['url'] = url;
    json['uri'] = uri;
    json['byline'] = byline;
    json['item_type'] = itemType;
    json['updated_date'] = updatedDate;
    json['created_date'] = createdDate;
    json['published_date'] = publishedDate;
    json['material_type_facet'] = materialTypeFacet;
    json['kicker'] = kicker;
    json['des_facet'] = desFacet;
    json['org_facet'] = orgFacet;
    json['per_facet'] = perFacet;
    json['geo_facet'] = geoFacet;
    json['multimedia'] = multimedia?.map((e) => e.toJson()).toList();
    json['short_url'] = shortUrl;
    return json;
  }
}

class Multimedia {
  String? url;
  String? format;
  int? height;
  int? width;
  String? type;
  String? subtype;
  String? caption;
  String? copyright;

  Multimedia({
    this.url,
    this.format,
    this.height,
    this.width,
    this.type,
    this.subtype,
    this.caption,
    this.copyright,
  });

  Multimedia.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String?;
    format = json['format'] as String?;
    height = json['height'] as int?;
    width = json['width'] as int?;
    type = json['type'] as String?;
    subtype = json['subtype'] as String?;
    caption = json['caption'] as String?;
    copyright = json['copyright'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['url'] = url;
    json['format'] = format;
    json['height'] = height;
    json['width'] = width;
    json['type'] = type;
    json['subtype'] = subtype;
    json['caption'] = caption;
    json['copyright'] = copyright;
    return json;
  }
}