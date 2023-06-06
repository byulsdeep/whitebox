<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
    </head>
    <body>
        <!-- Replace "test" with your own sandbox Business account app client ID -->
        <script src="https://www.paypal.com/sdk/js?client-id=test&currency=JPY"></script>
        <!-- Set up a container element for the button -->
        <div id="paypal-button-container"></div>
        <script>
            let cartInfo;
            if ('${cartInfo}' !== '') {
                cartInfo = JSON.parse('${cartInfo}');
            }
            console.log('cartInfo: ');
            console.log(cartInfo);
            
            paypal
                .Buttons({
                    // Order is created on the server and the order id is returned
                    createOrder() {
                        return fetch('/member/createPayPalOrder', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            // use the "body" param to optionally pass additional order information
                            // like product skus and quantities
                            body: JSON.stringify(cartInfo),
                        })
                            .then(response => response.json())
                            .then(order => order.id);
                    },
                    // Finalize the transaction on the server after payer approval
                    onApprove(data) {
                        return fetch('/member/capturePayPalOrder', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({
                                orderID: data.orderID,
                            }),
                        })
                            .then(response => response.json())
                            .then(orderData => {
                                // Successful capture! For dev/demo purposes:
                                console.log('Capture result', orderData, JSON.stringify(orderData, null, 2));
                                // const transaction = orderData.purchase_units[0].payments.captures[0];
                                window.location.href = '/member/orderSuccess';
                            });
                    },
                })
                .render('#paypal-button-container');
        </script>
    </body>
</html>
