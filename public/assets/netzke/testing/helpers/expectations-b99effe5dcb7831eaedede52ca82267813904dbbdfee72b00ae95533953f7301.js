(function() {
  Ext.apply(window, {
    expectToSee: function(cmp) {
      if (Ext.isString(cmp)) {
        throw cmp + " not found";
      }
      return expect(Ext.isObject(cmp) || Ext.isElement(cmp)).to.be.ok();
    },
    expectToNotSee: function(el) {
      return expect(Ext.isString(el)).to.be.ok();
    },
    expectDisabled: function(cmp) {
      if (Ext.isString(cmp)) {
        throw cmp + " not found";
      }
      return expect(cmp.isDisabled()).to.be(true);
    },
    expectEnabled: function(cmp) {
      if (Ext.isString(cmp)) {
        throw cmp + " not found";
      }
      return expect(cmp.isDisabled()).to.be(false);
    },
    expectInvisibleBodyOf: function(cmp) {
      if (Ext.isString(cmp)) {
        throw cmp + " not found";
      }
      return expect(cmp.body.isVisible()).to.be(false);
    }
  });

}).call(this);
