echo
echo
echo "UPDATING!"
echo
echo
echo
echo

rm -Rf temporalLocationOfIdrisSource
cp -R src/main/idris/ temporalLocationOfIdrisSource
cat build.ipkg > real.ipkg

cd temporalLocationOfIdrisSource

theList=`find . | grep -E ".*\.idr" | sed -E 's/^.{2}//' | sed -E 's/.{4}$//'`

echo "$theList" | sed -e 's/^/modules= /' | head -n 1 | tr \/ \. >> ../real.ipkg
echo "$theList" | sed -e 's/^/       , /' | tail -n +2 | tr \/ \. >> ../real.ipkg

cd ..

idris --build real.ipkg               && \
rm -Rf temporalLocationOfIdrisSource  && \
mkdir -p target                       && \
mv target_ibt target/ibt              && \
target/ibt

rm real.ipkg

