class Chat {
  String id;
  String name;
  String lastContent;

  Chat({required this.id, required this.name, required this.lastContent});

  Chat.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          lastContent: json['lastContent'],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "lastContent": lastContent,
    };
  }
}
