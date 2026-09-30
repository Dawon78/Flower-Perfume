
function togglePaymentForm() {
    const cardPayment = document.getElementById('card');
    const paymentForm = document.getElementById('payment-form');
    paymentForm.style.display = cardPayment.checked ? 'flex' : 'none';
}
window.onload = togglePaymentForm;


