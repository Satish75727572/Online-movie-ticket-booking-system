/* ============================================
   BookMyShow Clone — Client-Side Logic
   ============================================ */

// --- Seat Selection Logic ---
document.addEventListener('DOMContentLoaded', function() {

    // Seat toggle
    const seatContainer = document.getElementById('seatMap');
    if (seatContainer) {
        initSeatSelection();
    }

    // Date picker
    const datePicker = document.querySelectorAll('.date-card');
    datePicker.forEach(card => {
        card.addEventListener('click', function() {
            datePicker.forEach(c => c.classList.remove('active'));
            this.classList.add('active');

            // Update hidden input if a time is already selected
            const activeTimeBtn = document.querySelector('.showtime-btn.active');
            const hiddenInput = document.getElementById('selectedTime');
            if (activeTimeBtn && hiddenInput && this.dataset.date) {
                hiddenInput.value = this.dataset.date + " " + activeTimeBtn.dataset.time;
            }
        });
    });

    // Showtime picker
    const showtimeBtns = document.querySelectorAll('.showtime-btn');
    showtimeBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            showtimeBtns.forEach(b => b.classList.remove('active'));
            this.classList.add('active');
            
            const activeDateCard = document.querySelector('.date-card.active');
            let dateStr = '';
            if (activeDateCard && activeDateCard.dataset.date) {
                dateStr = activeDateCard.dataset.date + " ";
            }

            const hiddenInput = document.getElementById('selectedTime');
            if (hiddenInput) {
                hiddenInput.value = dateStr + this.dataset.time;
            }
        });
    });

    // Payment method toggle
    const paymentMethods = document.querySelectorAll('.payment-method');
    paymentMethods.forEach(m => {
        m.addEventListener('click', function() {
            paymentMethods.forEach(pm => pm.classList.remove('active'));
            this.classList.add('active');
        });
    });

    // Hero carousel (simple auto-rotate text)
    const heroTexts = ['🎬 Book Your Favorite Movies', '🎶 Live Events & Concerts', '🎭 Plays & Comedy Shows'];
    const heroSubtitle = document.getElementById('heroSubtitle');
    if (heroSubtitle) {
        let idx = 0;
        setInterval(() => {
            idx = (idx + 1) % heroTexts.length;
            heroSubtitle.style.opacity = 0;
            setTimeout(() => {
                heroSubtitle.textContent = heroTexts[idx];
                heroSubtitle.style.opacity = 1;
            }, 300);
        }, 3000);
    }
});

// Seat selection state
let selectedSeats = [];
let pricePerSeat = 0;

function initSeatSelection() {
    const seats = document.querySelectorAll('.seat.available');
    const summaryBar = document.querySelector('.summary-bar');
    const priceEl = document.getElementById('seatPrice');
    if (priceEl) pricePerSeat = parseInt(priceEl.value) || 200;

    seats.forEach(seat => {
        seat.addEventListener('click', function() {
            const seatId = this.dataset.seat;

            if (this.classList.contains('selected')) {
                this.classList.remove('selected');
                this.classList.add('available');
                selectedSeats = selectedSeats.filter(s => s !== seatId);
            } else {
                this.classList.remove('available');
                this.classList.add('selected');
                selectedSeats.push(seatId);
            }

            updateSummaryBar();
        });
    });
}

function updateSummaryBar() {
    const bar = document.querySelector('.summary-bar');
    const countEl = document.getElementById('selectedCount');
    const totalEl = document.getElementById('selectedTotal');
    const seatsInput = document.getElementById('selectedSeats');
    const countInput = document.getElementById('seatCount');

    const total = selectedSeats.length * pricePerSeat;

    if (countEl) countEl.textContent = selectedSeats.length;
    if (totalEl) totalEl.textContent = total;
    if (seatsInput) seatsInput.value = selectedSeats.join(', ');
    if (countInput) countInput.value = selectedSeats.length;

    if (bar) {
        if (selectedSeats.length > 0) {
            bar.classList.add('visible');
        } else {
            bar.classList.remove('visible');
        }
    }
}

// Form validation helper
function validateForm(formId) {
    const form = document.getElementById(formId);
    if (!form) return true;

    const inputs = form.querySelectorAll('[required]');
    let valid = true;

    inputs.forEach(input => {
        if (!input.value.trim()) {
            input.style.borderColor = '#F84464';
            valid = false;
        } else {
            input.style.borderColor = '#E0E0E0';
        }
    });

    return valid;
}
