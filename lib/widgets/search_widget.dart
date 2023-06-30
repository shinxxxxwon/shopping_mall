import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isSearching = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height * 0.1,
        padding: EdgeInsets.only(left: size.width * 0.05),
        child: Row(
          children: <Widget>[

            Container(
              width: size.width * 0.8,
              padding: EdgeInsets.only(right: size.width * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: SizeTransition(
                sizeFactor: _animation,
                axisAlignment: -1.0,
                child: Platform.isAndroid
                    ? TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "search",
                    hintStyle: TextStyle(
                      fontSize: size.width * 0.03,
                      color: const Color(0xFF67686D),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      alignment: Alignment.center,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                          Icons.search,
                          color: const Color(0xFF67686D),
                          size: size.width * 0.07,
                      ),
                      onPressed: () {},
                    ),
                    fillColor: const Color(0xFFE3E3E3),
                  ),
                )
                    : CupertinoTextField(
                  controller: _searchController,
                  placeholder: "search",
                  placeholderStyle: TextStyle(
                    fontSize: size.width * 0.03,
                    color: const Color(0xFF67686D),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: const Color(0xFFE3E3E3),
                  ),
                  suffix: CupertinoButton(
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.search,
                      color: const Color(0xFF67686D),
                      size: size.width * 0.07,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                _toggleSearch();
              },
              child: Container(
                alignment: Alignment.center,
                child: Icon(
                  _isSearching ? Icons.clear : Icons.search,
                  color: Colors.white,
                  size: size.width * 0.1,),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
