(function() {
  Ext.Ajax.on('beforerequest', function() {
    Netzke.ajaxCount = window.ajaxCount || 0;
    return Netzke.ajaxCount += 1;
  });

  Ext.Ajax.on('requestcomplete', function() {
    return Netzke.ajaxCount -= 1;
  });

  Ext.apply(window, {
    wait: function() {
      var callback, delay, waitInCycle;
      waitInCycle = function(callback) {
        var i, id;
        i = 0;
        return id = setInterval(function() {
          i += 1;
          if (i >= 100) {
            clearInterval(id);
            callback.call();
          }
          if (Netzke.ajaxCount === 0) {
            return i = 100;
          }
        }, 200);
      };
      if (typeof arguments[0] === 'function') {
        return waitInCycle(arguments[0]);
      }
      if (Ext.isNumber(arguments[0])) {
        if (Ext.isFunction(arguments[1])) {
          delay = arguments[0];
          callback = arguments[1];
          setInterval(function() {
            return waitInCycle(resolve);
          }, delay);
          return null;
        } else {
          console.log("1", 1);
          delay = arguments[0];
          return new Promise(function(resolve, reject) {
            return setInterval(function() {
              return waitInCycle(resolve);
            }, delay);
          });
        }
      }
      return new Promise(function(resolve, reject) {
        return waitInCycle(resolve);
      });
    },
    click: function(cmp) {
      var el;
      if (Ext.isString(cmp)) {
        throw "Could not locate " + cmp;
      } else if (cmp.isXType) {
        if (cmp.isXType('tool')) {
          el = cmp.toolEl;
        } else {
          el = cmp.getEl();
        }
        return el.dom.click();
      } else if (Ext.isElement(cmp)) {
        return cmp.click();
      }
    },
    closeWindow: function() {
      return Ext.ComponentQuery.query("window[hidden=false]")[0].close();
    },
    select: function(value, params, callback) {
      var combo, rec;
            if (params != null) {
        params;
      } else {
        params = params;
      };
      combo = params["in"];
      if (combo.isExpanded) {
        combo.setValue(combo.findRecordByDisplay(value));
        return combo.collapse();
      } else {
        combo.onTriggerClick();
        if (callback) {
          return wait(function() {
            var rec;
            rec = combo.findRecordByDisplay(value);
            combo.select(rec);
            combo.fireEvent('select', combo, rec);
            combo.collapse();
            return callback.call();
          });
        } else {
          rec = combo.findRecordByDisplay(value);
          combo.select(rec);
          combo.fireEvent('select', combo, rec);
          return combo.collapse();
        }
      }
    }
  });

}).call(this);
