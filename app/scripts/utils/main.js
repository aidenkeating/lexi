var utils = {
	resolve: function(path, obj, safe) {
		if(path == ''){ return obj }
		return path.split('.').reduce(function(prev, curr) {
			return !safe ? prev[curr] : (prev ? prev[curr] : undefined)
		}, obj || self)
	},
	assign: function(obj, keyPath, value) {
		lastKeyIndex = keyPath.length-1;
		for (var i = 0; i < lastKeyIndex; ++ i) {
			key = keyPath[i];
			if (!(key in obj))
				obj[key] = {}
			obj = obj[key];
		}
		obj[keyPath[lastKeyIndex]] = value;
	}
}

module.exports = utils
