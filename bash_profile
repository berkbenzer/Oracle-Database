
alias ecs='echo $ORACLE_SID'

exs ()
{
        export ORACLE_SID=""
        read $1 deneme
        export ORACLE_SID="$deneme"
        echo "Oracle Sid Changed has been changed to:" $ORACLE_SID
}
