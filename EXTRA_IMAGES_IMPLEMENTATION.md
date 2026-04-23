# Extra Image Management - Implementation Guide

## Overview
This implementation adds complete support for uploading, displaying, and managing multiple reference photos (extra images) for properties, plus functionality to replace the main property image.

---

## Backend Changes

### 1. **Updated Entity: Property.java**
- Added `@OneToMany` relationship to `PropertyImage` entities
- Relationship includes cascade delete and orphan removal
- Images are automatically managed when property is updated

```java
@JsonIgnore
@OneToMany(mappedBy = "property", cascade = CascadeType.ALL, orphanRemoval = true)
private List<PropertyImage> extraImages = new ArrayList<>();
```

### 2. **New Endpoint: GET /api/properties/{id}/extra-images/list**
Returns all extra image IDs for a property:
```
GET http://localhost:8080/api/properties/{propertyId}/extra-images/list
Response: { "extraImageIds": [1, 2, 3] }
```

### 3. **Existing Endpoints (Enhanced)**
- **POST** `/api/properties/{id}/extra-images` - Upload new reference photo
- **GET** `/api/properties/extra-images/{id}` - Retrieve specific image
- **DELETE** `/api/properties/extra-images/{id}` - Delete specific image
- **PUT** `/api/properties/{id}` - Replace main image (updated to include all fields)
- **DELETE** `/api/properties/{id}/image` - Remove main image

### 4. **Database Column Fix**
The images column was already updated to MEDIUMBLOB (16MB max) to fix the truncation error.

---

## Frontend Changes

### 1. **New Component: SecureImage.jsx**
Reusable component for securely loading and displaying images with authentication:
- Handles both main images and extra images
- Includes loading states
- Automatic cleanup of blob URLs
```javascript
<SecureImage propertyId={propertyId} isExtra={true} refreshHash={refreshHash} />
```

### 2. **Updated FloorPlanUpload.jsx**
Complete rewrite to support multiple image uploads:
- Multi-file selection with previews
- Drag & drop support
- Uploads to correct endpoint: `/api/properties/{id}/extra-images`
- Shows upload progress for each file
- Displays file count in button

### 3. **Updated ClientDashboard.jsx**
- Imports `SecureImage` component
- Fetches extra image IDs for each property on load
- `handleReplaceMainBlueprint()` now includes all required fields
- Extra images display in thumbnail carousel at bottom of property card
- Click to view full image, hover to delete

---

## User Workflow

### Adding Reference Photos:
1. Click "Add Reference Photos" button on property card
2. Select multiple images (PNG/JPEG, up to 10MB each)
3. Preview before uploading
4. Click "Upload X Images"
5. Images appear as thumbnails at bottom of card

### Replacing Main Image (CAD Blueprint):
1. Click "Update CAD" button
2. Select new image
3. Image replaces the main property image
4. Automatically refreshes display

### Deleting Reference Photos:
1. Hover over thumbnail at bottom of card
2. Click "X" button that appears
3. Image is deleted from database

### Viewing Full Image:
1. Click on any thumbnail
2. Opens in new tab at full resolution

---

## Database Changes Needed

Run this SQL to ensure proper column size:
```sql
ALTER TABLE properties MODIFY COLUMN image_data MEDIUMBLOB;
```

No changes to `property_images` table needed - already uses MEDIUMBLOB.

---

## Key Files Modified

### Backend
- `src/main/java/com/isp/sitesurvey/entity/Property.java`
- `src/main/java/com/isp/sitesurvey/controller/PropertyController.java`

### Frontend
- `src/components/FloorPlanUpload.jsx` (rewritten)
- `src/components/ClientDashboard.jsx` (enhanced)
- `src/components/SecureImage.jsx` (new)

---

## Testing Checklist

- [ ] Upload single reference photo
- [ ] Upload multiple reference photos at once
- [ ] Display thumbnails in property card
- [ ] Click thumbnail to view full image
- [ ] Delete reference photo
- [ ] Replace main property image (CAD)
- [ ] Verify extra images persist after page refresh
- [ ] Test with images > 5MB (but < 10MB)
- [ ] Verify cascade delete removes extra images when property deleted

---

## Error Handling

- File too large → "File too large. Maximum size is 10MB."
- Invalid format → "Invalid type. Please upload PNG or JPEG images."
- Upload failed → Displays specific error message
- Network error → Shows error details

---

## API Response Examples

### Get Extra Image IDs:
```json
{
  "extraImageIds": [15, 16, 17]
}
```

### Upload Extra Image:
```json
{
  "id": 18
}
```

### Main Image Display:
- Returns binary image data with correct MIME type header

---

## Performance Considerations

- Images are lazy-loaded (only when card is visible)
- Blob URLs are properly revoked to prevent memory leaks
- Cascading delete prevents orphaned image records
- Thumbnail previews are generated client-side from preview
