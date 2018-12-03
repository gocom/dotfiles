describe "help"
  describe "basic operations"
    it "asserts equality"
      assert equal "foo" "foo"
    end
  end

  describe "inline program help option"
    for bin in ./bin/*; do
      if [ -x "$bin" ]; then
        it "$bin --help"
          run "$bin" --help
          assert contain "$output" "Usage:"
        end
        it "$bin -h"
          run "$bin" -h
          assert contain "$output" "Usage:"
        end
      fi
    done
  end
end
