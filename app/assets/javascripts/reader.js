var ready;
ready = function() {
	var fileInput = document.getElementById('fileInput');
	var fileDisplayArea = document.getElementById('fileDisplayArea');
	fileInput.addEventListener('change', function(e) {
		var file = fileInput.files[0];
		var textType = /text.*/;
		if (file.type.match(textType)) {
			var reader = new FileReader();
			reader.onload = function(e) {
				//fileDisplayArea.innerText = reader.result;
				updateText(reader.result);
			}
			reader.readAsText(file);
		} else {
			fileDisplayArea.innerText = "File not supported!";
		}
	});

	function updateText(text) {
		document.getElementById("populate").value = text;
	}
}
$(document).ready(ready);
$(document).on('page:load', ready);