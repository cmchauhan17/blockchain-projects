function generatePDF(){
    const element = document.getElementById("pf1");

    html2pdf()
    .from(element)
    .save();
}

