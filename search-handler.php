<?php
// Build the whole query
//======================================
function query_builder($query, $boolean_operator, $match_type) {
    // Prepare query - Clean from whitespaces & SQL Injection
    $query = trim(pg_escape_string(preg_replace('/\s\s+/', ' ', $query)));

    $highlight = get_highlight_part($query, $boolean_operator);
    $where_clause = get_where_part($query, $boolean_operator, $match_type);
    $final_query =  "SELECT ts_headline(doc_text, to_tsquery('$highlight')), " .
                    "ts_rank(to_tsvector(doc_text), to_tsquery('$highlight')) " .
                    "FROM documents " .
                    "$where_clause " .
                    "ORDER BY id DESC";

    return $final_query;
}

function get_where_part($query, $boolean_operator, $match_type) {
    // Get array of Words and Phrases
    preg_match_all('/"(?:\\\\.|[^\\\\"])*"|\S+/', $query, $matches);
    $matches = $matches[0];

    $phrases = array();
    $words = array();

    for($i = 0; $i < sizeof($matches); $i++) {
        if(strpos($matches[$i], '"') !== FALSE) // Is it a phrase?
            array_push($phrases, $matches[$i]);
        else
            array_push($words, $matches[$i]);
    }
    $words = trim(implode(" ", $words)); // Trim side spaces

    $where_clause = "WHERE ";
    if(!empty($words)) {
        $where_clause .= get_where_match($match_type, "$words");
        if(sizeof($phrases) > 0)
            $where_clause .= $boolean_operator;
    }
    for($i = 0; $i < sizeof($phrases); $i++) {
        if($i > 0) // If there are no words and its first iteration
            $where_clause .= $boolean_operator;
        $where_clause .= " ".get_where_match($match_type, trim($phrases[$i], '"'));
    }

    return $where_clause;
}

function get_highlight_part($query, $boolean_operator) {
    // Prepare operator character
    $operator = '';
    if($boolean_operator === 'AND')
        $operator = '&';
    elseif($boolean_operator === 'OR')
        $operator = '|';

    // Separate phrases and words
    preg_match_all('/"(?:\\\\.|[^\\\\"])*"|\S+/', $query, $matches);
    $matches = $matches[0];
    for($i = 0; $i < sizeof($matches); $i++) {
        if (strpos($matches[$i], '"') !== FALSE)
            $matches[$i] = str_replace(' ', " & ", $matches[$i]); // Add phrases with & symbol
    }
    // Implode words and phrases them with operator
    $query = implode(" $operator ", $matches);

    // Replace double quotes with parenthesis
    $open_bracket = true;
    for($i = 0; $i <= strlen($query); $i++) {
        $char = substr($query, $i, 1);
        if ($char === '"') {
            if($open_bracket) {
                $query[$i] = '(';
                $open_bracket = false;
            }
            else {
                $query[$i] = ')';
                $open_bracket = true;
            }
        }
    }
    return $query;
}

function get_where_match($match_type, $query) {
    $match = "";
    if ($match_type === 'exact')
        $match = "doc_text LIKE '%$query%' ";
    elseif ($match_type === 'fuzzy')
        $match = "soundex(doc_text) = soundex('$query') ";
    elseif ($match_type === 'dictionary')
        $match = "to_tsvector(doc_text) @@ to_tsquery('english', '".get_highlight_part($query, "AND")."') ";
    return $match;
}

// Handle Search Request
//======================================
// Default values
$result['select_type'] = 'AND';
$result['match_type'] = 'exact';

if (!empty($_GET)) {
    // Get params
    $query = isset($_GET['query']) ? $_GET['query'] : '';
    $select_type = $_GET['select-type'];
    $match_type = $_GET['match-type'];

    // Validate select type
    if($select_type === 'and')
        $select_type = 'AND';
    elseif($select_type === 'or') {
        $result['select_type'] = 'OR';
        $select_type = 'OR';
    }
    else
        return;

    // Handle request and response
    if(!empty($query)) {
        $sql = query_builder($query, $select_type, $match_type);
        $search_result = pg_query($sql);
        $result = array();
        $result['show'] = true;
        $result['sql'] = $sql;
        $result['num_rows'] = pg_numrows($search_result);
        $result['data'] = $search_result;
        $result['query'] = $query;
        $result['select_type'] = $select_type;
        $result['match_type'] = $match_type;
    }
}