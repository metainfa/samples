<flickr-image-list>
    <div class="flickr-image-list">
        <button name="addImagesBtn" class="refresh" onclick="{ loadImagesFromFlickr }">Add images</button>
        <button class="download" onclick="{ downloadResults }">Download results</button>

        <div class="flickr-image" each="{ images }">
            <h1>{title}</h1>
            <div class="flickr-image-container">
                <img src="{imgUrl}" />
            </div>
            <h2>{ownerName} - {license}</h2>
            <h3>{fromNow}</h3>
            <a href="{flickrUrl}">{flickrUrl}</a>
        </div>
    </div>

    <script>

    this.images = [];

    var self = this;
    var searchIndex = 0;
    var searchTerms = ['tree', 'water', 'fire', 'earth', 'metal', 'wood',
        'blue', 'red', 'yellow', 'mountain', 'tunnel', 'train', 'brick',
        'architecture'];

    var results = [];
    var lastStartDrawTime = 0;
    var lastJSStartExecutionTime = 0;
    var startDrawTime;
    var jsExecutionTime;

    loadImagesFromFlickr(el) {
        this.addImagesBtn.disabled = true;

        flickr.search(searchTerms[searchIndex], 100)
            .then(function(res){self.updateImages(res)});

        searchIndex++;
        searchIndex %= searchTerms.length;

    }

    updateImages(list) {
        self.images = self.images.concat(list);

        // Take a timestamp.
        startDrawTime = window.performance.now();
        jSStartExecutionTime = window.performance.now();
        console.time("Riot Execution");

        // Go!
        self.update();

        // End
        console.timeEnd("Riot Execution");
        self.onNextFrameDone(self.images.length);

        // Re-enable 'Add Images' button
        self.addImagesBtn.disabled = false;

    }

    onNextFrameDone(listSize) {
        jsExecutionTime = window.performance.now() - jSStartExecutionTime;
        results.push({
            size: listSize,
            jsTime: jsExecutionTime,
            totalTime: window.performance.now() - startDrawTime
        });
    }

    downloadResults() {
        var zip = new JSZip();

        resultsStr = results.reduce(function(previous, value, index) {
          return previous +
              value.size + ',' + value.jsTime + ',' + value.totalTime + '\n';
        }, 'Size,JavaScript Time,Total Time\n');

        zip.file('results-riot.csv', resultsStr);

        var blob = zip.generate({type:'blob'});
        saveAs(blob, 'results-riot.zip');
    }

    </script>
</flickr-image-list>
