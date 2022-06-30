### Database cache

This package defines a common format for referring to project CodeQL databases:

```
{github user}/{repo name}/{commit}
```

This keying format will be used by the `DatabasesCache` to retrieve the absolute dir to the database.

Also, a CLI tool is provided for downloading, compiling an caching each necessary project.