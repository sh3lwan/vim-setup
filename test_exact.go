	Mark message as handled (success or DLQ'd)
		if err := c.Reader.CommitMessages(ctx, msg); err != nil {
			fmt.Printf("commit failed (will be retried): %v\n", err)
			// Not committing means it can be redelivered; make your handler idempotent
		}
