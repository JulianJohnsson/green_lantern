$(document).ready(function(){
  var publishableKey = document.querySelector("meta[name='stripe-key']").content;
  var stripe = Stripe(publishableKey);

  var elements = stripe.elements({
    fonts: [{
      cssSrc: "https://rsms.me/inter/inter-ui.css"
    }],
    locale: "auto"
  });

  var style = {
    base: {
      color: "#32325d",
      fontWeight: 500,
      fontFamily: "Inter UI, Open Sans, Segoe UI, sans-serif",
      fontSize: "16px",
      fontSmoothing: "antialiased",

      "::placeholder": {
        color: "#CFD7DF"
      }
    },
    invalid: {
      color: "#E25950"
    }
  };

  var card = elements.create('card', { style });

  card.mount("#card-element");

  card.addEventListener('change', ( {error} ) => {
    var displayError = document.getElementById('card-errors');
    if(error) {
      displayError.textContent = error.message;
    } else {
      displayError.textContent = "";
    }
  });

  var form = document.getElementById('payment-form');

  form.addEventListener('submit', async(event) => {
    event.preventDefault();

    var { token, error } = await stripe.createToken(card);

    if (error) {
      var errorElement = document.getElementById('card-errors');
      errorElement.textContent = error.message;
    } else {
      stripeTokenHandler(token);
    }
  });


  var stripeTokenHandler = (token) => {
    var form = document.getElementById('payment-form');
    var hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'stripeToken');
    hiddenInput.setAttribute('value', token.id);
    form.appendChild(hiddenInput);

    ["type", "last4", "exp_month", "exp_year"].forEach(function(field) {
      addCardField(form, token, field);
    });

    form.submit();
  }

  function addCardField(form, token, field) {
    let hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', "user[card_" + field + "]");
    hiddenInput.setAttribute('value', token.card[field]);
    form.appendChild(hiddenInput);
  }
});
