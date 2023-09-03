class Tasks{
  late String task;
  bool like = false;
  Tasks(this.like,this.task);
}
List<Tasks> meditation_Task = [
  Tasks(false, 'Close eyes for 10 minutes'),
  Tasks(false, 'Body scan mediatation'),
  Tasks(false, 'Diaphragmatic breathing'),
  Tasks(false, 'Progressive muscle relaxation'),
];
List<Tasks> study_Task = [
  Tasks(false, 'Read 1 chapter'),
  Tasks(false, 'Do homework'),
  Tasks(false, 'Review lessons'),
  Tasks(false, 'Prepare for class'),
];
List<Tasks> work_Task = [
  Tasks(false, 'x100 Jumping Jack'),
  Tasks(false, 'Hit 10k steps'),
  Tasks(false, 'Workout for 45 minutes'),
  Tasks(false, 'Go for a run'),
];
List<Tasks> sleep_Task = [
  Tasks(false, 'Skin care'),
  Tasks(false, 'Stretch'),
  Tasks(false, 'Read'),
  Tasks(false, 'Shower'),
];