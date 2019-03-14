const USAMap = {};
const USASvg = document.getElementById("USA");

const mapSvg = () => {
  const content = USASvg.contentDocument;
  const paths = content.querySelectorAll("path");

  for(path of paths) {
    const location = path.getAttribute("inkscape:label");

    USAMap[location] = path;
  }

  // console.log(USAMap);
};

const fillColorOfStates = () => {
  console.log(unemployment);
}

fillColorOfStates();

USASvg.addEventListener("load", mapSvg, false);
