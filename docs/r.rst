Redirection
-----------

This page exists for redirection purposes only.

..
   Include a named paragraph in the page, where the javascript code below will
   place any message.

.. raw:: html

   <p><strong id="successmessage">
     You will be redirected to your target page in a few seconds.
   </strong></p>

..
   use a custom role to identify redirect codes so that a bit of JS can find
   them again

.. role:: redirect
   :class: redirect

If you continue to see this page, you've ended up in here accidentally and redirection
failed -- sorry about this.

**Here are some links that may take you to where you need to go:**

..
   This defines a mapping of redirect codes to their present URLs.
   Please keep sorted by redirection label.

:redirect:`openneuro`
  :ref:`openNeuro`

Alternatively, try searching in the "Quick Search" at the left-hand side, or
scan the handbook's front page at `brainhack-princeton.github.io/handbook <https://brainhack-princeton.github.io/handbook/>`_ for directions.

..
   This code replaces the r.html?key part with the final URL, while keeping
   the rest of URL intact.

.. raw:: html

   <script>
   // take everything after "?" as a code to identify the redirect
   redirect_code = window.location.href.replace(/.*\?/, "");
   success = false;
   // loop over all redirect definitions (see above)
   for (rd of document.getElementsByClassName('redirect')){
     if (rd.innerText != redirect_code) {continue;}
     // read the href from the link in the <dd> matching the <dt> of the redirect
     // this assumes a very simple, and particular structure
     // let's hope that sphinx doesn't break it
     target = rd.parentElement.nextElementSibling.getElementsByTagName("a")[0].href;
     // and jump
     window.location.replace(target);
     success = true;
     break;
   }
   // if we get here, we didn't find a match
   if (success == false) {
     document.getElementById("successmessage"
       ).innerHTML = "Whoops - redirection went wrong, we are lost!"
   }
   </script>
