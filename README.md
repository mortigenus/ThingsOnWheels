# About
The app shows two paginated lists, second list is parameterized by the item selected in the first one.

# Notes
- API returns objects as a dictionary and the result is sorted by key (can be checked by changing pageSize parameter), so we transform all dictionaries into arrays, sorted by key.
- App uses one third-party dependency: RxSwift. (RxSwift + RxCocoa actually). It's added with Cocoapods.
- There's no error handling.
