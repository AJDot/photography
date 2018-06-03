export default class Model {
  constructor(attrs = {}) {
    this.parent = attrs.parent || null;
    this.id = attrs.id || null;
  }

  static loadFromJSON(modelHash, embeddedModels = []) {
    let model = new this();
    model.loadFromJSON(modelHash, embeddedModels);
    return model;
  }

  loadFromJSON(modelHash, embeddedModels = []) {
    let modelKeys = Object.keys(modelHash);
    let embeddedModelProps = embeddedModels.map(em => em.prop);

    modelKeys.forEach( key => {
      if (!embeddedModelProps.includes(key) && modelHash.hasOwnProperty(key)) {
        this[key] = modelHash[key];
      }
    });

    embeddedModels.forEach(attrs => {
      let modelName = attrs.modelName;
      let prop = attrs.prop;

      if (modelHash[prop]) {
        if (Array.isArray(modelHash[prop])) {
          this[prop] = modelHash[prop].map(embeddedHash => {
            let newModel = this["create" + modelName].call(this, embeddedHash);
            newModel.setParent(this);
            return newModel;
          });
        } else {
          let newModel = this["create" + modelName].call(this, modelHash[prop]);
          newModel.setParent(this);
          this[prop] = newModel;
        }
      }
    });

    this.afterInitialize();
  }

  myJSON() {
    return {
      id: this.id,
      name: this.name,
      order: this.order
    }
  }

  getChangesAsJSON(childJSON = null) {
    let myJSON = this.myJSON();

    if (childJSON) {
      myJSON.tags_attributes = [childJSON];
    }

    if (this.parent) {
      return this.parent.getChangesAsJSON(myJSON);
    }

    return myJSON;
  }

  afterInitialize() {
    return null;
  }

  setParent(parent) {
    this.parent = parent;
  }

}
