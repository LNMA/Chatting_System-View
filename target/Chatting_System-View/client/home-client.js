$(document).on('click', '#inputStringPost', function () {
    'use strict';
    var post = '<form class=\"form-group\">' +
        '                        <textarea class=\"form-control\" data-toggle=\"collapse\"  placeholder=\"What\'s in your mind?\"></textarea>' +
        '                        <button class=\"btn btn-primary mt-2 col-md-1\" type=\"submit\" name=\"post\" value=\"Post\">Post</button>' +
        '                    </form>' +
        '                </div>';

    $('#addPost').removeAttr('hidden');
    $('#addPost').show();
    $(document.body).find('#addPost').html('');
    $(document.body).find('#addPost').html(post);
});

$(document).on('dblclick', '#inputStringPost', function () {
    'use strict';
    $('#addPost').hide();
});

$(document).on('click', '#inputImg', function () {
    'use strict';
    var post = '<form class=\"form-group\">\n' +
        '                        <div class=\"custom-file\">\n' +
        '                            <input type=\"file\" class=\"custom-file-input\" id=\"filename\" name=\"filename\">\n' +
        '                            <label class=\"custom-file-label\" for=\"filename\">Choose file...</label>' +
        '                        </div>\n' +
        '                        <script>\n' +
        '                            // Add the following code if you want the name of the file appear on select \n' +
        '                            $(\".custom-file-input\").on(\"change\", function() { \n' +
        '                                var fileName = $(this).val().split(\"\\\\").pop(); \n' +
        '                                $(this).siblings(\".custom-file-label\").addClass(\"selected\").html(fileName); \n' +
        '                            }); \n' +
        '                        </script>\n' +
        '                        <button class=\"btn btn-primary mt-2 col-md-1\" type=\"submit\" value=\"post\" name=\"post\">Post</button>\n' +
        '                    </form>\n';

    $('#addPost').removeAttr('hidden');
    $('#addPost').show();
    $(document.body).find('#addPost').html('');
    $(document.body).find('#addPost').html(post);
});

$(document).on('dblclick', '#inputImg', function () {
    'use strict';
    $('#addPost').hide();
});