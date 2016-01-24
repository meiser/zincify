(function() {
  Ext.apply(window, {
    grid: function(value, lookup) {
      lookup = lookup || 'title';
      if (value && lookup === 'title') {
        return Ext.ComponentQuery.query('grid[title="' + value + '"]')[0] || Ext.ComponentQuery.query('treepanel[title="' + value + '"]')[0];
      } else if (value && lookup === 'name') {
        return Ext.ComponentQuery.query('grid[name="' + value + '"]')[0] || Ext.ComponentQuery.query('treepanel[name="' + value + '"]')[0];
      } else {
        return Ext.ComponentQuery.query('grid{isVisible(true)}')[0] || Ext.ComponentQuery.query('treepanel{isVisible(true)}')[0];
      }
    },
    expandRowCombo: function(field, params) {
      var column, editor, g;
      g = g || this.grid();
      editor = g.getPlugin('celleditor');
      column = g.headerCt.items.findIndex('name', field) - 1;
      editor.startEditByPosition({
        row: g.getSelectionModel().getCurrentPosition().rowIdx,
        column: column
      });
      return editor.activeEditor.field.onTriggerClick();
    },
    addRecords: function() {
      var params, record, _i, _len;
      params = arguments[arguments.length - 1];
      for (_i = 0, _len = arguments.length; _i < _len; _i++) {
        record = arguments[_i];
        if (record !== params) {
          record = params.to.getStore().add(record)[0];
          record.isNew = true;
        }
      }
      if (params.submit) {
        return click(button('Apply'));
      }
    },
    addRecord: function(recordData, params) {
      var grid, record;
      params = params || [];
      grid = params.to || this.grid();
      record = grid.getStore().add(recordData);
      return grid.getSelectionModel().select(grid.getStore().last());
    },
    updateRecord: function(recordData, params) {
      var grid, key, record, value, _results;
      params = params || [];
      grid = params.to || this.grid();
      record = grid.getSelectionModel().getSelection()[0];
      _results = [];
      for (key in recordData) {
        value = recordData[key];
        _results.push(record.set(key, value));
      }
      return _results;
    },
    selectAssociation: function(attr, value, callback) {
      var action;
      action = function(cb) {
        expandRowCombo(attr);
        return wait(function() {
          select(value, {
            "in": combobox(attr)
          });
          return cb();
        });
      };
      if (callback) {
        return action(callback);
      } else {
        return new Promise(function(resolve, reject) {
          return action(resolve);
        });
      }
    },
    valuesInColumn: function(name, params) {
      var grid, i, out;
      if (params == null) {
        params = {};
      }
      grid = params["in"] || this.grid();
      out = [];
      i = 0;
      grid.getStore().each(function(r) {
        return out.push(valueInCell(name, i++, params));
      });
      return out;
    },
    valueInCell: function(column, rowIndex, params) {
      var el, grid, r;
      if (params == null) {
        params = {};
      }
      grid = params["in"] || this.grid();
      r = grid.getStore().getAt(rowIndex);
      column = grid.headerCt.items.findBy(function(c) {
        return c.name === column;
      });
      el = Ext.DomQuery.select("table[data-recordid=" + r.internalId + "] tbody tr td.x-grid-cell-" + column.id + " div")[0];
      return el.innerHTML;
    },
    selectAllRows: function(params) {
      var grid;
            if (params != null) {
        params;
      } else {
        params = {};
      };
      grid = params["in"] || this.grid();
      return grid.getSelectionModel().selectAll();
    },
    rowDisplayValues: function(params) {
      var grid, i, record, visibleColumns;
            if (params != null) {
        params;
      } else {
        params = {};
      };
      grid = params["in"] || this.grid();
      record = params.of || grid.getSelectionModel().getSelection()[0];
      visibleColumns = [];
      Ext.each(grid.columns, function(c) {
        if (c.isVisible()) {
          return visibleColumns.push(c);
        }
      });
      i = -1;
      return Ext.Array.map(Ext.DomQuery.select('table[data-recordid="' + record.internalId + '"] tbody tr td div'), function(cell) {
        i++;
        if (visibleColumns[i].attrType === 'boolean') {
          return record.get(visibleColumns[i].name);
        } else {
          return cell.innerHTML;
        }
      });
    },
    selectLastRow: function(params) {
      var grid;
            if (params != null) {
        params;
      } else {
        params = {};
      };
      grid = params["in"] || this.grid();
      return grid.getSelectionModel().select(grid.getStore().last());
    },
    selectFirstRow: function(params) {
      var grid;
            if (params != null) {
        params;
      } else {
        params = {};
      };
      grid = params["in"] || this.grid();
      return grid.getSelectionModel().select(grid.getStore().first());
    },
    selectRow: function(n, params) {
      var grid;
            if (params != null) {
        params;
      } else {
        params = {};
      };
      grid = params["in"] || this.grid();
      return grid.getSelectionModel().select(n);
    },
    editLastRow: function() {
      var data, grid, key, record, store, _results;
      data = arguments[0];
      grid = Ext.ComponentQuery.query("grid")[0];
      store = grid.getStore();
      record = store.last();
      _results = [];
      for (key in data) {
        _results.push(record.set(key, data[key]));
      }
      return _results;
    },
    completeEditing: function(g) {
      var e;
      g = g || this.grid();
      e = g.getPlugin('celleditor');
      return e.completeEdit();
    }
  });

}).call(this);
