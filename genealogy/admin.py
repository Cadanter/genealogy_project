from django.contrib import admin
from .models import Person, Relationship, Marriage, Document, Event, UserProfile, AuditLog, PendingEdit


@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ['user', 'role', 'joined', 'approved_by']
    list_filter  = ['role']
    search_fields = ['user__username', 'user__email']
    list_editable = ['role']


@admin.register(Person)
class PersonAdmin(admin.ModelAdmin):
    list_display  = ['full_name', 'gender', 'birth_date', 'birth_place', 'is_deceased', 'created_by']
    list_filter   = ['gender', 'is_deceased']
    search_fields = ['first_name', 'last_name', 'birth_place']


@admin.register(Marriage)
class MarriageAdmin(admin.ModelAdmin):
    list_display = ['person1', 'person2', 'marriage_date', 'status']
    list_filter  = ['status']


@admin.register(AuditLog)
class AuditLogAdmin(admin.ModelAdmin):
    list_display  = ['timestamp', 'user', 'action', 'model_name', 'object_repr']
    list_filter   = ['action', 'model_name']
    readonly_fields = ['timestamp', 'user', 'action', 'model_name', 'object_id', 'object_repr', 'changes', 'note']


@admin.register(PendingEdit)
class PendingEditAdmin(admin.ModelAdmin):
    list_display = ['submitted_at', 'proposed_by', 'action', 'object_repr', 'status']
    list_filter  = ['status', 'action']
    readonly_fields = ['submitted_at', 'proposed_by', 'action', 'model_name', 'object_id',
                       'object_repr', 'proposed_data', 'field_changes', 'note']


admin.site.register(Relationship)
admin.site.register(Document)
admin.site.register(Event)
