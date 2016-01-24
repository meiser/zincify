(function() {
  Ext.apply(window, {
    header: function(title) {
      return Ext.ComponentQuery.query('panel{isVisible(true)}[title="' + title + '"]')[0] || 'header ' + title;
    },
    tab: function(title) {
      return Ext.ComponentQuery.query('tab[text="' + title + '"]')[0] || 'tab ' + title;
    },
    panelWithContent: function(text) {
      return Ext.DomQuery.select("div.x-panel-body:contains(" + text + ")")[0] || 'panel with content ' + text;
    },
    button: function(text) {
      var button;
      button = Ext.ComponentQuery.query("button{isVisible(true)}[text='" + text + "']")[0];
      button || (button = Ext.ComponentQuery.query("button{isVisible(true)}[tooltip='" + text + "']")[0]);
      return button || "button " + text;
    },
    tool: function(type) {
      return Ext.ComponentQuery.query("tool{isVisible(true)}[type='" + type + "']")[0] || 'tool ' + type;
    },
    component: function(id) {
      return Ext.ComponentQuery.query("panel{isVisible(true)}[id='" + id + "']")[0] || 'component ' + id;
    },
    somewhere: function(text) {
      return Ext.DomQuery.select("*:contains(" + text + ")")[0] || 'anywhere ' + text;
    },
    currentPanelTitle: function() {
      var panel;
      panel = Ext.ComponentQuery.query('panel[hidden=false]')[0];
      if (!panel) {
        throw "Panel not found";
      }
      return panel.getHeader().getTitle().text;
    },
    combobox: function(name) {
      return Ext.ComponentQuery.query("combo{isVisible(true)}[name='" + name + "']")[0] || 'combobox ' + name;
    },
    icon: function(tooltip) {
      return Ext.DomQuery.select('img[data-qtip="' + tooltip + '"]')[0] || 'icon ' + tooltip;
    },
    textfield: function(name) {
      return Ext.ComponentQuery.query("textfield{isVisible(true)}[name='" + name + "']")[0] || 'textfield ' + name;
    },
    numberfield: function(name) {
      return Ext.ComponentQuery.query("numberfield{isVisible(true)}[name='" + name + "']")[0] || 'numberfield ' + name;
    },
    datefield: function(name) {
      return Ext.ComponentQuery.query("datefield{isVisible(true)}[name='" + name + "']")[0] || 'datefield ' + name;
    },
    xdatetime: function(name) {
      return Ext.ComponentQuery.query("xdatetime{isVisible(true)}[name='" + name + "']")[0] || 'xdatetime ' + name;
    },
    textFieldWith: function(text) {
      return _componentLike("textfield", "value", text);
    },
    comboboxWith: function(text) {
      return _componentLike("combo", "rawValue", text);
    },
    textAreaWith: function(text) {
      return _componentLike("textareafield", "value", text);
    },
    numberFieldWith: function(value) {
      return _componentLike("numberfield", "value", value);
    },
    activeWindow: function() {
      return Ext.WindowMgr.getActive();
    },
    dateTimeFieldWith: function(value) {
      var res;
      res = 'xdatetime with value ' + value;
      Ext.each(Ext.ComponentQuery.query('xdatetime'), function(item) {
        if (item.getValue().toString() === (new Date(value)).toString()) {
          res = item;
        }
      });
      return res;
    },
    dateFieldWith: function(value) {
      var res;
      res = 'datefield with value ' + value;
      Ext.each(Ext.ComponentQuery.query('datefield'), function(item) {
        if (item.getValue().toString() === (new Date(value)).toString()) {
          res = item;
        }
      });
      return res;
    },
    eastRegion: function() {
      return Ext.ComponentQuery.query("[region=east]")[0];
    },
    westRegion: function() {
      return Ext.ComponentQuery.query("[region=west]")[0];
    },
    southRegion: function() {
      return Ext.ComponentQuery.query("[region=south]")[0];
    },
    northRegion: function() {
      return Ext.ComponentQuery.query("[region=north]")[0];
    },
    _componentLike: function(type, attr, value) {
      return Ext.ComponentQuery.query(type + '[' + attr + '=' + value + ']')[0] || type + " with " + attr + " '" + value + "'";
    }
  });

  window.anywhere = window.somewhere;

}).call(this);
