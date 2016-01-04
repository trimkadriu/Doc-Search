<?php include 'header.php'; ?>
<?php include 'dbconnect.php'; ?>
<?php include 'search-handler.php'; ?>

    <form>
        <div class="row">
            <div class="col-md-12">
                <div class="input-group">
                    <input type="text" name="query" class="form-control" value="<?php if(isset($result['query'])) echo htmlspecialchars($result['query']); ?>">
                    <span class="input-group-btn">
                        <input class="btn btn-default" type="submit">
                            Search
                        </input>
                    </span>
                </div>
            </div>
            <div class="col-md-12" style="padding-top: 10px">
                <div class="col-md-3">
                    <label class="radio-inline">
                        <input type="radio" name="select-type" value="and" <?php if(isset($result['select_type']) && $result['select_type'] === 'AND') echo 'checked' ?>> AND
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="select-type" value="or" <?php if(isset($result['select_type']) && $result['select_type'] === 'OR') echo 'checked' ?>> OR
                    </label>
                </div>
                <div class="col-md-9 text-right">
                    <label class="radio-inline">
                        <input type="radio" name="match-type" value="exact" <?php if(isset($result['match_type']) && $result['match_type'] === 'exact') echo 'checked' ?>> Exact String Matching
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="match-type" value="dictionary" <?php if(isset($result['match_type']) && $result['match_type'] === 'dictionary') echo 'checked' ?>> Use Dictionaries
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="match-type" value="fuzzy"<?php if(isset($result['match_type']) && $result['match_type'] === 'fuzzy') echo 'checked' ?>> Fuzzy String Matching
                    </label>
                </div>
            </div>
            <div class="col-md-12" style="padding-top: 20px">
                <label for="sql-string">SQL String:</label>
                <textarea id="sql-string" class="form-control" rows="5" readonly><?php if(isset($result['sql'])) echo $result['sql']; ?></textarea>
            </div>
        </div>
    </form>

    <?php if(isset($result['show']) && $result['show']) { ?>
    <hr/>
    <h4>
        <div class="label label-default">
            Number of documents retrieved: <?php echo $result['num_rows']; ?>
        </div>
        <div class="search-result">
            <ul>
            <?php
                while ($row = pg_fetch_row($result['data'])) {
                    echo "<li>$row[0] [$row[1]]</li>";
                }
            ?>
            </ul>
        </div>
    </h4>
    <?php } ?>

<?php include 'footer.php'; ?>