
function habilita_text() {
    document.getElementById('lily').disabled = false;
    document.getElementById('chorale').disabled = true;
}

function habilita_chor() {
    document.getElementById('lily').disabled = true;
    document.getElementById('chorale').disabled = false;
}

function toggle_visible(el) {
    if (el.style.display == "block")
        el.style.display = "none";
    else
        el.style.display = "block";
     
}
