import 'package:flutter/material.dart';

void customAlertDialog(
  BuildContext context,
  String title,
  String content,
  String actionTitle1,
  String actionTitle2,
  void Function()? action1,
  void Function()? action2,
) {
  showDialog(
    context: context,
    builder: (alertDialogContext) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          36.0,
        ),
      ),
      backgroundColor: Colors.black,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.8,
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8.0),
              Container(
                height: 4.0,
                width: 32.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800.withOpacity(0.8),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 28.0),
              Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey.shade200,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 28.0),
              Row(
                children: [
                  AlertDialogAction(
                    action: () {
                      Navigator.pop(alertDialogContext);
                      if (action1 != null) action1();
                    },
                    title: actionTitle1,
                    color: Colors.blueGrey.shade800.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8.0),
                  AlertDialogAction(
                    action: () {
                      Navigator.pop(alertDialogContext);
                      if (action2 != null) action2();
                    },
                    title: actionTitle2,
                    color: Colors.yellow.shade700,
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Container(
                height: 3.0,
                width: 120.0,
                margin: const EdgeInsets.only(
                  bottom: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class AlertDialogAction extends StatelessWidget {
  const AlertDialogAction({
    super.key,
    required this.action,
    required this.title,
    required this.color,
  });

  final void Function() action;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
