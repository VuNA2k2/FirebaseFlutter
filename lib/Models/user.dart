
class ModelUser {
  String _uId;

  ModelUser(this._uId);

  String get uId => _uId;

  static final ModelUser NONE = ModelUser('');
}