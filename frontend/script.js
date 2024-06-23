document.getElementById('dataForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const value1 = document.getElementById('value1').value;
    const value2 = document.getElementById('value2').value;

    if (!value1 || !value2) {
        alert('Both values are required!');
        return;
    }

<<<<<<< HEAD
    fetch('http://34.71.199.89:5000/submit', {
=======
    fetch('http://35.238.201.192:5000/submit', {
>>>>>>> 7529e2aa1f199b5c6f20bb9f605c915f2f5684a9
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
