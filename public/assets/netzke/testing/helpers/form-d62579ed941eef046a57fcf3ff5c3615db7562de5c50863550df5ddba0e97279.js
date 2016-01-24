(function() {
  Ext.apply(window, {
    fill: function(field, params) {
      return field.setValue(params["with"]);
    },
    expandCombo: function(combo) {
      combo = Ext.ComponentQuery.query("combo{isVisible(true)}[name=" + combo + "]")[0];
      return combo.onTriggerClick();
    }
  });

}).call(this);
