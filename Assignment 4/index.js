const mapSvgToNode = (svg) => {
  const map = {};
  const paths = svg.contentDocument.querySelectorAll("path");

  for(path of paths) {
    const location = path.getAttribute("inkscape:label");

    map[location] = path;
  }

  return map;
};

const mapLocationToValue = (array) => {
  const map = {};

  for(value of array) {
    const location = `${value[1]}, ${value[2]}`;

    map[location] = value[4];
  }

  return map;
}

const fillColorOfStates = (nodeMap, valueMap) => {
  Object.keys(nodeMap).forEach((key) => {
    const value = valueMap[key] || 0;
    const smallerThanMid = value < 10;
    const node = nodeMap[key];

    node.style.fill = smallerThanMid ? 'green' : 'OrangeRed';

    node.style.opacity = value / 20;
  });
}

const updateMessage = (() => {
  const locationNode = document.getElementById('location');
  const rateNode = document.getElementById('rate');

  return (node, valueMap) => {
    const location = node.getAttribute("inkscape:label");
    const value = valueMap[location];
  
    locationNode.innerText = location;
  
    rateNode.innerText = value;
  }
})();

const USASvg = document.getElementById("USA");

const listenNodeSelectEvent = (valueMap) => {
  let currNode = null;
  let currLabel = '';
  let currOpacity = 0;
  let currFill = 'red';

  const clearNode = () => {
    if (currNode !== null) {
      currNode.style.opacity = currOpacity;

      currNode.style.fill = currFill;
    }
  }

  const saveNode = (target) => {
    currNode = target;
  
    currOpacity = target.style.opacity;

    currFill = target.style.fill;
  }

  const selectNode = (target) => {
    target.style.fill = 'blue';
  
    target.style.opacity = '1';
  }
  
  USASvg.contentDocument.addEventListener('mousemove', ({ target }) => {
    const label = target.getAttribute("inkscape:label");
    if (label === "#State_borders" || label === '') {
      return;
    }

    if (target.nodeName === "path") {
  
      USASvg.style.opacity = '0.6';
  
      if (label !== currLabel) {
        clearNode();
  
        saveNode(target);

        selectNode(target);

        updateMessage(target, valueMap);
      }
    } else {
      clearNode();
  
      USASvg.style.opacity = '1';
    }
  })
}

USASvg.addEventListener("load", () => {
  const nodeMap = mapSvgToNode(USASvg);
  const valueMap = mapLocationToValue(unemployment);

  listenNodeSelectEvent(valueMap);

  fillColorOfStates(nodeMap, valueMap);
}, false);


