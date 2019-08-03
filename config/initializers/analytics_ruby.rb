Analytics = Segment::Analytics.new({
    write_key: '5S3j2dDzMUlMkA2qAIfaSEUdUwPSTM39',
    on_error: Proc.new { |status, msg| print msg }
})
