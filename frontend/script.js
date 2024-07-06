document.getElementById('dataForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const value1 = document.getElementById('value1').value;
    const value2 = document.getElementById('value2').value;

    if (!value1 || !value2) {
        alert('Both values are required!');
        return;
    }

    fetch('http://35.188.107.166:5000/submit', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ value1, value2 })
    })
    .then(response => response.json())
    .then(data => {
        console.log(data);
        if (data.message) {
            alert(data.message);
        } else if (data.error) {
            alert(data.error);
        }
    })
    .catch(error => console.error('Error:', error));
});
