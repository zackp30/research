import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="_build"} $ do
  "//*.diagram.hs" %> \f -> do
    let f' = dropDirectory1 $ f -<.> "svg"
    () <- cmd "runghc" f "-o" f'
    cmd "mv" f' ("build/" ++ f')
