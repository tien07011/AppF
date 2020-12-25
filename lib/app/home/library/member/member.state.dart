part of "member.cubit.dart";


@immutable
abstract class MemberState extends Equatable {
  const MemberState();
}

class MemberInitial extends MemberState {
  const MemberInitial();

  @override
  List<Object> get props => [];
}

class MemberLoading extends MemberState {
  const MemberLoading();

  @override
  List<Object> get props => [];
}

class MemberUploading extends MemberState {
  const MemberUploading();

  @override
  List<Object> get props => [];
}
class RoleLoading extends MemberState {
  const RoleLoading();

  @override
  List<Object> get props => [];
}
class DepartmentLoading extends MemberState {
  const DepartmentLoading();

  @override
  List<Object> get props => [];
}

class ItemsMemberLoaded extends MemberState {
  final List<Member> member;

  ItemsMemberLoaded(this.member);

  @override
  List<Object> get props => [member];
}

class ItemsRoleLoaded extends MemberState {
  final List<dynamic> role;
  ItemsRoleLoaded(this.role);
  @override
  List<Object> get props => [role];
}
class ItemsDepartmentLoaded extends MemberState {
  final List<dynamic> department;
  ItemsDepartmentLoaded(this.department);
  @override
  List<Object> get props => [department];
}

class ItemsMemberUploading extends MemberState {
  const ItemsMemberUploading();

  @override
  List<Object> get props => [];
}

class ItemsMemberUploaded extends MemberState {
  const ItemsMemberUploaded();

  @override
  List<Object> get props => [];
}

class MemberError extends MemberState {
  final String message;

  const MemberError(this.message);

  @override
  List<Object> get props => [message];
}
