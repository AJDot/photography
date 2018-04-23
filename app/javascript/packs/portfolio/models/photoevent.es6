export default class Photoevent {
  constructor(attrs = {}) {

  }

  static loadFromJSON(modelHash) {
    var model = new this();
    model.loadFromJSON(modelHash);
    return model;
  }

  loadFromJSON(modelHash) {
    for(var key in modelHash) {
      // if (key !== "tags") {
        if (modelHash.hasOwnProperty(key)) {
          this[key] = modelHash[key];
        }
      // }
    }

    // if (modelHash.tags) {
    //   this.tags = modelHash.tags.map(tag => {
    //     var newTag = this.createTag(tag);
    //     newTag.setParent(this);
    //     return newTag;
    //   });
    // }
  }

}
