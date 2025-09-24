import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobile/controller/barang_controller.dart';
import 'package:mobile/helper/format.dart';
import 'package:mobile/model/barang.dart';
import 'package:mobile/view/add_barang_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BarangController barangController = BarangController();
  late final PagingController<int, Barang>? pagingController;

  @override
  void initState() {
    super.initState();
    pagingController = PagingController(
      getNextPageKey: (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) => barangController.fetchBarang(pageKey, 10),
    );
  }

  @override
  void dispose() {
    pagingController?.dispose();
    barangController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.005,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Stok',
                  ),
                  Text(
                    '${barangController.totalStok.value}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => InkWell(
                onTap: () {
                  Get.to(() => AddBarangPage());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Harga',
                    ),
                    Text(
                      formatCurrency(barangController.totalHarga.value),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back_rounded,
              size: 24,
            ),
            Text(
              'List Stock Barang',
              style: TextTheme.of(context).titleMedium,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_rounded,
                size: 24,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      '${barangController.total} Data ditampilkan',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ),
                  InkWell(
                    child: Text(
                      'Edit Data',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => pagingController?.refresh(),
                  ),
                  child: PagingListener(
                    controller: pagingController!,
                    builder: (context, state, fetchNextPage) => PagedListView<int, Barang>(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      state: state,
                      fetchNextPage: fetchNextPage,
                      builderDelegate: PagedChildBuilderDelegate(
                        firstPageErrorIndicatorBuilder: (context) => Center(
                          child: Text('Terjadi Kesalahan'),
                        ),
                        noItemsFoundIndicatorBuilder: (context) => Center(
                          child: Text('Data Kosong'),
                        ),
                        newPageErrorIndicatorBuilder: (context) => Center(
                          child: Text('Terjadi Kesalahan'),
                        ),
                        noMoreItemsIndicatorBuilder: (context) => Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_upward_rounded,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Tarik untuk memuat data lainnya',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        itemBuilder: (context, item, index) => Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.02,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: BoxBorder.fromSTEB(
                              bottom: BorderSide(color: Colors.black),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade50,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              item.nama ?? '',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            subtitle: Text(
                              'Stok: ${item.stok}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            trailing: Text(
                              formatCurrency(item.harga ?? 0),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
