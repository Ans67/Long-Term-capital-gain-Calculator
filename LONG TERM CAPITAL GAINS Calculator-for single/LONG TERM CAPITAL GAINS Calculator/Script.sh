#!/bin/sh

#  Script.sh
#  LONG TERM CAPITAL GAINS Calculator
#
#  Created by Anas Mansuri on 23/07/19.
#  Copyright © 2019 Anas Mansuri. All rights reserved.

(function() {
$.fn.calcslider = function(d) {
var c = $.extend({
autoslide: false,
autoslideInterval: 1000,
slideInterval: 1000
}, d);

return this.each(function() {
var a = "",
j = $(this),
b = j.find(".calc-list li").length,
k = j.find(".calc-list li").outerWidth(true),
n = b * k,
m = true;
j.find(".calc-list ul").width(n);
if (b == 1) {
j.find(".prev-slide").addClass("hide");
j.find(".next-slide").addClass("hide")
}

var l = function(e) {
if (c.autoslide) {
if (e == "clear") {
clearInterval(a)
} else {
a = setInterval(function() {
j.find(".next-slide").trigger("click")
}, c.autoslideInterval)
}
}
};


l("set");
j.find(".prev-slide").stop(true, true).click(function() {
if (m == true) {
m = false;
l("clear");
var e = j.find(".calc-list ul li:last-child").detach();
j.find(".calc-list ul").prepend(e);
j.find(".calc-list ul").css("marginLeft", "-" + k + "px");
j.find(".calc-list ul").animate({
marginLeft: "0"
}, c.slideInterval, function() {
m = true;
l("set")
})
}
return false
});


j.find(".next-slide").stop(true, true).click(function() {
if (m == true) {
m = false;
l("clear");
j.find(".calc-list ul").animate({
marginLeft: "-" + k + "px"
}, c.slideInterval, function() {
var e = j.find(".calc-list ul li:first-child").detach();
j.find(".calc-list ul").append(e);
j.find(".calc-list ul").css("marginLeft", 0);
m = true;
l("set")
})
}
return false
})
})
};


$(".morecalc-slider, .calculatorwrap, .videowrap").calcslider({
autoslide: true,
autoslideInterval: 3000,
slideInterval: 500
})
})(jQuery);
obj_ltcg = {
add_item: function() {
var b = $(".tool-row-box ul li").length + 1;
return '<li><div class="input-wrap"><span class="item-index-no"><span>' + b + '</span></span><span class="type-box stock-name"><input type="text" maxlength="50" class="name-inpt"/></span><span class="qty-box number-input"><input type="text" maxlength="10" value="0"/></span><span class="date-box buy-date"><input type="text" readonly="true" /></span><span class="buy-box number-input"><input type="text" maxlength="10" value="0"/></span><span class="mar_val-box number-input"><input type="text" maxlength="10" disabled="true" value="0"/></span><span class="sell-date-box date-box"><input type="text" readonly="true"/></span><span class="sell-box number-input"><input type="text" maxlength="10" disabled="true" value="0"/></span><span class="new_cost-box number-input hide"><input type="text" disabled="true" value="0"/></span><span class="total_cost-box number-input hide"><input type="text" disabled="true" value="0"/></span><span class="total_sale-box number-input hide"><input type="text" disabled="true" value="0"/></span><span class="cost_acqu-box number-input"><input type="text" disabled="true" value="0"/></span><span class="ltcg-box number-input"><input type="text" disabled="true" value="0"/></span><span class="tax-box number-input hide"><input type="text" disabled="true" value="0"/></span><span title="Clear Item" class="sprite sprite-clear"></span><span title="Delete Item" class="sprite sprite-delete row-remove hide"></span></div></li>'
},
add_dateplugin: function(l) {
console.log("scope");
var i = new Date(),
h = i.getDate(),
j = i.getMonth() + 1,
m = i.getFullYear(),
n = j + "-" + h + "-" + m;
if (typeof jQuery.ui === "undefined") {
$.getScript("/jquery_ui_1_10.cms", function() {
$("head").append('<link rel="stylesheet" type="text/css" href="/css_ui_js.cms?v=10">');
var a = new Date();
h = a.getDate(), j = a.getMonth(), m = a.getFullYear();
$(".date-box input").datepicker({
changeMonth: true,
changeYear: true,
dateFormat: "mm-dd-yy",
yearRange: "1960:20018",
maxDate: new Date(2018, 2, 31),
onSelect: function(c, b) {
var d = $("#" + b.id).datepicker("getDate");
obj_ltcg.dateSelect(d, b)
}
});


$(".sell-date-box input").datepicker("option", "minDate", new Date(2018, 3, 1));
$(".sell-date-box input").datepicker("option", "maxDate", new Date(2019, 2, 31));
if (typeof (Storage) !== "undefined" && typeof sessionStorage.ltcgHTML != "undefined") {
obj_ltcg.renderSS()
}
$(".loaderwrap").addClass("hidden")
})
} else {
var i = new Date();
h = i.getDate(), j = i.getMonth(), m = i.getFullYear();
l.datepicker({
changeMonth: true,
changeYear: true,
dateFormat: "mm-dd-yy",
yearRange: "1960:20018",
maxDate: new Date(2018, 2, 31),
onSelect: function(b, a) {
var c = $("#" + a.id).datepicker("getDate");
obj_ltcg.dateSelect(c, a)
}
});
if (l.parent().hasClass("sell-date-box")) {
var k = l.val();
l.datepicker("option", "minDate", new Date(2018, 3, 1));
l.datepicker("option", "maxDate", new Date(2019, 2, 31));
l.datepicker("setDate", k)
}
}
},
dateSelect: function(d, c) {
if ((d >= new Date(2018, 1, 1)) && !$("#" + c.id).parent().hasClass("sell-date-box")) {
$("#" + c.id).parents(".input-wrap").find(".mar_val-box input, .new_cost-box input").val(0).prop("disabled", true)
} else {
if ((d < new Date(2018, 1, 1)) && !$("#" + c.id).parent().hasClass("sell-date-box")) {
$("#" + c.id).parents(".input-wrap").find(".mar_val-box input").prop("disabled", false);
$("#" + c.id).parents(".input-wrap").find(".new_cost-box input").val(0)
}
}

obj_ltcg.dateValid($("#" + c.id).parents(".input-wrap"), d, $("#" + c.id), c);
obj_ltcg.tool_calc($("#" + c.id).parents(".input-wrap"))
},
monthDiff: function(h, e) {
var f = 24 * 60 * 60 * 1000,
g = Math.round(Math.abs((h.getTime() - e.getTime()) / (f)));
return g
},
dateValid: function(l, m, h, j) {
var n = l.find(".sell-date-box input").datepicker("getDate"),
i = l.find(".buy-date input").datepicker("getDate");
if (n != null && i != null) {
var k = obj_ltcg.monthDiff(i, n);
if (k < 365) {
console.log(j.lastVal);
if (h.parent().hasClass("sell-date-box")) {
h.datepicker("setDate", "")
} else {
h.datepicker("setDate", "")
}
alert("Holding period is less than one year. Your capital gains are not long term. Change purchase or sale dates or exit calculator.")
} else {
l.find(".sell-box input").prop("disabled", false)
}
}
},
tool_finalcalc: function() {
$(".right-block .right_total-ltcg input").val(0);
$(".right-block .right_total-tax input").val(0);
$(".left-block .left_total-ltcg input").val(0);
$(".left-block .left_total-tax input").val(0);
var l = 0,
n = 0,
j = [],
k = [],
h = "",
m = "",
i = 0;
$(".tool-row-box li").each(function() {
var b = $(this),
a = b.find(".sell-date-box input").datepicker("getDate");
if (a >= new Date(2018, 3, 1)) {
l += Number(b.find(".ltcg-box input").val().trim());
j.push(($(this).index() + 1))
} else {
n += Number(b.find(".ltcg-box input").val().trim());
k.push(($(this).index() + 1))
}
});
if (l > 100000) {
i = ((l - 100000) * 10.4) / 100
} else {
i = 0
}
i = Number(i.toFixed(2));
$(".left-block .left_total-ltcg input").val(l);
$(".left-block .left_total-tax input").val(i);
$(".right-block .right_total-ltcg input").val(n);
obj_ltcg.storeSS()
},
numberFormat: function(f) {
var e = Number(f),
d = e.toFixed(2);
return Number(d)
},
tool_calc: function(t) {
var D = obj_ltcg.numberFormat(t.find(".qty-box input").val().trim()),
A = obj_ltcg.numberFormat(t.find(".buy-box input").val().trim()),
s = obj_ltcg.numberFormat(t.find(".mar_val-box input").val().trim()),
v = obj_ltcg.numberFormat(t.find(".sell-box input").val().trim()),
B = t.find(".date-box.buy-date input").datepicker("getDate"),
z = t.find(".date-box.sell-date-box input").datepicker("getDate"),
r = Math.min(s, v),
p = Math.max(r, A),
w = D * p,
x = D * v,
C = 0,
u = 0,
y = 0,
q = 0;
if (B != null) {
if (B >= new Date(2018, 1, 1)) {
C = D * (v - p), C = D > 0 ? C : 0, u = (C - 100000) * 0.1, u = D > 0 ? (u > 0 ? u : 0) : 0;
t.find(".mar_val-box input, .new_cost-box input").val(0).prop("disabled", true)
} else {
if (B < new Date(2018, 1, 1)) {
C = x - w, C = D > 0 ? C : 0, u = C * 0.1;
u = D > 0 ? (u > 0 ? u : 0) : 0;
t.find(".mar_val-box input").prop("disabled", false);
t.find(".new_cost-box input").val(p)
}
}
t.find(".cost_acqu-box input").val(p);
t.find(".total_cost-box input").val(w);
t.find(".total_sale-box input").val(x);
t.find(".ltcg-box input").val(C);
t.find(".tax-box input").val(u);
if (C >= 0) {
t.find(".ltcg-box input").removeClass("error")
} else {
t.find(".ltcg-box input").addClass("error")
}
obj_ltcg.tool_finalcalc()
}
},

renderSS: function() {
$(".tool-row-box ul").html(sessionStorage.ltcgHTML);
var b = JSON.parse(sessionStorage.ltcgVal);
$(".date-box input").removeClass("hasDatepicker");
$.each(b, function(f, a) {
var e = $(".tool-row-box ul li:eq(" + f + ")");
e.find(".qty-box input").val(b[f].qty), e.find(".buy-box input").val(b[f].buy_price), e.find(".buy-date input").val(b[f].buy_date), e.find(".mar_val-box input").val(b[f].fmv_price), e.find(".sell-box input").val(b[f].sell_price), e.find(".sell-date-box input").val(b[f].sell_date), e.find(".stock-name input").val(b[f].stock_name)
});
$(".date-box input").each(function() {
obj_ltcg.add_dateplugin($(this))
});
$(".number-input input").ForceNumericOnly();
$(".tool-row-box ul li").each(function() {
obj_ltcg.tool_calc($(this))
})
},
storeSS: function() {
if (typeof (Storage) !== "undefined") {
var b = [];
$(".tool-row-box ul li").each(function() {
var a = $(this);
b.push({
stock_name: a.find(".stock-name input").val(),
qty: a.find(".qty-box input").val(),
buy_price: a.find(".buy-box input").val(),
fmv_price: a.find(".mar_val-box input").val(),
sell_price: a.find(".sell-box input").val(),
buy_date: a.find(".buy-date input").val(),
sell_date: a.find(".sell-date-box input").val()
})
});
sessionStorage.ltcgHTML = $(".tool-row-box ul").html();
sessionStorage.ltcgVal = JSON.stringify(b)
}
},
bind: function() {
$(".tool-row-box").on("blur", ".qty-box input, .buy-box input, .mar_val-box input, .sell-box input", function() {
var c = $(this),
d = c.parents("li");
obj_ltcg.tool_calc(d);
obj_ltcg.storeSS()
});
$(".tool-row-box").on("blur", ".stock-name", function() {
obj_ltcg.storeSS()
});
$(".tool-row-box").on("blur", ".number-input input", function() {
if (Number($(this).val().trim()) == "") {
$(this).val(0)
}
});
$(".tool-row-box").on("focus", ".number-input input", function() {
if (Number($(this).val().trim()) == 0) {
$(this).val("")
}
});
$(".tool-btn .additem-btn").click(function() {
var b = obj_ltcg.add_item();
$(".tool-row-box ul").append(b);
$(".date-box input").each(function() {
var a = $(this);
if (!a.hasClass("hasDatepicker")) {
obj_ltcg.add_dateplugin(a)
}
});
if ($(".tool-row-box li").length > 1) {
$(".tool-row-box li .row-remove").removeClass("hide")
}
$(".number-input input").ForceNumericOnly()
});
$(".ltcg-tool").on("click", ".row-remove", function() {
var b = $(this);
b.parents("li").remove();
$(".tool-row-box li").each(function(e, a) {
var f = e + 1;
$(this).find(".item-index-no span").text(f)
});
if ($(".tool-row-box li").length == 1) {
$(".tool-row-box li .row-remove").addClass("hide")
}
obj_ltcg.tool_finalcalc()
});
$(".ltcg-tool").on("click", ".sprite-clear", function() {
var c = $(this),
d = c.parents("li");
d.find(".type-box input, .date-box input").val("");
d.find(".qty-box input, .buy-box input, .mar_val-box input, .sell-box input, .cost_acqu-box input, .ltcg-box input").val(0);
d.find(".mar_val-box input, .sell-box input").prop("disabled", true);
d.find(".ltcg-box input").removeClass("error");
obj_ltcg.tool_finalcalc(d);
obj_ltcg.storeSS()
})
},
init: function() {
obj_ltcg.bind();
obj_ltcg.add_dateplugin();
$(".number-input input").ForceNumericOnly()
}
};
$(document).ready(function() {
$.fn.ForceNumericOnly = function() {
return this.each(function() {
$(this).keypress(function(c) {
var d = c.charCode || c.keyCode || 0;
return ( !(d == 8 || d == 46) && (d < 48 || d > 57) ? false : true)
})
})
};
obj_ltcg.init()
});

