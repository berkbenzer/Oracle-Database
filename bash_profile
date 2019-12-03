alias es='echo $ORACLE_SID'
deneme ()
{
        export ORACLE_SID=""
        read $1 deneme
        export ORACLE_SID="$deneme"
}
