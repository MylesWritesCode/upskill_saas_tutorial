/* global $, Stripe */

// Document ready
$(document).on('turbolinks:load', function(){
    var theForm = $('#pro_form');
    var submitBtn = $('#form-submit-btn');
    
    // Set Stripe public key
    Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
    // When user clicks form submit button, prevent default submission behavior.
    submitBtn.click(function(){
        // Prevents default behavior
        event.preventDefault();
        submitBtn.val("Processing").prop('disabled', true);
        
        // Collect credit card fields
        var ccNum = $('#card_number').val(),
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();    
            
        // Use Stripe js lib to check for card errors
        var error = false;
        // Validate card number
        if(!Stripe.card.validateCardNumber(ccNum)){
            error = true;
            alert('The credit card number appears to be invalid.');
        }
        // Validate CVC
        if(!Stripe.card.validateCVC(cvcNum)){
            error = true;
            alert('The CVC number appears to be invalid.');
        }
        // Validate expiration date
        if(!Stripe.card.validateExpiry(expMonth, expYear)){
            error = true;
            alert('The expiration date appears to be invalid.');
        }
        
        if(error) {
            submitBtn.val("Sign Up").prop('disabled', false)
        } else {
            // Send card information to Stripe
            Stripe.createToken({
                number: ccNum,
                cvc: cvcNum,
                exp_month: expMonth,
                exp_year: expYear
            }, stripeResponseHandler);
        }
        return false;
    });
    // Stripe will return back card token
    function stripeResponseHandler(status, response) {
        // Get the token from the response.
        var token = response.id;
        
        // Inject card token as hidden field into form
        theForm.append( $('<input type="hidden" name"user[stripe_card_token]">').val(token) );
        
        // Submit form to Rails app
        theForm.get(0).submit();
    }
});