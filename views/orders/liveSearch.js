document.querySelectorAll('td.date').forEach(e => {
    let date = new Date(e.textContent);
    let year = date.toLocaleString("default", { year: "numeric" });
    let month = date.toLocaleString("default", { month: "2-digit" });
    let day = date.toLocaleString("default", { day: "2-digit" });
    e.textContent = `${year}-${month}-${day}`;
});

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