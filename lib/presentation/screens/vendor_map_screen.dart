import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_app/core/l10n/app_localizations_extension.dart';
import 'package:flutter_app/domain/entities/vendor.dart';
import 'package:flutter_app/domain/usecases/get_vendors.dart';
import 'package:flutter_app/injection.dart';
import 'package:flutter_app/presentation/blocs/vendor_map/vendor_map_cubit.dart';
import 'package:flutter_app/presentation/blocs/vendor_map/vendor_map_state.dart';
import 'package:flutter_app/presentation/widgets/vendor_map/vendor_info_card.dart';

class VendorMapScreen extends StatelessWidget {
  const VendorMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          VendorMapCubit(getVendors: getIt<GetVendors>())..loadVendors(),
      child: const _VendorMapView(),
    );
  }
}

class _VendorMapView extends StatefulWidget {
  const _VendorMapView();

  @override
  State<_VendorMapView> createState() => _VendorMapViewState();
}

class _VendorMapViewState extends State<_VendorMapView> {
  GoogleMapController? _mapController;
  Vendor? _selectedVendor;
  bool _boundsFitted = false;

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 4,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.nearbyVendors),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: BlocBuilder<VendorMapCubit, VendorMapState>(
        builder: (context, state) {
          if (state.status == VendorMapStatus.loading) {
            return _MapLoading(l10n: l10n);
          }
          if (state.status == VendorMapStatus.error) {
            return _MapError(
              message: l10n.loadVendorsError,
              onRetry: () => context.read<VendorMapCubit>().loadVendors(),
            );
          }
          final markers = _buildMarkers(state.vendors);
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                markers: markers,
                onMapCreated: (controller) {
                  _mapController = controller;
                  _maybeFitBounds(state.vendors);
                },
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
              ),
              if (_selectedVendor != null)
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: VendorInfoCard(
                    vendor: _selectedVendor!,
                    onClose: () => setState(() => _selectedVendor = null),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final state = context.read<VendorMapCubit>().state;
          if (state.status == VendorMapStatus.loaded) {
            _fitBounds(state.vendors);
          }
        },
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        child: const Icon(Icons.crop_free_rounded),
      ),
    );
  }

  Set<Marker> _buildMarkers(List<Vendor> vendors) {
    final Set<Marker> markers = <Marker>{};
    for (final vendor in vendors) {
      final markerId = MarkerId(vendor.id);
      markers.add(
        Marker(
          markerId: markerId,
          position: LatLng(vendor.latitude, vendor.longitude),
          infoWindow: InfoWindow(
            title: vendor.name,
            snippet: '${vendor.cuisine} • ${vendor.rating.toStringAsFixed(1)}★',
          ),
          onTap: () {
            setState(() {
              _selectedVendor = vendor;
            });
            _mapController?.showMarkerInfoWindow(markerId);
          },
          icon: BitmapDescriptor.defaultMarkerWithHue(
            _hueForRating(vendor.rating),
          ),
        ),
      );
    }
    return markers;
  }

  void _maybeFitBounds(List<Vendor> vendors) {
    if (_boundsFitted) return;
    _boundsFitted = true;
    _fitBounds(vendors);
  }

  void _fitBounds(List<Vendor> vendors) {
    if (_mapController == null || vendors.isEmpty) return;
    final double southLat = vendors
        .map((v) => v.latitude)
        .reduce((a, b) => a < b ? a : b);
    final double northLat = vendors
        .map((v) => v.latitude)
        .reduce((a, b) => a > b ? a : b);
    final double westLng = vendors
        .map((v) => v.longitude)
        .reduce((a, b) => a < b ? a : b);
    final double eastLng = vendors
        .map((v) => v.longitude)
        .reduce((a, b) => a > b ? a : b);
    final bounds = LatLngBounds(
      southwest: LatLng(southLat, westLng),
      northeast: LatLng(northLat, eastLng),
    );
    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 80),
    );
  }

  double _hueForRating(double rating) {
    if (rating >= 4.7) return BitmapDescriptor.hueGreen;
    if (rating >= 4.4) return BitmapDescriptor.hueAzure;
    return BitmapDescriptor.hueOrange;
  }
}

class _MapLoading extends StatelessWidget {
  final AppLocalizations l10n;

  const _MapLoading({required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            l10n.loadingVendors,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _MapError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _MapError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off_rounded,
              size: 56,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
