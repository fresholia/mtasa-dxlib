const Window = {
  cache : [],

  create : function(id, x, y, w, h, title) {
    var x = x + "px";
    var y = y + "px";
    var w = w + "px";
    var h = h + "px";
    document.getElementById("render").innerHTML += `
      <div draggable="true" class="window" id="window-${id}" style="margin-left: ${x}; margin-top: ${y}; width: ${w}; height: ${h}; min-width: ${w}; min-height: ${h}; max-width: ${w}; max-height: ${h};">
        <div class="title" id="window-${id}-title">
          ${title}
        </div>
        <div class="body" id="window-${id}-body">

        </div>
      </div>
    `;
    //dragElement(document.getElementById(`window-${id}`));
    return `window-${id}-body`;
  }
}

const Button = {
  cache : [],

  create : function(id, x, y, w, h, title, parent) {
    var x = x + "px";
    var y = y + "px";
    var w = w + "px";
    var h = h + "px";
    var importer = "render";
    if (parent) {
      importer = parent;
    }
    document.getElementById(importer).innerHTML += `
      <a href="#" id="button-${id}" class="btn" style="margin-left: ${x}; margin-top: ${y}; line-height: ${h}; width: ${w}; height: ${h};"><p>${title}</p></a>
    `;
    return id;
  }
}

const Label = {
  cache : [],

  create : function(id, x, y, w, h, title, parent) {
    var x = x + "px";
    var y = y + "px";
    var w = w + "px";
    var h = h + "px";
    var importer = "render";
    if (parent) {
      importer = `${parent}`;
    }
    document.getElementById(importer).innerHTML += `
      <p class="lbl" id="label-${id}" style="margin-left: ${x}; margin-top: ${y}; line-height: ${h}; width: ${w}; height: ${h};">${title}</p>
    `;
    return id;
  }
}

const Edit = {
  cache : [],

  create : function(id, x, y, w, h, val, parent) {
    var x = x + "px";
    var y = y + "px";
    var w = w + "px";
    var h = h + "px";
    var value = val;
    var placeholder = val;
    if (parent) {
      document.getElementById(`${parent}`).innerHTML += `
        <input value="${value}" placeholder="${placeholder}" class="edit" style="margin-left: ${x}; margin-top: ${y}; width: ${w}; height: ${h};">
      `;
    } else {

    }
  }
}

const Memo = {
  cache : [],

  create : function(id, x, y, w, h, val, parent) {
    var x = x + "px";
    var y = y + "px";
    var w = w + "px";
    var h = h + "px";
    var value = val.value;
    var placeholder = val.placeholder;
    if (parent) {
      document.getElementById(`${parent}`).innerHTML += `
        <textarea class="textarea" style="resize: none; margin-left: ${x}; margin-top: ${y}; width: ${w}; height: ${h};">
      `;
    } else {

    }
  }
}

function setProperty(id, key, value) {
  document.getElementById(id).style.key = value;
}

function setDragElement(id, bool) {
  if (bool == 1) {
    dragElement(document.getElementById(id));
  } else {
    closeDragElement(document.getElementById(id));
  }
}

function dragElement(elmnt) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  if (document.getElementById(elmnt.id + "-title")) {
    document.getElementById(elmnt.id + "-title").onmousedown = dragMouseDown;
  } else {
    elmnt.onmousedown = dragMouseDown;
  }

  function dragMouseDown(e) {
    e = e || window.event;
    e.preventDefault();
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
    elmnt.style.marginTop = (elmnt.offsetTop - pos2) + "px";
    elmnt.style.marginLeft = (elmnt.offsetLeft - pos1) + "px";
  }

  function closeDragElement() {
    document.onmouseup = null;
    document.onmousemove = null;
  }
}

window.addEventListener('DOMContentLoaded', (event) => {
    mta.triggerEvent("viewerDomLoaded");
});