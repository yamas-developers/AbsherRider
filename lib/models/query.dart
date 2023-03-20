class Query {
  String? id;
  String? name;
  String? description;
  String? parentId;
  int? level;
  int childrenCount;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;

  Query({
    this.id,
    this.name,
    this.description,
    this.parentId,
    this.level,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.childrenCount = 0,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    id: json['id'].toString(),
    name: json['name'],
    description: json['description'],
    parentId: (json['parent_id']??'').toString(),
    level: json['level'],
    role: json['role'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
    status: json['status'].toString(),
    childrenCount: json['children_count']??0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'parent_id': parentId,
    'level': level,
    'role': role,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'status': status,
    'children_count': childrenCount,
  };
}
