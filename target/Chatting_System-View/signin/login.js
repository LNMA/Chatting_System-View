function signInvalidateForm() {
    'use strict';
    var username = document.forms['signInform']['username'].value;
    var password = document.forms['signInform']['password'].value;
    if ((username === '') || (password === '')) {
        document.getElementById('topAlert').innerHTML = '   <div class=\"container\">\n' +
            '        <div class=\"alert alert-danger alert-dismissible\" data-dismiss=\"alert\" id=\"myAlert\">\n' +
            '            <button type=\"button\" class=\"close\">&times;</button>\n' +
            '            <strong>Error!</strong> Username or password seem wrong, try again.\n' +
            '        </div>\n' +
            '    </div>';
        return false;
    }
}