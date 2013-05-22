// ComboBox that gets options from the server (used in both grids and panels)
Ext.define('Ext.netzke.BaanComboBox', {
  extend        : 'Ext.netzke.ComboBox',
  alias         : 'widget.netzkebaanremotecombo',
  valueField    : 'value',
  displayField  : 'text',
  triggerAction : 'all',
  forceSelection: true,
  listConfig: {
                loadingText: 'Searching...',
                emptyText: 'No matching posts found.',

                // Custom rendering template for each item
                getInnerTpl: function() {
                    return '<a class="search-item" href="http://www.sencha.com/forum/showthread.php?t={topicId}&p={id}">' +
                        '<h3><span>{[Ext.Date.format(values.lastPost, "M j, Y")]}<br />by {text}</span>{value}</h3>' +
                        '{excerpt}' +
                    '</a>';
                }
  },

  initComponent : function(){
    var modelName = this.parentId + "_" + this.name;

    if (this.blankLine == undefined) this.blankLine = "---";

    Ext.define(modelName, {
        extend: 'Ext.data.Model',
        fields: ['value', 'text']
    });

    var store = new Ext.data.Store({
      model: modelName,
      proxy: {
        type: 'direct',
		directFn: Rails.list,
        //directFn: Netzke.providers[this.parentId].getComboboxOptions,
        reader: {
          type: 'array',
          root: 'data'
        }
      }
    });

    store.on('beforeload', function(self, params) {
      params.params.attr = this.name;
    },this);

    // insert a selectable "blank line" which allows to remove the associated record
    if (this.blankLine) {
      store.on('load', function(self, params) {
        // append a selectable "empty line" which will allow remove the association
        self.add(Ext.create(modelName, {value: -1, text: this.blankLine}));
      }, this);
    }

    // If inline data was passed (TODO: is this actually working?)
    if (this.store) store.loadData({data: this.store});

    this.store = store;

    this.callParent();
  },

});