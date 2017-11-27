var step = 1;

function check(step) {
    if(step == 1){
        document.getElementById('part-1').style.display='block';
        document.getElementById('part-2').style.display='none';
        document.getElementById('part-3').style.display='none';
    }else{
        if (step == 2){
            document.getElementById('part-1').style.display='none';
            document.getElementById('part-2').style.display='block';
            document.getElementById('part-3').style.display='none';
        } else if (step == 3){
            document.getElementById('part-1').style.display='none';
            document.getElementById('part-2').style.display='none';
            document.getElementById('part-3').style.display='block';
        }
    }
}

function increase() {
    step++;
    check(step);
}

function decrease() {
    step--;
    check(step);
}

check(step);