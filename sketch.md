# MExiCo - David's sketch, Peter's comments

__David:__ Let's assume the structure of the data directory is:

````
my_corpus/
  manifest.txt
  run1/
    r1.xio
    r1.wav
    r1_t.mp4
    r1_a.mp4
    r1_b.mp4
  etc..
````

__Peter:__ How this is implemented in MExiCo:

````
root_folder/   –  indicates the name of the corpus
  Corpus.xml   –  the „manifest“ file
  cache/       –  folder for caching remote resources (will be implemented later)
  subfolders/  -  contain resources, can have arbitrary names and structures
````

__David:__ Where the file "manifest.txt" in the base directory contains something like (syntax doesn't matter for now, something structured and easily machine-readable, of course, so XML or probably better JSON):

````
cname: the great corpus
cinfo: bla bla bla

mdocs
  mdoc: r1
  consists: [("run1/r1.xio", xio, "xio", "tracking streams"),
             ("run1/r1.wav", audio, "rec", "stereo audio"),
             ("r1_t.mp4", video, "vs", "video, side view"),
             ("r1_a.mp4", video, "va", "video, participant A"),
             ("r1.TextGrid", textgrid, "trns", "transcript"),   etc. etc.]
````

__Peter:__ In MExiCo it’s an XML file containing corpus metadata (creator, type, modalities, ...), information about corpus setup (designs and trials) and entries describing the resources.

````xml
<?xml version="1.0"?>
<Corpus identifier="mexico" name="Mexico Corpus">
  <Description>This is an example corpus, with the uttered word "Mexico".</Description>
  <Participants>
    <Participant identifier="subject" name="Subject" participant_role_id="naive"/>
  </Participants>
  <Designs>
    <Design identifier="mexico-design" name="Mexico Design">
      <DesignComponent identifier="dc-audio" name="Audio" />
      <DesignComponent identifier="dc-phonetic-transcription" name="Phonetic Transcription"/>
      <DesignComponent identifier="dc-syllables" name="Syllables" />
    </Design>
  </Designs>
  <Trials>
    <Trial identifier="mexico-trial" name="Mexico Trial" cue="mexico" runningnumber="1" design_id="mexico-design"/>
  </Trials>
  <Resources>
    <Resource identifier="mexico-audio" name="mexico.wav" media_type_id="audio">
      <Description>WAVE audio recording</Description>
      <LocalFile identifier="mexico-audio-wav" name="Mexico audio, WAV" path="./resources/mexico.wav"/>
    </Resource>
    <Resource identifier="mexico-transcription-file" name="Mexico transcription File" media_type_id="annotation">
      <Description>Transcription File, containing all transcription tiers</Description>
      <LocalFile identifier="mexico-transcription-textgrid" name="Mexico Transcription File, Praat TextGrid" path="./resources/mexico.TextGrid"/>
      <LocalFile identifier="mexico-transcription-shorttextgrid" name="Mexico Transcription File, Praat ShortTextGrid" path="./resources/mexico.ShortTextGrid"/>
      <LocalFile identifier="mexico-transcription-toe" name="Mexico Transcription File, ToE document" path="./resources/mexico.toe"/>
    </Resource>
  </Resources>
</Corpus>
````

__David:__ So the idea is that this manifest file explains the structure of the data: which files belong to one run (from now on, I will call this one "multimodal document" or "mdoc", to be a bit more general), and what the types are of this file.

__Peter:__ Nomenclature: the „runs“ are called trials in MExiCo, and they can have a kind of template or schema, called design (describing what numbers and types of resources should be associated with a single trial.

__David:__ So the members of "consists" are tupels of:
-  a path,
-	a file type descriptor (which must be something known to the package, see below)
-	a short textual id of the component,
-	and for convenience an info string intended only for human consumption.

__Peter:__ In MExiCo, these items are called resources. They describe a single item, usually represented in a file. They can refer to one or more local files (if multiple files, they must have equivalent contents, e.g., different video file formats of the same recording, or annotations in different file formats), and to one or more URLs (with additional information, like whether the resource can be downloaded or is only described at the URL, etc.).

Resources have a MediaType (so do DesignComponents). At the moment, MediaTypes are (1) video, (2) audio, (3) annotation. In the future, additional ones will be implemented (image, data grid, text).

__David:__ Now, from within our package you can then do something like this:

````python
mcorp = MmodCorpusReader('my_corp/manifest.txt')
````
__Peter:__ In MExiCo, its

````ruby
c = Mexico::FileSystem::Corpus.open('my_corp')
````

or

````ruby
c = Mexico::FileSystem::Corpus.open('my_corp/Corpus.xml')
````

or, on the shell / console:

````bash
$ mexico open my_corp
````

__David:__ This gives you a new object of type MmodCorpusReader (obviously, this is something that we need to define).

__Peter:__ c is an object of type Corpus. This class represents the bundled resources inside the corpus folder, as well as additional info about the experimental design, trials, etc. There will be multiple implementations of Corpus (and related classes) in different modules:

1. `FileSystem` – allowing access to a Corpus on the local file system, this is what we are working on at the moment.
2. `Database` – allowing access to a Corpus that is stored inside a relational database, this will be used inside the next major version of the Phoibos web application
3. `HTTP` – allowing access to a Corpus via methods of an HTTP API, this will act as the client-side complement to the data coming from Phoibos of similar web applications or services.

__David:__ There are some convenience methods that come with this object. E.g.

```python
mcorp.docids()
```

gives you a list of all the mdocs described in the manifest file. Here, e.g. `['r1', 'r2', ... ]`

```python
mcorp.info()
```

gives you the info string from `cname` and `cinfo`. Etc.

The more interesting method then is `mdocs()`, which returns a list of objects of type `mdoc`, one for each `mdoc` in the corpus. (Variants: `mcorp.mdocs('r1')` gives you a particular single one, `mcorp.mdocs(['r1', 'r2']) gives you all named in the list, etc.)

__Peter:__ The corpus class has collections of all components, also for resources.

```ruby
c.resources 
```

returns an array of `Resource` objects

```ruby
c.trials[0].resources
```

returns array of the resource objects linked to the first trial. Single resource objects can also be fetched by their numeric index or by their identifier.

__David:__ The real work then finally is done by this object. Lets say we have a particular `mdoc` in `md` (e.g., by doing `md = mcorp.mdocs('r1')` ). We can then get some information about this multimodal document via

```python
md.info()
```

returns 

```
name: r1
consists: [(ID, String), ..]
```

Finally, something like

```python
md.get('xio')
```

returns an object of the appropriate type. Which type, and how was it created? That was determined when the manifest file was loaded by `MmodCorpusReader`. The type descriptor in the consists entry determines how this part of the multimodal document is loaded, and consequently what type of object is created by loading it. So the type "xio" requires a loader for xio-files, the type "textgrid" one for TextGrids, and so on.

[Why not `md.xio()` to get at the xio-data, and `md.sound()` to get at the sound, etc.? That's what I thought first, but now I believe that using a generic `get()` would be more general, as it makes no assumptions about what types of data are there in each `mdoc`, and in particular, as it allows to have several components of the same type, as for the video.]

If we say

```python
xio = md.get('xio')
```

we have an object of type xio (or probably just a pandas data frame datastructure? maybe better do our own subclass of that, so that it can come with its own methods).

The textgrid object probably needs more internal structure: a textgrid consists of at least one tier, which can be of type "interval" or "point", and each tier consist of at least one interval or point (depending on type); all of which should be proper python types.

So let's say we access one textgrid object via:

```python
tg = md.get('trns')
```

[And this is actually where we can start for now. So for now we can just write the TextGrid reader, that creates an object with the characteristics that will be described below.]

We'd then like to be able to do:

+ `tg.info()`  : get list of names & types of all tiers
+ `tg.tiers()` : get list of objects of type Tier (with variants for named access)

So

```python
t1 = tg.tiers()[0]
```

would give us the first tier of the textgrid.

__Peter:__ In MExiCo, you retrieve a `Resource` from a `Corpus`, and then query it for a `Layer` object inside the resource's document.

```ruby
r = corpus.resources[0]
l = r.document.layers[0]
```

And now finally we can get to the data:

```python
t1.cont()
```

would give us a list of objects of the appropriate type (either intervals or points), chronologically ordered by start time. (That's actually guaranteed by the TextGrid format.)

__Peter:__ In MExiCo, you access those via the `Item` class. There are accessor methods for all items in a document, or for all items in a layer.

```ruby
document.items
layer.items
```

Those are arrays, so methods like `size` or `[]` can be used.

__David:__ `cont()` needs to take an optional parameter that determines which intervals to ignore. Our convention is to leave non-speech intervals empty (no text), but others may do this differently.

__Peter:__ We plan to integrate more elaborate flags like this into the `filter()` methods that can be used for searching.

__David:__ So finally:

```python
i1 = t1.cont()[0]
```

+ `i1.start` then is the start time,
+ `i1.end`   is the end time, and
+ `i1.text`  is the text / the transcription.

__Peter:__ In MExiCo:

+ `i1.min`  retrieves the "start time" = the lower border of the first linked interval, if present
+ `i1.min`  retrieves the "end time" = the end border of the first linked interval, if present
+ `i1.data` retrieves the annotation value(s). In MExiCo there can be different data types inside, 

__David:__ In MExiCo:So far, all this was stuff that gives us access separately to each different component. There should also be some methods that are implemented for all types. At the very least, we should have something like `find()`.

On Tier objects:

`t1.find(START, END)` : return list of tupels of (relation, interval-object) that overlap with interval from START to END.
     relation can be:
     - loverlap:   object starts before START, ends within START and END
     - included:   object starts after START and ends before END
     - includes:   object starts before START and ends after END
     - strict:     object goes exactly from START to END
     - roverlap:   object starts after START and before END and ends after END.

(Actually, there should probably be a variant which takes one object, and gets the start and end info from that object. So that you can say t1.find(i10), which finds you all objects on tier t1 that overlap with i10 (which could be an utterance from another tier.)

__Peter:__ As I said above, all the `find()` stuff, though being on the agenda, 
is not implemented yet. Our plans are to make it rather flexible and elaborate, including things like overlap relations, calculate overlap similarity, and so on.

__David:__ When applied to xios, `find()` should probably just return one tupel (as for xios, being timepoint-based, it makes no sense to assume that something loverlaps for example), so

```python
x1.find(START, END)
```

will return
```python
[(strict, x2)]
```

where `x2` is also an object of type xio, just only containing the rows from START to END.

There is one issue here that I haven't thought through yet: the timing information in the TextGrid is relative to a 0-point, whereas the time info in the xio data is an absolute timestamp. So somewhere (in the manifest file) we need to record what the translation is (so which timestamp corresponds to the 0 in the TextGrid, and the video and audio), and ideally, this would be transparent from within the analysis environment as well. (Probably easiest would be to translate the xio timestamps into something like "ms from 0", since it is unlikely that we will be interested in the actual real-world times during the analysis, I guess?)

__Peter:__ In MExiCo, we plan support for transformations between different time axes (timepoints, frames, etc.) and between units (e.g., ms to s, s to PAL-Frames, etc.). Resources and Files will carry information about what axes (called `Scales` in the MExiCo universe) are there, and how scales and units can be converted into each other.
