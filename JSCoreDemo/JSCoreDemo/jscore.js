var colorMap = {"red" : {"red":255, "green":0, "blue":0},
                "green" : {"red":0, "green":255, "blue":0},
                "blue" : {"red":0, "green":0, "blue":255}};
var colorForWord = function (word) {
	if (!colorMap[word])
        return;
    return makeUIColor(colorMap[word]);
};

var makeAPoint = function () {
    var point = p;
    point.printPoint();
}
