;(function($){

  /*************************************************************
   Menu Tree       handle child menu display & active status
   *************************************************************/
  var node = function(link, parent) {
    var self = {
      link : link,
      position : $(link.attr("href")).position().top,
      parent : parent,
      childrenUl : link.next("ul")
    };

    var initChildren = function(that) {
      var children = [];
      link.next("ul").find("> li > a").each(function(){
        children.push(node($(this), that));
      });
      return children;
    };

    self.children = initChildren(self);

    self.hideChildren = function() {
      self.childrenUl && self.childrenUl.hide();
      for (var i = 0; i < self.children.length; i++) {
        self.children[i].hideChildren();
      }
    };

    self.showChildren = function() {
      self.childrenUl && self.childrenUl.show();
      if (self.parent != null) {
        self.parent.showChildren();
      }
    };

    self.activate = function() {
      self.link.hasClass("active") || self.link.addClass("active");
    };

    self.deactivate = function() {
      self.link.removeClass("active");
    };

    return self;
  };

  var menuTree = function() {
    var self = {};
    var root = {
      children: [],
      hideChildren : function() {
        this.childrenUl && this.childrenUl.hide();
        for (var i = 0; i < this.children.length; i++) {
          this.children[i].hideChildren();
        }
      }
    };
    var activeNode;

    var init = function() {
      $("#text-table-of-contents > ul > li > a").each(function() {
        root.children.push(node($(this), null));
      });
      root.hideChildren();
    };

    var iterate = function(node, callback) {
      for (var i = 0; i < node.children.length; i++) {
        var ret = callback(node.children[i]);
        if (ret === false) {
          break;
        }
        iterate(node.children[i], callback);
      }
    };

    self.eachNode = function(callback) {
      iterate(root, callback);
    };

    var changeActiveNode = function(node) {
      if (!node || activeNode == node) {
        return;
      }
      // Hide all & Show active
      root.hideChildren();
      node.showChildren();
      // Set link activation
      activeNode && activeNode.deactivate();
      node.activate();

      activeNode = node;
    };

    self.scrollListener = function(scrollTop) {
      var active = null;
      self.eachNode(function(node) {
        if (node.position < scrollTop + 10) {
          active = node;
        } else {
          return false;
        }
        return true;
      });
      changeActiveNode(active);
    };

    init();
    return self;
  };


  var menuPositionController = function() {
    var self = {};
    var status = "top";// top | bottom | middle
    var container = $("#text-table-of-contents");
    var top = container.offset().top;
    var bottom = $(document).height() - 210;

    var changeStatus = function(newStatus) {
      container.removeClass(status);
      container.addClass(newStatus);
      status = newStatus;
    };

    var getBottomPosition = function() {
      return container.offset().top + container.height();
    };

    self.scrollListener = function(scrollTop) {
      if (status == "top" && top < scrollTop + 20) {
        changeStatus("middle");
      } else if (status == "middle" && top > scrollTop + 20) {
        changeStatus("top");
      } else if (status == "middle" && getBottomPosition() > bottom) {
        changeStatus("bottom");
      } else if (status == "bottom" && getBottomPosition() < bottom) {
        changeStatus("middle");
      }
    };

    return self;
  };


  /***************************************
   Indent Controll
   ***************************************/
  var indentList = function(list, times) {
    list.find(" > li > a").each(function() {
      var link = $(this);
      var paddingLeft = link.css("padding-left").match(/\d+/)[0];
      link.css("padding-left", times * paddingLeft + "px");
    });
  };

  var initListIndent = function(list, times) {
    times = times || 2;
    list.find(" > li > ul").each(function() {
      var list = $(this);
      indentList(list, times);
      initListIndent(list, times+1);
    });
  };

  var hasMenu = function() {
    return $("#table-of-contents").css("display") != "none";
  };

  $(function(){
    if (!hasMenu()) {
      return;
    }
    var menu = menuTree();
    var menuPosController =  menuPositionController();
    initListIndent($("#text-table-of-contents > ul"));
    $(window).scroll(function() {
      var scrollTop = $(document).scrollTop();
      menu.scrollListener(scrollTop);
      menuPosController.scrollListener(scrollTop);
    });
  });

})(jQuery);
