
`r if (knitr::is_latex_output()) '<!--'`
# JetFighter
`r if (knitr::is_latex_output()) '-->'`

`r if (knitr::is_html_output()) '<!--'`
# JetFighter: Towards figure accuracy and accessibility
`r if (knitr::is_html_output()) '-->'`


### Citation

A version of this chapter was published on as part of the eLife Labs series:

Shyam Saladi with editorial assistance from Emmy Tsang.
JetFighter screens preprints to improve data representation and
colour-blind accessibility.
[Labs](https://elifesciences.org/labs). Apr 4, 2019


## Towards figure accuracy and accessibility {.unlisted}

Figures are the crux of every science story.

Data, the collections of numbers and facts at the centre of most
research, need to be analysed and visualised to be understood. Human
beings are visual creatures: our eyes are attracted to colours, and we
have evolved to easily spot trends and patterns. By turning data into
graphs and charts, visualisation tools and techniques help scientists
develop intuition for and draw conclusions about the system at study.

To see numerical relationships, we rely on colour maps to transform
variation in numbers to variation in colours. Constructing a colour map
is hard since our eyes and visual systems perform complex, non-linear
operations (e.g. we are more sensitive to contrasts in the orange-red
part of the light). Jet is a colour map that spans the rainbow by
linearly interpolating red, green and blue. Despite its popularity, Jet
introduces well-established visual artefacts and produces figures
inaccessible to our colleagues with colourblindness (for an overview,
see [Borland & Taylor, 2007](https://doi.org/10.1109/MCG.2007.323435)).
Regardless of its obvious downsides, Jet is the most widely used colour
map in the sciences.

Arising out of a friendly challenge to email every author that has
published a paper with a figure using Jet, JetFighter is a
proof-of-concept app to enable the community to improve visualisation.

![
JetFighter shows the detection statuses of recent articles in a paginated table with per-page thumbnails expandable into view.
](`r getwd()`/ch30_color/figs/ch30_pt40_overview.png){
#fig:overview short-caption="A screenshot of the table of papers and their detection status."
}


>  [Launch JetFighter](https://jetfighter.ecrlife.org/)

JetFighter screens each manuscript posted on bioRxiv to infer which, if
any, colour maps were used in creating the image(s) on each page of the
document. If a rainbow colour map is detected, potentially problematic
pages of the manuscript are flagged in a message sent to the authors,
suggesting improvements to their work.

Technically, new manuscripts are identified by monitoring the bioRxiv
Twitter feed ([tweepy](http://www.tweepy.org/);
[code](https://github.com/smsaladi/jetfighter/blob/164ea30a6d0500e6f62be58fadfd7a16456b2de6/webapp.py#L351-L357))
on a daily basis. Initially, finding a way to keep up with new preprints
was a challenge: parsing the bioRxiv Twitter feed proves simpler than
monitoring the bioRxiv RSS feed, as the Twitter feed has a longer
accessible history and a simpler, pre-built Python interface.

After the manuscript PDF is downloaded, each page is converted into an
image. This was initially done on the fly
([poppler](https://poppler.freedesktop.org/);
[code](https://github.com/smsaladi/jetfighter/blob/dd94d67854892175072d9b333b28c2fa8dfac58a/detect_cmap.py#L50)),
but it saddled the web server with a considerable workload. Paul
Shannon, eLife's Head of Technology, suggested the International Image
Interoperability Framework, which [eLife uses to serve
images](https://elifesciences.org/labs/d6044799/dynamically-serving-scientific-images-using-iiif)
and decouples image handling from the rest of the web application.
JetFighter uses
[Cantaloupe](https://medusa-project.github.io/cantaloupe/), which
handles PDF sources out-of-the-box and has multiple levels of caching to
reduce server load.

Next, the image is read and an array of RGB values for each pixel is
generated ([scikit-image](https://scikit-image.org/);
[code](https://github.com/smsaladi/jetfighter/blob/164ea30a6d0500e6f62be58fadfd7a16456b2de6/detect_cmap.py#L245-L255)).
It is transformed into a perceptually uniform colour space
([colorspacious](https://colorspacious.readthedocs.io/en/latest/);
[code](https://github.com/smsaladi/jetfighter/blob/dd94d67854892175072d9b333b28c2fa8dfac58a/detect_cmap.py#L136-L144)),
and then compared in composition to a set of colour maps by generating
k-d trees ([matplotlib](https://matplotlib.org/) and
[scikit-learn](https://scikit-learn.org/);
[code](https://github.com/smsaladi/jetfighter/blob/dd94d67854892175072d9b333b28c2fa8dfac58a/detect_cmap.py#L89-L128)).
The per cent coverage of problematic rainbow colour maps like Jet is
recorded in the database flagging certain manuscripts
([code](https://github.com/smsaladi/jetfighter/blob/dd94d67854892175072d9b333b28c2fa8dfac58a/detect_cmap.py#L165-L175)).
This process takes seconds per page in a compute queue
([redis](https://redis.io/), [python-rq](http://python-rq.org/);
[code](https://github.com/smsaladi/jetfighter/blob/164ea30a6d0500e6f62be58fadfd7a16456b2de6/webapp.py#L360-L384)).
Continuous integration (Travis CI: not open-source;
[code](https://github.com/smsaladi/jetfighter/blob/164ea30a6d0500e6f62be58fadfd7a16456b2de6/webapp.py#L400-L421))
helps to avoid inadvertently introducing bugs in continued development.

> [JetFighter Source Code](https://github.com/smsaladi/jetfighter)

A web frontend shows the screening status of each manuscript
([flask](http://flask.pocoo.org/) ecosystem,
[jquery](https://jquery.com/), [datatables](https://datatables.net/))
and, via an authenticated interface, allows the results of detections to
be confirmed before an email is sent to the manuscript authors
([template](https://github.com/smsaladi/jetfighter/blob/dd94d67854892175072d9b333b28c2fa8dfac58a/templates/email_notification.txt),
sendgrid: not open-source). This avoids bothering authors with false
positive detections and allows me to gather a feel for the types of
figures being detected.

![
The colour maps inferred for the manuscript help highlight if/why a rainbow colour map was detected.
](`r getwd()`/ch30_color/figs/ch30_pt40_detailed.png){
#fig:detail short-caption="A screenshot of the detailed view for a single paper."
}


In retrospect, strictly false positive detections are rare (less than
1%), but some categories of images would be better served by a more
customised email message. For example, fluorescence images that often
use the red and green channels (of RGB images) to show opposing
fluorophores (e.g. GFP and RFP) are also flagged by JetFighter. These
images are inaccessible to readers with red-green colourblindness. A
tailored message suggesting the best practice of magenta instead of red
would be more helpful to the authors.

So far, around 15,000 manuscripts have been screened, and 1,900
manuscripts with rainbow colour maps or red-green inaccessible images
were detected. In the last month alone, 142 emails have been sent out to
authors concerning their colour-map usage, to positive responses.

> Thank you for creating this system of automatic detection in
> preprints! I wasn\'t aware of the disadvantages of the jet colour map.
> I have changed my figure with the parula colour map before
> re-submitting the article.
>
> -- A preprint author

### A call for contribution {.unlisted .unnumbered}

In the short term, extending JetFighter's capabilities to screen
preprints from other platforms and to send more tailored messages would
be wonderful. More broadly, I hope that others will be inspired by the
concept of screening literature to help authors improve their work.
Remarkably, the JetFighter experiment suggests that emails to authors
don't go ignored. Future tools can explore other feedback channels, from
public communication -- including posting a comment or responding to a
tweet -- to more refined messages and directly interfacing with
manuscript-management platforms.

![
Amongst various popular colour maps,
Viridis and Magma do the best at perceptual uniformity and are robust to colourblindness
([image source](https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html)).
](`r getwd()`/ch30_color/figs/ch30_pt40_colormaps.png){
#fig:colormaps short-caption="Examples of Viridis and Magma being excellent choices over rainbow colormaps like Jet."
}


With beautiful alternative colour maps like Viridis, I urge scientists
to rethink the way they portray their data. Those passionate about this
issue could work with experts to compose editorials to suggest changing
the standard for common field-specific visualisations, such as flow
cytometry scatter plots and brain imaging. Until then, JetFighter will
continue to send messages and push for change.

