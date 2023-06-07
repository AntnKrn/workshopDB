document.getElementById('search').addEventListener('input', () => {
    let val = this.document.getElementById('search').value.toUpperCase();
    let trs = document.getElementsByClassName('elastic');
    Array.from(trs).forEach((el) => {
        if(el.cells[1].textContent.toUpperCase().search(val) === -1){
            el.classList.add('hide');
        }
        else {
            el.classList.remove('hide');
        }
    });
});