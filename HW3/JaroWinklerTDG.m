function scores = JaroWinklerTDG( s1, s2 )
% This function computes the Jaro-Winkler for two cell arrays of strings
%
% @param s1      - Nx1 (or 1xN) cell array of usernames
% @param s2      - Mx1 (or 1xM) cell array of usernames
% @return scores - NxM matrix of Jaro-Winkler scores
%
% Andrew Heier, Kelly Geyer
% June 17, 2014

% Make sure both inputs are cell arrays
if ~iscell(s1), s1 = {s1}; end
if ~iscell(s2), s2 = {s2}; end

% Check lengths
n1 = numel(s1);
n2 = numel(s2);

% Convert Matlab strings to Java strings
convertStr = @(oldS) java.lang.String(oldS);
js1 = arrayfun( convertStr, s1, 'UniformOutput', false);
js2 = arrayfun( convertStr, s2, 'UniformOutput', false);

% Split String (Java-style)

js11 = new String(js1.parse(0));
js12 = new String(js1.parse(1));
js21 = new String(js2.parse(0));
js22 = new String(js2.parse(1));

%Count number of words
strlen1 = js1.count(' ')+1;
strlen2 = js2.count(' ')+1;

% Compute scores
jaroWinkler = com.aliasi.spell.JaroWinklerDistance.JARO_WINKLER_DISTANCE;
scores = zeros(n1,1);

% Use only if you want the full matrix of n1 and n2
%for ii = 1:n1
%    for jj = 1n2
%        scores(ii, jj) = jaroWinkler.distance(js1{ii}, js2{jj}); 
%    end
%end
%end

% Use if you want side-by-side comparison with two cell arrays of equal
% length
for ii = 1:n1
    if strlen1 == 1
        if strlen2 == 1
            scores(ii,1) = jaroWinkler.distance(js1{ii}, js2{ii});
        end
        if strlen2 == 2
            %
            tempuname1 = uname[0];
            temptname1 = tname[0];
            tempuname2 = uname[1];
            scores(ii,1) = max(jaroWinkler(uname[0], tname[0]),jaroWinkler(uname[1], tname[0])) - 1.0/(2+len(tname[0]))
        else
            scores(ii,1) = jaroWinkler.distance(js1{ii}, js2{ii});
        end
    end
    if strlen1 == 2
        if strlen2 == 1
            %
            tempuname1 = uname[0];
            temptname1 = tname[0];
            temptname2 = tname[1];
            scores(ii,1) = max(jaroWinkler(uname[0], tname[0]),jaroWinkler(uname[0], tname[1])) - 1.0/(2+len(uname[0]))
        end
        if strlen2 == 2
            %
            tempuname1 = uname[0];
            temptname1 = tname[0];
            tempuname2 = uname[1];
            temptname2 = tname[1];
            scores(ii,1) = max(jaroWinkler(" ".join([tname[0],tname[1]])," ".join([uname[0],uname[1]])),jaroWinkler(" ".join([tname[0],tname[1]])," ".join([uname[1],uname[0]])))
        else
            scores(ii,1) = jaroWinkler.distance(js1{ii}, js2{ii});
        end
    else
        scores(ii,1) = jaroWinkler.distance(js1{ii}, js2{ii});
    end
end
 