import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3_audio/flutter3_audio.dart';
import 'package:flutter3_basics/flutter3_basics.dart';

import '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/03/12
///
///
class AudioAbc extends StatefulWidget {
  const AudioAbc({super.key});

  @override
  State<AudioAbc> createState() => _AudioAbcState();
}

const _kTestToneMp3 = 'packages/flutter3_abc/assets/audio/test_tone.mp3';
const _kTestToneM4a = 'packages/flutter3_abc/assets/audio/test_tone.m4a';
const _kTestToneWav = 'packages/flutter3_abc/assets/audio/test_tone.wav';

enum _StatusType { ready, loading, success, error }

class _AudioAbcState extends State<AudioAbc> with BaseAbcStateMixin {
  @override
  WidgetList buildBodyList(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final statusColor = switch (_statusType) {
      _StatusType.ready => colorScheme.surfaceContainerLow,
      _StatusType.loading => colorScheme.surfaceContainerLow,
      _StatusType.success => colorScheme.primaryContainer,
      _StatusType.error => colorScheme.errorContainer,
    };

    final statusIcon = switch (_statusType) {
      _StatusType.ready => Icon(
        Icons.audio_file,
        color: colorScheme.onSurfaceVariant,
      ),
      _StatusType.loading => SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: colorScheme.primary,
        ),
      ),
      _StatusType.success => Icon(
        Icons.check_circle_outline,
        color: colorScheme.primary,
      ),
      _StatusType.error => Icon(Icons.error_outline, color: colorScheme.error),
    };

    return [
      // Status area
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Card(
          color: statusColor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    statusIcon,
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _status,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                if (_waveform != null) ...[
                  const SizedBox(height: 12),
                  AspectRatio(
                    aspectRatio: isDesktopOrWeb ? 1 / 0.2 : 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colorScheme.outlineVariant),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      clipBehavior: Clip.antiAlias,
                      child: CustomPaint(
                        painter: _WaveformPainter(
                          _waveform!,
                          color: Colors.indigo,
                          accentColor: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      // Action buttons
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //MARK: - Conversion
              _sectionCard(
                title: 'Conversion',
                icon: Icons.swap_horiz,
                children: [
                  _actionButton(
                    label: 'MP3 → WAV',
                    icon: Icons.audio_file,
                    onPressed: _busy
                        ? null
                        : () => _convertToWav(_kTestToneMp3),
                  ),
                  _actionButton(
                    label: 'M4A → WAV',
                    icon: Icons.audio_file,
                    onPressed: _busy
                        ? null
                        : () => _convertToWav(_kTestToneM4a),
                  ),
                  _actionButton(
                    label: 'WAV → M4A',
                    icon: Icons.audio_file,
                    onPressed: _busy
                        ? null
                        : () => _convertToM4a(_kTestToneWav),
                  ),
                ],
              ),
              //MARK: - Info & Analysis
              _sectionCard(
                title: 'Info & Analysis',
                icon: Icons.analytics_outlined,
                children: [
                  //MARK: - AutoInfo
                  _actionButton(
                    label: 'Get Audio Info (MP3)',
                    icon: Icons.info_outline,
                    onPressed: _busy
                        ? null
                        : () => _getAudioInfo(_kTestToneMp3),
                  ),
                  _actionButton(
                    label: 'Get Audio Info (M4a)',
                    icon: Icons.info_outline,
                    onPressed: _busy
                        ? null
                        : () => _getAudioInfo(_kTestToneM4a),
                  ),
                  _actionButton(
                    label: 'Get Audio Info (Wav)',
                    icon: Icons.info_outline,
                    onPressed: _busy
                        ? null
                        : () => _getAudioInfo(_kTestToneWav),
                  ),
                  //MARK: - Waveform
                  _actionButton(
                    label: 'Get Waveform (MP3)',
                    icon: Icons.graphic_eq,
                    onPressed: _busy ? null : () => _getWaveform(_kTestToneMp3),
                  ),
                  _actionButton(
                    label: 'Get Audio Info (M4a)',
                    icon: Icons.graphic_eq,
                    onPressed: _busy ? null : () => _getWaveform(_kTestToneM4a),
                  ),
                  _actionButton(
                    label: 'Get Audio Info (Wav)',
                    icon: Icons.graphic_eq,
                    onPressed: _busy ? null : () => _getWaveform(_kTestToneWav),
                  ),
                ],
              ),
              //MARK: - Trim
              _sectionCard(
                title: 'Trim',
                icon: Icons.content_cut,
                children: [
                  _actionButton(
                    label: 'Trim MP3 (0.2s – 0.8s) → WAV',
                    icon: Icons.content_cut,
                    onPressed: _busy ? null : () => _trimAudio(_kTestToneMp3),
                  ),
                ],
              ),
              //MARK: - Bytes API (in-memory)
              _sectionCard(
                title: 'Bytes API (in-memory)',
                icon: Icons.memory,
                children: [
                  _actionButton(
                    label: 'MP3 → WAV (bytes)',
                    icon: Icons.swap_horiz,
                    onPressed: _busy
                        ? null
                        : () => _convertToWavBytes(_kTestToneMp3),
                  ),
                  _actionButton(
                    label: 'MP3 → raw PCM (bytes)',
                    icon: Icons.data_array,
                    onPressed: _busy
                        ? null
                        : () => _convertToRawPcmBytes(_kTestToneMp3),
                  ),
                  _actionButton(
                    label: 'Get Audio Info (bytes)',
                    icon: Icons.info_outline,
                    onPressed: _busy
                        ? null
                        : () => _getAudioInfoBytes(_kTestToneMp3),
                  ),
                  _actionButton(
                    label: 'Trim MP3 (0.2s – 0.8s, bytes)',
                    icon: Icons.content_cut,
                    onPressed: _busy
                        ? null
                        : () => _trimAudioBytes(_kTestToneMp3),
                  ),
                  _actionButton(
                    label: 'Get Waveform (bytes)',
                    icon: Icons.graphic_eq,
                    onPressed: _busy
                        ? null
                        : () => _getWaveformBytes(_kTestToneMp3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ];
  }

  String _status = 'Tap a button to test audio operations.';
  _StatusType _statusType = _StatusType.ready;
  bool _busy = false;
  List<double>? _waveform;

  // ---------------------------------------------------------------------------
  // Business logic
  // ---------------------------------------------------------------------------

  /// Helper to copy Flutter assets to temp directory for file-based API
  Future<String> _copyAssetToTemp(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final dir = Directory.systemTemp;
    final file = File('${dir.path}/${assetPath.split('/').last}');
    await file.writeAsBytes(data.buffer.asUint8List());
    return file.path;
  }

  Future<void> _convertToWav(String assetPath) async {
    if (_busy) return;

    final ext = assetPath.split('.').last.toUpperCase();

    setState(() {
      _busy = true;
      _statusType = _StatusType.loading;
      _status = 'Converting $ext to WAV...';
    });

    try {
      final inputPath = await _copyAssetToTemp(assetPath);
      final inputSize = File(inputPath).lengthSync();
      final baseName = assetPath
          .split('/')
          .last
          .replaceAll(RegExp(r'\.[^.]+$'), '');

      final outputPath =
          '${Directory.systemTemp.path}/${baseName}_converted.wav';
      // Convert any audio format to WAV (lossless PCM)
      final result = await AudioDecoder.convertToWav(inputPath, outputPath);
      final outputSize = await File(result).length();

      setState(() {
        _statusType = _StatusType.success;
        _status =
            'Converted $ext → WAV\n\n'
            'Input: ${assetPath.split('/').last} ($inputSize bytes)\n'
            'Output: ${result.split('/').last}\n'
            'Output Path: $result\n'
            'Size: ${(outputSize / 1024).toStringAsFixed(1)} KB';
      });
    } on AudioConversionException catch (e) {
      setState(() {
        _statusType = _StatusType.error;
        _status = 'Conversion failed: $e';
      });
    } finally {
      setState(() => _busy = false);
    }
  }

  Future<void> _convertToM4a(String assetPath) async {
    if (_busy) return;

    final ext = assetPath.split('.').last.toUpperCase();

    setState(() {
      _busy = true;
      _statusType = _StatusType.loading;
      _status = 'Converting $ext to M4A...';
    });

    try {
      final inputPath = await _copyAssetToTemp(assetPath);
      final inputSize = File(inputPath).lengthSync();
      final baseName = assetPath
          .split('/')
          .last
          .replaceAll(RegExp(r'\.[^.]+$'), '');

      final outputPath =
          '${Directory.systemTemp.path}/${baseName}_converted.m4a';
      // Convert any audio format to M4A (compressed AAC)
      final result = await AudioDecoder.convertToM4a(inputPath, outputPath);
      final outputSize = await File(result).length();

      setState(() {
        _statusType = _StatusType.success;
        _status =
            'Converted $ext → M4A\n\n'
            'Input: ${assetPath.split('/').last} ($inputSize bytes)\n'
            'Output: ${result.split('/').last}\n'
            'Output Path: $result\n'
            'Size: ${(outputSize / 1024).toStringAsFixed(1)} KB';
      });
    } on AudioConversionException catch (e) {
      setState(() {
        _statusType = _StatusType.error;
        _status = 'Conversion failed: $e';
      });
    } finally {
      setState(() => _busy = false);
    }
  }

  Future<void> _getAudioInfo(String assetPath) async {
    if (_busy) return;

    setState(() {
      _busy = true;
      _statusType = _StatusType.loading;
      _status = 'Getting audio info...';
    });

    try {
      final inputPath = await _copyAssetToTemp(assetPath);
      // Get metadata: duration, sample rate, channels, bit rate, format
      final info = await AudioDecoder.getAudioInfo(inputPath);

      setState(() {
        _statusType = _StatusType.success;
        _status =
            'Audio Info: ${assetPath.split('/').last}\n\n'
            'Duration: ${info.duration.inMilliseconds} ms\n'
            'Sample rate: ${info.sampleRate} Hz\n'
            'Channels: ${info.channels}\n'
            'Bit rate: ${info.bitRate} bps\n'
            'Format: ${info.format}\n'
            "File Size: ${(File(inputPath).lengthSync() / 1024).toStringAsFixed(1)} KB";
      });
    } on AudioConversionException catch (e) {
      setState(() {
        _statusType = _StatusType.error;
        _status = 'Get info failed: $e';
      });
    } finally {
      setState(() => _busy = false);
    }
  }

  Future<void> _trimAudio(String assetPath) async {
    if (_busy) return;

    setState(() {
      _busy = true;
      _statusType = _StatusType.loading;
      _status = 'Trimming audio (0.2s - 0.8s)...';
    });

    try {
      final inputPath = await _copyAssetToTemp(assetPath);
      final inputSize = File(inputPath).lengthSync();
      final outputPath = '${Directory.systemTemp.path}/trimmed.wav';
      // Extract a time range from audio file
      final result = await AudioDecoder.trimAudio(
        inputPath,
        outputPath,
        const Duration(milliseconds: 200),
        const Duration(milliseconds: 800),
      );
      final outputSize = await File(result).length();

      setState(() {
        _statusType = _StatusType.success;
        _status =
            'Trimmed ${assetPath.split('/').last} (0.2s-0.8s)\n\n'
            'Input: $inputSize bytes\n'
            'Output: ${result.split('/').last}\n'
            'Output Path: $result\n'
            'Size: ${(outputSize / 1024).toStringAsFixed(1)} KB';
      });
    } on AudioConversionException catch (e) {
      setState(() {
        _statusType = _StatusType.error;
        _status = 'Trim failed: $e';
      });
    } finally {
      setState(() => _busy = false);
    }
  }

  Future<void> _getWaveform(String assetPath) async {
    if (_busy) return;

    setState(() {
      _busy = true;
      _waveform = null;
      _statusType = _StatusType.loading;
      _status = 'Extracting waveform...';
    });

    try {
      final inputPath = await _copyAssetToTemp(assetPath);
      // Extract normalized amplitude data (0.0-1.0) for waveform visualization
      final waveform = await AudioDecoder.getWaveform(
        inputPath,
        numberOfSamples: 50,
      );

      setState(() {
        _waveform = waveform;
        _statusType = _StatusType.success;
        _status = 'Waveform (${waveform.length} samples)';
      });
    } on AudioConversionException catch (e) {
      setState(() {
        _statusType = _StatusType.error;
        _status = 'Waveform failed: $e';
      });
    } finally {
      setState(() => _busy = false);
    }
  }

  /// Helper to load Flutter assets as bytes
  Future<Uint8List> _loadAssetBytes(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  // ---------------------------------------------------------------------------
  // Bytes API (in-memory) - Use when working with network responses, assets,
  // or any in-memory audio data without file I/O
  // ---------------------------------------------------------------------------

  Future<void> _convertToWavBytes(String assetPath) async {
    if (_busy) return;

    final ext = assetPath.split('.').last;

    setState(() {
      _busy = true;
      _statusType = _StatusType.loading;
      _status = 'Converting ${ext.toUpperCase()} → WAV (bytes API)...';
    });

    try {
      final inputBytes = await _loadAssetBytes(assetPath);
      // Convert in-memory audio bytes to WAV format (requires formatHint)
      final wavBytes = await AudioDecoder.convertToWavBytes(
        inputBytes,
        formatHint: ext,
      );

      setState(() {
        _statusType = _StatusType.success;
        _status =
            'Bytes API: ${ext.toUpperCase()} → WAV\n\n'
            'Input: ${assetPath.split('/').last} (${inputBytes.length} bytes)\n'
            'Output: ${wavBytes.length} bytes\n'
            'Size: ${(wavBytes.length / 1024).toStringAsFixed(1)} KB';
      });
    } on AudioConversionException catch (e) {
      setState(() {
        _statusType = _StatusType.error;
        _status = 'Bytes conversion failed: $e';
      });
    } finally {
      setState(() => _busy = false);
    }
  }

  Future<void> _convertToRawPcmBytes(String assetPath) async {
    if (_busy) return;

    final ext = assetPath.split('.').last;

    setState(() {
      _busy = true;
      _statusType = _StatusType.loading;
      _status = 'Converting ${ext.toUpperCase()} → raw PCM (bytes API)...';
    });

    try {
      final inputBytes = await _loadAssetBytes(assetPath);
      final wavBytes = await AudioDecoder.convertToWavBytes(
        inputBytes,
        formatHint: ext,
      );
      // Get raw PCM data without WAV header (set includeHeader: false)
      final pcmBytes = await AudioDecoder.convertToWavBytes(
        inputBytes,
        formatHint: ext,
        includeHeader: false,
      );

      setState(() {
        _statusType = _StatusType.success;
        _status =
            'Bytes API: ${ext.toUpperCase()} → raw PCM\n\n'
            'Input: ${assetPath.split('/').last} (${inputBytes.length} bytes)\n'
            'WAV output: ${wavBytes.length} bytes (with header)\n'
            'PCM output: ${pcmBytes.length} bytes (headerless)\n'
            'Header stripped: ${wavBytes.length - pcmBytes.length} bytes';
      });
    } on AudioConversionException catch (e) {
      setState(() {
        _statusType = _StatusType.error;
        _status = 'Raw PCM conversion failed: $e';
      });
    } finally {
      setState(() => _busy = false);
    }
  }

  Future<void> _getAudioInfoBytes(String assetPath) async {
    if (_busy) return;

    final ext = assetPath.split('.').last;

    setState(() {
      _busy = true;
      _statusType = _StatusType.loading;
      _status = 'Getting audio info (bytes API)...';
    });

    try {
      final inputBytes = await _loadAssetBytes(assetPath);
      final info = await AudioDecoder.getAudioInfoBytes(
        inputBytes,
        formatHint: ext,
      );

      setState(() {
        _statusType = _StatusType.success;
        _status =
            'Bytes API Info: ${assetPath.split('/').last}\n\n'
            'Duration: ${info.duration.inMilliseconds} ms\n'
            'Sample rate: ${info.sampleRate} Hz\n'
            'Channels: ${info.channels}\n'
            'Bit rate: ${info.bitRate} bps\n'
            'Format: ${info.format}';
      });
    } on AudioConversionException catch (e) {
      setState(() {
        _statusType = _StatusType.error;
        _status = 'Bytes info failed: $e';
      });
    } finally {
      setState(() => _busy = false);
    }
  }

  Future<void> _trimAudioBytes(String assetPath) async {
    if (_busy) return;

    final ext = assetPath.split('.').last;

    setState(() {
      _busy = true;
      _statusType = _StatusType.loading;
      _status = 'Trimming audio (0.2s - 0.8s, bytes API)...';
    });

    try {
      final inputBytes = await _loadAssetBytes(assetPath);
      final trimmedBytes = await AudioDecoder.trimAudioBytes(
        inputBytes,
        formatHint: ext,
        start: const Duration(milliseconds: 200),
        end: const Duration(milliseconds: 800),
      );

      setState(() {
        _statusType = _StatusType.success;
        _status =
            'Bytes API: Trimmed (0.2s-0.8s)\n\n'
            'Input: ${assetPath.split('/').last} (${inputBytes.length} bytes)\n'
            'Output: ${trimmedBytes.length} bytes\n'
            'Size: ${(trimmedBytes.length / 1024).toStringAsFixed(1)} KB';
      });
    } on AudioConversionException catch (e) {
      setState(() {
        _statusType = _StatusType.error;
        _status = 'Bytes trim failed: $e';
      });
    } finally {
      setState(() => _busy = false);
    }
  }

  Future<void> _getWaveformBytes(String assetPath) async {
    if (_busy) return;

    final ext = assetPath.split('.').last;

    setState(() {
      _busy = true;
      _waveform = null;
      _statusType = _StatusType.loading;
      _status = 'Extracting waveform (bytes API)...';
    });

    try {
      final inputBytes = await _loadAssetBytes(assetPath);
      // Extract waveform data from in-memory audio bytes
      final waveform = await AudioDecoder.getWaveformBytes(
        inputBytes,
        formatHint: ext,
        numberOfSamples: 50,
      );

      setState(() {
        _waveform = waveform;
        _statusType = _StatusType.success;
        _status = 'Bytes API: Waveform (${waveform.length} samples)';
      });
    } on AudioConversionException catch (e) {
      setState(() {
        _statusType = _StatusType.error;
        _status = 'Bytes waveform failed: $e';
      });
    } finally {
      setState(() => _busy = false);
    }
  }

  // ---------------------------------------------------------------------------
  // UI helpers
  // ---------------------------------------------------------------------------

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton.tonalIcon(
          onPressed: onPressed,
          icon: Icon(icon, size: 18),
          label: Text(label),
        ),
      ),
    );
  }
}

/// CustomPainter for rendering audio waveform with gradient color effect
class _WaveformPainter extends CustomPainter {
  /// [0.0, 0.02298393694236833, 0.17855710309345865, 0.374777295586651, 0.5749214151433952, 0.7758292033819059, 0.9618466091588552, 1.0, 0.9994500840513313, 0.9990389522074354, 0.9990599629117299, 0.9625624449978034, 0.5903621116186553, 0.7743266533093929, 0.37428552650210173, 0.7760238100705928, 0.019665365071565143, 0.029974385872099874, 0.5117607683492713, 0.5886682954305996, 0.5689830557611494, 0.5647719826362794, 0.5657385046508059, 0.5761495450471372, 0.586867086296011, 0.6119618092286494, 0.596367326015318, 0.6226040474378242, 0.607869318918737, 0.6235127169772167, 0.5983536300291289, 0.6720539904903291, 0.6997923962527949, 0.6997773150937302, 0.6998680842525951, 0.7000217158373335, 0.6432691870917818, 0.6097362574363918, 0.5423980449074849, 0.2285627995572652, 0.09052845323983985, 0.0481847105894391, 0.049990869491673515, 0.04985843385366147, 0.06400132948627628, 0.4807419964765358, 0.8851417284816531, 0.9691688348071904, 0.6946839727404596, 0.21635611369707575]
  final List<double> waveform;
  final Color color;
  final Color accentColor;

  _WaveformPainter(
    this.waveform, {
    required this.color,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (waveform.isEmpty) return;

    final barWidth = size.width / waveform.length;
    final midY = size.height / 2;
    final radius = Radius.circular(barWidth * 0.4);

    for (int i = 0; i < waveform.length; i++) {
      final t = i / waveform.length;
      final barColor = Color.lerp(color, accentColor, t)!;
      final paint = Paint()..color = barColor;

      final barHeight = waveform[i] * midY;
      final x = i * barWidth;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(x + barWidth / 2, midY),
            width: barWidth * 0.7,
            height: barHeight * 2,
          ),
          radius,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_WaveformPainter old) =>
      old.waveform != waveform ||
      old.color != color ||
      old.accentColor != accentColor;
}
