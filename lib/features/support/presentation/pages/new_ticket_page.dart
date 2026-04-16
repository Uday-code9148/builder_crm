import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_form.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_text_form_field.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/selectable_item_bottom_sheet.dart';
import 'package:temp_architecture_app_setup/core/enums/ticket_category.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/features/support/domain/entity/support_ticket_entity.dart';
import 'package:temp_architecture_app_setup/features/support/presentation/blocs/create_ticket_bloc/create_ticket_bloc.dart';

class NewTicketPage extends StatefulWidget {
  const NewTicketPage({super.key});

  @override
  State<NewTicketPage> createState() => _NewTicketPageState();
}

class _NewTicketPageState extends State<NewTicketPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CreateTicketBloc>().add(CreateTicketInitialEvent());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<CreateTicketBloc>().add(
      CreateTicketSubmitted(title: _titleController.text, description: _descController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocListener<CreateTicketBloc, CreateTicketState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == CreateTicketStatus.success && state.createdTicket != null) {
          context.pop<SupportTicketEntity>(state.createdTicket);
        }
      },
      child: AppForm(
        backgroundColor: colors.surface,
        forceDarkTheme: false,
        formKey: _formKey,
        appBar: AppBar(
          backgroundColor: colors.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'New Ticket',
            style: AppTextStyles.s16SemiBold.copyWith(color: colors.onSurface),
          ),
          centerTitle: false,
          iconTheme: IconThemeData(color: colors.onSurface),
        ),
        leadingButton: OutlinedButton(
          onPressed: () => Navigator.of(context).maybePop(),
          style: OutlinedButton.styleFrom(
            foregroundColor: colors.onSurfaceVariant,
            side: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.45)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          child: const Text('Cancel'),
        ),
        trailingButton: BlocBuilder<CreateTicketBloc, CreateTicketState>(
          builder: (context, state) {
            final busy = state.status == CreateTicketStatus.submitting;
            return ElevatedButton(
              onPressed: busy ? null : () => _submit(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryTeal,
                foregroundColor: colors.onPrimaryTeal,
                disabledBackgroundColor: colors.primaryTeal.withValues(alpha: 0.35),
                disabledForegroundColor: colors.onPrimaryTeal.withValues(alpha: 0.65),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              ),
              child: busy
                  ? SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: colors.onPrimaryTeal),
                    )
                  : const Text('Submit'),
            );
          },
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a support request',
                style: AppTextStyles.s24Bold.copyWith(
                  color: colors.onSurface,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Give a short title and a clear description. We\'ll mark it as Open.',
                style: AppTextStyles.s13Regular.copyWith(color: colors.onSurfaceVariant, height: 1.35),
              ),
              const SizedBox(height: 18),
              _CategoryField(),
              const SizedBox(height: 14),
              AppTextFormField(
                labelText: 'Title',
                isRequired: true,
                controller: _titleController,
                hintText: 'e.g. Plumbing issue in kitchen',
                labelTextColor: colors.onSurfaceVariant,
                inputTextColor: colors.onSurface,
                defaultPrefixIcon: false,
                validator: (v) {
                  final value = (v ?? '').trim();
                  if (value.isEmpty) return 'Title is required';
                  if (value.length < 4) return 'Please enter at least 4 characters';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              AppTextFormField(
                labelText: 'Description',
                isRequired: true,
                controller: _descController,
                hintText: 'Add details, location, urgency, and any constraints.',
                labelTextColor: colors.onSurfaceVariant,
                inputTextColor: colors.onSurface,
                defaultPrefixIcon: false,
                maxLines: 5,
                maxLength: 500,
                validator: (v) {
                  final value = (v ?? '').trim();
                  if (value.isEmpty) return 'Description is required';
                  if (value.length < 8) return 'Please add a bit more detail';
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(color: ColorPalette.primaryTealFixedDim, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tip: Add photos/attachments in the next iteration.',
                        style: AppTextStyles.s12Regular.copyWith(color: colors.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category', style: AppTextStyles.s12SemiBold.copyWith(color: colors.onSurfaceVariant)),
        const SizedBox(height: 6),
        BlocBuilder<CreateTicketBloc, CreateTicketState>(
          builder: (context, state) {
            final value = state.category;
            return SelectableItemBottomSheet<TicketCategory>(
              title: 'Select Category',
              canSearchItems: false,
              selectedItem: state.category,
              selectableItems: state.categoryItems,
              onItemSelected: (item) => context.read<CreateTicketBloc>().add(CreateTicketCategoryChanged(item)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3), width: 1),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: value?.value?.color ?? ColorPalette.pendingTeal,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        value?.title ?? 'Select',
                        style: AppTextStyles.s12Regular.copyWith(color: colors.onSurface),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded, color: colors.onSurfaceVariant),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
