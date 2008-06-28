

function habilita_input() {
    document.getElementById('soprano').disabled = false;
    document.getElementById('alto').disabled = false;
    document.getElementById('tenor').disabled = false;
    document.getElementById('bass').disabled = false;
    document.getElementById('chorale').disabled = true;
}

function habilita_chor() {
    document.getElementById('soprano').disabled = true;
    document.getElementById('alto').disabled = true;
    document.getElementById('tenor').disabled = true;
    document.getElementById('bass').disabled = true;
    document.getElementById('chorale').disabled = false;
}

function toggle_visible(el) {
    if (el.style.display == "block")
        el.style.display = "none";
    else
        el.style.display = "block";
     
}
