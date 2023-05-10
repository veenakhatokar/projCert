FROM devopsedu/webapp 
ADD proj /website
RUN rm /website/index.php
CMD apachectl -D FOREGROUND
