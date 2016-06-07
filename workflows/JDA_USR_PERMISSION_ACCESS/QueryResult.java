// ORM class for table 'null'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Tue May 31 10:10:27 CDT 2016
// For connector: org.apache.sqoop.manager.OracleManager
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.Writable;
import org.apache.hadoop.mapred.lib.db.DBWritable;
import com.cloudera.sqoop.lib.JdbcWritableBridge;
import com.cloudera.sqoop.lib.DelimiterSet;
import com.cloudera.sqoop.lib.FieldFormatter;
import com.cloudera.sqoop.lib.RecordParser;
import com.cloudera.sqoop.lib.BooleanParser;
import com.cloudera.sqoop.lib.BlobRef;
import com.cloudera.sqoop.lib.ClobRef;
import com.cloudera.sqoop.lib.LargeObjectLoader;
import com.cloudera.sqoop.lib.SqoopRecord;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class QueryResult extends SqoopRecord  implements DBWritable, Writable {
  private final int PROTOCOL_VERSION = 3;
  public int getClassFormatVersion() { return PROTOCOL_VERSION; }
  protected ResultSet __cur_result_set;
  private String REPORTING_AFFILIATE;
  public String get_REPORTING_AFFILIATE() {
    return REPORTING_AFFILIATE;
  }
  public void set_REPORTING_AFFILIATE(String REPORTING_AFFILIATE) {
    this.REPORTING_AFFILIATE = REPORTING_AFFILIATE;
  }
  public QueryResult with_REPORTING_AFFILIATE(String REPORTING_AFFILIATE) {
    this.REPORTING_AFFILIATE = REPORTING_AFFILIATE;
    return this;
  }
  private String INVENTORY_TYPE;
  public String get_INVENTORY_TYPE() {
    return INVENTORY_TYPE;
  }
  public void set_INVENTORY_TYPE(String INVENTORY_TYPE) {
    this.INVENTORY_TYPE = INVENTORY_TYPE;
  }
  public QueryResult with_INVENTORY_TYPE(String INVENTORY_TYPE) {
    this.INVENTORY_TYPE = INVENTORY_TYPE;
    return this;
  }
  private String LIST_NO;
  public String get_LIST_NO() {
    return LIST_NO;
  }
  public void set_LIST_NO(String LIST_NO) {
    this.LIST_NO = LIST_NO;
  }
  public QueryResult with_LIST_NO(String LIST_NO) {
    this.LIST_NO = LIST_NO;
    return this;
  }
  private String LABEL_CODE;
  public String get_LABEL_CODE() {
    return LABEL_CODE;
  }
  public void set_LABEL_CODE(String LABEL_CODE) {
    this.LABEL_CODE = LABEL_CODE;
  }
  public QueryResult with_LABEL_CODE(String LABEL_CODE) {
    this.LABEL_CODE = LABEL_CODE;
    return this;
  }
  private String SIZE_CODE;
  public String get_SIZE_CODE() {
    return SIZE_CODE;
  }
  public void set_SIZE_CODE(String SIZE_CODE) {
    this.SIZE_CODE = SIZE_CODE;
  }
  public QueryResult with_SIZE_CODE(String SIZE_CODE) {
    this.SIZE_CODE = SIZE_CODE;
    return this;
  }
  private String PACK_SIZE;
  public String get_PACK_SIZE() {
    return PACK_SIZE;
  }
  public void set_PACK_SIZE(String PACK_SIZE) {
    this.PACK_SIZE = PACK_SIZE;
  }
  public QueryResult with_PACK_SIZE(String PACK_SIZE) {
    this.PACK_SIZE = PACK_SIZE;
    return this;
  }
  private String D56_ITEM_NO;
  public String get_D56_ITEM_NO() {
    return D56_ITEM_NO;
  }
  public void set_D56_ITEM_NO(String D56_ITEM_NO) {
    this.D56_ITEM_NO = D56_ITEM_NO;
  }
  public QueryResult with_D56_ITEM_NO(String D56_ITEM_NO) {
    this.D56_ITEM_NO = D56_ITEM_NO;
    return this;
  }
  private java.sql.Timestamp MONTH_DATE;
  public java.sql.Timestamp get_MONTH_DATE() {
    return MONTH_DATE;
  }
  public void set_MONTH_DATE(java.sql.Timestamp MONTH_DATE) {
    this.MONTH_DATE = MONTH_DATE;
  }
  public QueryResult with_MONTH_DATE(java.sql.Timestamp MONTH_DATE) {
    this.MONTH_DATE = MONTH_DATE;
    return this;
  }
  private java.math.BigDecimal FACT;
  public java.math.BigDecimal get_FACT() {
    return FACT;
  }
  public void set_FACT(java.math.BigDecimal FACT) {
    this.FACT = FACT;
  }
  public QueryResult with_FACT(java.math.BigDecimal FACT) {
    this.FACT = FACT;
    return this;
  }
  private String CREATED_BY;
  public String get_CREATED_BY() {
    return CREATED_BY;
  }
  public void set_CREATED_BY(String CREATED_BY) {
    this.CREATED_BY = CREATED_BY;
  }
  public QueryResult with_CREATED_BY(String CREATED_BY) {
    this.CREATED_BY = CREATED_BY;
    return this;
  }
  private java.sql.Timestamp CREATION_DATE;
  public java.sql.Timestamp get_CREATION_DATE() {
    return CREATION_DATE;
  }
  public void set_CREATION_DATE(java.sql.Timestamp CREATION_DATE) {
    this.CREATION_DATE = CREATION_DATE;
  }
  public QueryResult with_CREATION_DATE(java.sql.Timestamp CREATION_DATE) {
    this.CREATION_DATE = CREATION_DATE;
    return this;
  }
  private String LAST_UPD_BY;
  public String get_LAST_UPD_BY() {
    return LAST_UPD_BY;
  }
  public void set_LAST_UPD_BY(String LAST_UPD_BY) {
    this.LAST_UPD_BY = LAST_UPD_BY;
  }
  public QueryResult with_LAST_UPD_BY(String LAST_UPD_BY) {
    this.LAST_UPD_BY = LAST_UPD_BY;
    return this;
  }
  private java.sql.Timestamp LAST_UPD_DATE;
  public java.sql.Timestamp get_LAST_UPD_DATE() {
    return LAST_UPD_DATE;
  }
  public void set_LAST_UPD_DATE(java.sql.Timestamp LAST_UPD_DATE) {
    this.LAST_UPD_DATE = LAST_UPD_DATE;
  }
  public QueryResult with_LAST_UPD_DATE(java.sql.Timestamp LAST_UPD_DATE) {
    this.LAST_UPD_DATE = LAST_UPD_DATE;
    return this;
  }
  private String DATAMART_LAST_UPD_BY;
  public String get_DATAMART_LAST_UPD_BY() {
    return DATAMART_LAST_UPD_BY;
  }
  public void set_DATAMART_LAST_UPD_BY(String DATAMART_LAST_UPD_BY) {
    this.DATAMART_LAST_UPD_BY = DATAMART_LAST_UPD_BY;
  }
  public QueryResult with_DATAMART_LAST_UPD_BY(String DATAMART_LAST_UPD_BY) {
    this.DATAMART_LAST_UPD_BY = DATAMART_LAST_UPD_BY;
    return this;
  }
  private java.sql.Timestamp DATAMART_LAST_UPD_DATE;
  public java.sql.Timestamp get_DATAMART_LAST_UPD_DATE() {
    return DATAMART_LAST_UPD_DATE;
  }
  public void set_DATAMART_LAST_UPD_DATE(java.sql.Timestamp DATAMART_LAST_UPD_DATE) {
    this.DATAMART_LAST_UPD_DATE = DATAMART_LAST_UPD_DATE;
  }
  public QueryResult with_DATAMART_LAST_UPD_DATE(java.sql.Timestamp DATAMART_LAST_UPD_DATE) {
    this.DATAMART_LAST_UPD_DATE = DATAMART_LAST_UPD_DATE;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof QueryResult)) {
      return false;
    }
    QueryResult that = (QueryResult) o;
    boolean equal = true;
    equal = equal && (this.REPORTING_AFFILIATE == null ? that.REPORTING_AFFILIATE == null : this.REPORTING_AFFILIATE.equals(that.REPORTING_AFFILIATE));
    equal = equal && (this.INVENTORY_TYPE == null ? that.INVENTORY_TYPE == null : this.INVENTORY_TYPE.equals(that.INVENTORY_TYPE));
    equal = equal && (this.LIST_NO == null ? that.LIST_NO == null : this.LIST_NO.equals(that.LIST_NO));
    equal = equal && (this.LABEL_CODE == null ? that.LABEL_CODE == null : this.LABEL_CODE.equals(that.LABEL_CODE));
    equal = equal && (this.SIZE_CODE == null ? that.SIZE_CODE == null : this.SIZE_CODE.equals(that.SIZE_CODE));
    equal = equal && (this.PACK_SIZE == null ? that.PACK_SIZE == null : this.PACK_SIZE.equals(that.PACK_SIZE));
    equal = equal && (this.D56_ITEM_NO == null ? that.D56_ITEM_NO == null : this.D56_ITEM_NO.equals(that.D56_ITEM_NO));
    equal = equal && (this.MONTH_DATE == null ? that.MONTH_DATE == null : this.MONTH_DATE.equals(that.MONTH_DATE));
    equal = equal && (this.FACT == null ? that.FACT == null : this.FACT.equals(that.FACT));
    equal = equal && (this.CREATED_BY == null ? that.CREATED_BY == null : this.CREATED_BY.equals(that.CREATED_BY));
    equal = equal && (this.CREATION_DATE == null ? that.CREATION_DATE == null : this.CREATION_DATE.equals(that.CREATION_DATE));
    equal = equal && (this.LAST_UPD_BY == null ? that.LAST_UPD_BY == null : this.LAST_UPD_BY.equals(that.LAST_UPD_BY));
    equal = equal && (this.LAST_UPD_DATE == null ? that.LAST_UPD_DATE == null : this.LAST_UPD_DATE.equals(that.LAST_UPD_DATE));
    equal = equal && (this.DATAMART_LAST_UPD_BY == null ? that.DATAMART_LAST_UPD_BY == null : this.DATAMART_LAST_UPD_BY.equals(that.DATAMART_LAST_UPD_BY));
    equal = equal && (this.DATAMART_LAST_UPD_DATE == null ? that.DATAMART_LAST_UPD_DATE == null : this.DATAMART_LAST_UPD_DATE.equals(that.DATAMART_LAST_UPD_DATE));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof QueryResult)) {
      return false;
    }
    QueryResult that = (QueryResult) o;
    boolean equal = true;
    equal = equal && (this.REPORTING_AFFILIATE == null ? that.REPORTING_AFFILIATE == null : this.REPORTING_AFFILIATE.equals(that.REPORTING_AFFILIATE));
    equal = equal && (this.INVENTORY_TYPE == null ? that.INVENTORY_TYPE == null : this.INVENTORY_TYPE.equals(that.INVENTORY_TYPE));
    equal = equal && (this.LIST_NO == null ? that.LIST_NO == null : this.LIST_NO.equals(that.LIST_NO));
    equal = equal && (this.LABEL_CODE == null ? that.LABEL_CODE == null : this.LABEL_CODE.equals(that.LABEL_CODE));
    equal = equal && (this.SIZE_CODE == null ? that.SIZE_CODE == null : this.SIZE_CODE.equals(that.SIZE_CODE));
    equal = equal && (this.PACK_SIZE == null ? that.PACK_SIZE == null : this.PACK_SIZE.equals(that.PACK_SIZE));
    equal = equal && (this.D56_ITEM_NO == null ? that.D56_ITEM_NO == null : this.D56_ITEM_NO.equals(that.D56_ITEM_NO));
    equal = equal && (this.MONTH_DATE == null ? that.MONTH_DATE == null : this.MONTH_DATE.equals(that.MONTH_DATE));
    equal = equal && (this.FACT == null ? that.FACT == null : this.FACT.equals(that.FACT));
    equal = equal && (this.CREATED_BY == null ? that.CREATED_BY == null : this.CREATED_BY.equals(that.CREATED_BY));
    equal = equal && (this.CREATION_DATE == null ? that.CREATION_DATE == null : this.CREATION_DATE.equals(that.CREATION_DATE));
    equal = equal && (this.LAST_UPD_BY == null ? that.LAST_UPD_BY == null : this.LAST_UPD_BY.equals(that.LAST_UPD_BY));
    equal = equal && (this.LAST_UPD_DATE == null ? that.LAST_UPD_DATE == null : this.LAST_UPD_DATE.equals(that.LAST_UPD_DATE));
    equal = equal && (this.DATAMART_LAST_UPD_BY == null ? that.DATAMART_LAST_UPD_BY == null : this.DATAMART_LAST_UPD_BY.equals(that.DATAMART_LAST_UPD_BY));
    equal = equal && (this.DATAMART_LAST_UPD_DATE == null ? that.DATAMART_LAST_UPD_DATE == null : this.DATAMART_LAST_UPD_DATE.equals(that.DATAMART_LAST_UPD_DATE));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.REPORTING_AFFILIATE = JdbcWritableBridge.readString(1, __dbResults);
    this.INVENTORY_TYPE = JdbcWritableBridge.readString(2, __dbResults);
    this.LIST_NO = JdbcWritableBridge.readString(3, __dbResults);
    this.LABEL_CODE = JdbcWritableBridge.readString(4, __dbResults);
    this.SIZE_CODE = JdbcWritableBridge.readString(5, __dbResults);
    this.PACK_SIZE = JdbcWritableBridge.readString(6, __dbResults);
    this.D56_ITEM_NO = JdbcWritableBridge.readString(7, __dbResults);
    this.MONTH_DATE = JdbcWritableBridge.readTimestamp(8, __dbResults);
    this.FACT = JdbcWritableBridge.readBigDecimal(9, __dbResults);
    this.CREATED_BY = JdbcWritableBridge.readString(10, __dbResults);
    this.CREATION_DATE = JdbcWritableBridge.readTimestamp(11, __dbResults);
    this.LAST_UPD_BY = JdbcWritableBridge.readString(12, __dbResults);
    this.LAST_UPD_DATE = JdbcWritableBridge.readTimestamp(13, __dbResults);
    this.DATAMART_LAST_UPD_BY = JdbcWritableBridge.readString(14, __dbResults);
    this.DATAMART_LAST_UPD_DATE = JdbcWritableBridge.readTimestamp(15, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.REPORTING_AFFILIATE = JdbcWritableBridge.readString(1, __dbResults);
    this.INVENTORY_TYPE = JdbcWritableBridge.readString(2, __dbResults);
    this.LIST_NO = JdbcWritableBridge.readString(3, __dbResults);
    this.LABEL_CODE = JdbcWritableBridge.readString(4, __dbResults);
    this.SIZE_CODE = JdbcWritableBridge.readString(5, __dbResults);
    this.PACK_SIZE = JdbcWritableBridge.readString(6, __dbResults);
    this.D56_ITEM_NO = JdbcWritableBridge.readString(7, __dbResults);
    this.MONTH_DATE = JdbcWritableBridge.readTimestamp(8, __dbResults);
    this.FACT = JdbcWritableBridge.readBigDecimal(9, __dbResults);
    this.CREATED_BY = JdbcWritableBridge.readString(10, __dbResults);
    this.CREATION_DATE = JdbcWritableBridge.readTimestamp(11, __dbResults);
    this.LAST_UPD_BY = JdbcWritableBridge.readString(12, __dbResults);
    this.LAST_UPD_DATE = JdbcWritableBridge.readTimestamp(13, __dbResults);
    this.DATAMART_LAST_UPD_BY = JdbcWritableBridge.readString(14, __dbResults);
    this.DATAMART_LAST_UPD_DATE = JdbcWritableBridge.readTimestamp(15, __dbResults);
  }
  public void loadLargeObjects(LargeObjectLoader __loader)
      throws SQLException, IOException, InterruptedException {
  }
  public void loadLargeObjects0(LargeObjectLoader __loader)
      throws SQLException, IOException, InterruptedException {
  }
  public void write(PreparedStatement __dbStmt) throws SQLException {
    write(__dbStmt, 0);
  }

  public int write(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeString(REPORTING_AFFILIATE, 1 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(INVENTORY_TYPE, 2 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(LIST_NO, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(LABEL_CODE, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(SIZE_CODE, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(PACK_SIZE, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(D56_ITEM_NO, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(MONTH_DATE, 8 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(FACT, 9 + __off, 2, __dbStmt);
    JdbcWritableBridge.writeString(CREATED_BY, 10 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(CREATION_DATE, 11 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(LAST_UPD_BY, 12 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(LAST_UPD_DATE, 13 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(DATAMART_LAST_UPD_BY, 14 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(DATAMART_LAST_UPD_DATE, 15 + __off, 93, __dbStmt);
    return 15;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeString(REPORTING_AFFILIATE, 1 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(INVENTORY_TYPE, 2 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(LIST_NO, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(LABEL_CODE, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(SIZE_CODE, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(PACK_SIZE, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(D56_ITEM_NO, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(MONTH_DATE, 8 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(FACT, 9 + __off, 2, __dbStmt);
    JdbcWritableBridge.writeString(CREATED_BY, 10 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(CREATION_DATE, 11 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(LAST_UPD_BY, 12 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(LAST_UPD_DATE, 13 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(DATAMART_LAST_UPD_BY, 14 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(DATAMART_LAST_UPD_DATE, 15 + __off, 93, __dbStmt);
  }
  public void readFields(DataInput __dataIn) throws IOException {
this.readFields0(__dataIn);  }
  public void readFields0(DataInput __dataIn) throws IOException {
    if (__dataIn.readBoolean()) { 
        this.REPORTING_AFFILIATE = null;
    } else {
    this.REPORTING_AFFILIATE = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.INVENTORY_TYPE = null;
    } else {
    this.INVENTORY_TYPE = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.LIST_NO = null;
    } else {
    this.LIST_NO = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.LABEL_CODE = null;
    } else {
    this.LABEL_CODE = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.SIZE_CODE = null;
    } else {
    this.SIZE_CODE = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.PACK_SIZE = null;
    } else {
    this.PACK_SIZE = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.D56_ITEM_NO = null;
    } else {
    this.D56_ITEM_NO = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.MONTH_DATE = null;
    } else {
    this.MONTH_DATE = new Timestamp(__dataIn.readLong());
    this.MONTH_DATE.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.FACT = null;
    } else {
    this.FACT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.CREATED_BY = null;
    } else {
    this.CREATED_BY = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.CREATION_DATE = null;
    } else {
    this.CREATION_DATE = new Timestamp(__dataIn.readLong());
    this.CREATION_DATE.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.LAST_UPD_BY = null;
    } else {
    this.LAST_UPD_BY = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.LAST_UPD_DATE = null;
    } else {
    this.LAST_UPD_DATE = new Timestamp(__dataIn.readLong());
    this.LAST_UPD_DATE.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.DATAMART_LAST_UPD_BY = null;
    } else {
    this.DATAMART_LAST_UPD_BY = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.DATAMART_LAST_UPD_DATE = null;
    } else {
    this.DATAMART_LAST_UPD_DATE = new Timestamp(__dataIn.readLong());
    this.DATAMART_LAST_UPD_DATE.setNanos(__dataIn.readInt());
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.REPORTING_AFFILIATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REPORTING_AFFILIATE);
    }
    if (null == this.INVENTORY_TYPE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, INVENTORY_TYPE);
    }
    if (null == this.LIST_NO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, LIST_NO);
    }
    if (null == this.LABEL_CODE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, LABEL_CODE);
    }
    if (null == this.SIZE_CODE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, SIZE_CODE);
    }
    if (null == this.PACK_SIZE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, PACK_SIZE);
    }
    if (null == this.D56_ITEM_NO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, D56_ITEM_NO);
    }
    if (null == this.MONTH_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.MONTH_DATE.getTime());
    __dataOut.writeInt(this.MONTH_DATE.getNanos());
    }
    if (null == this.FACT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.FACT, __dataOut);
    }
    if (null == this.CREATED_BY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, CREATED_BY);
    }
    if (null == this.CREATION_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.CREATION_DATE.getTime());
    __dataOut.writeInt(this.CREATION_DATE.getNanos());
    }
    if (null == this.LAST_UPD_BY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, LAST_UPD_BY);
    }
    if (null == this.LAST_UPD_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.LAST_UPD_DATE.getTime());
    __dataOut.writeInt(this.LAST_UPD_DATE.getNanos());
    }
    if (null == this.DATAMART_LAST_UPD_BY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, DATAMART_LAST_UPD_BY);
    }
    if (null == this.DATAMART_LAST_UPD_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.DATAMART_LAST_UPD_DATE.getTime());
    __dataOut.writeInt(this.DATAMART_LAST_UPD_DATE.getNanos());
    }
  }
  public void write0(DataOutput __dataOut) throws IOException {
    if (null == this.REPORTING_AFFILIATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REPORTING_AFFILIATE);
    }
    if (null == this.INVENTORY_TYPE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, INVENTORY_TYPE);
    }
    if (null == this.LIST_NO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, LIST_NO);
    }
    if (null == this.LABEL_CODE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, LABEL_CODE);
    }
    if (null == this.SIZE_CODE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, SIZE_CODE);
    }
    if (null == this.PACK_SIZE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, PACK_SIZE);
    }
    if (null == this.D56_ITEM_NO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, D56_ITEM_NO);
    }
    if (null == this.MONTH_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.MONTH_DATE.getTime());
    __dataOut.writeInt(this.MONTH_DATE.getNanos());
    }
    if (null == this.FACT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.FACT, __dataOut);
    }
    if (null == this.CREATED_BY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, CREATED_BY);
    }
    if (null == this.CREATION_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.CREATION_DATE.getTime());
    __dataOut.writeInt(this.CREATION_DATE.getNanos());
    }
    if (null == this.LAST_UPD_BY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, LAST_UPD_BY);
    }
    if (null == this.LAST_UPD_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.LAST_UPD_DATE.getTime());
    __dataOut.writeInt(this.LAST_UPD_DATE.getNanos());
    }
    if (null == this.DATAMART_LAST_UPD_BY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, DATAMART_LAST_UPD_BY);
    }
    if (null == this.DATAMART_LAST_UPD_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.DATAMART_LAST_UPD_DATE.getTime());
    __dataOut.writeInt(this.DATAMART_LAST_UPD_DATE.getNanos());
    }
  }
  private static final DelimiterSet __outputDelimiters = new DelimiterSet((char) 1, (char) 10, (char) 0, (char) 0, false);
  public String toString() {
    return toString(__outputDelimiters, true);
  }
  public String toString(DelimiterSet delimiters) {
    return toString(delimiters, true);
  }
  public String toString(boolean useRecordDelim) {
    return toString(__outputDelimiters, useRecordDelim);
  }
  public String toString(DelimiterSet delimiters, boolean useRecordDelim) {
    StringBuilder __sb = new StringBuilder();
    char fieldDelim = delimiters.getFieldsTerminatedBy();
    __sb.append(FieldFormatter.escapeAndEnclose(REPORTING_AFFILIATE==null?"\\N":REPORTING_AFFILIATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(INVENTORY_TYPE==null?"\\N":INVENTORY_TYPE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LIST_NO==null?"\\N":LIST_NO, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LABEL_CODE==null?"\\N":LABEL_CODE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SIZE_CODE==null?"\\N":SIZE_CODE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PACK_SIZE==null?"\\N":PACK_SIZE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(D56_ITEM_NO==null?"\\N":D56_ITEM_NO, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(MONTH_DATE==null?"\\N":"" + MONTH_DATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(FACT==null?"\\N":FACT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(CREATED_BY==null?"\\N":CREATED_BY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(CREATION_DATE==null?"\\N":"" + CREATION_DATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LAST_UPD_BY==null?"\\N":LAST_UPD_BY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LAST_UPD_DATE==null?"\\N":"" + LAST_UPD_DATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DATAMART_LAST_UPD_BY==null?"\\N":DATAMART_LAST_UPD_BY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DATAMART_LAST_UPD_DATE==null?"\\N":"" + DATAMART_LAST_UPD_DATE, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(REPORTING_AFFILIATE==null?"\\N":REPORTING_AFFILIATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(INVENTORY_TYPE==null?"\\N":INVENTORY_TYPE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LIST_NO==null?"\\N":LIST_NO, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LABEL_CODE==null?"\\N":LABEL_CODE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SIZE_CODE==null?"\\N":SIZE_CODE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PACK_SIZE==null?"\\N":PACK_SIZE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(D56_ITEM_NO==null?"\\N":D56_ITEM_NO, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(MONTH_DATE==null?"\\N":"" + MONTH_DATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(FACT==null?"\\N":FACT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(CREATED_BY==null?"\\N":CREATED_BY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(CREATION_DATE==null?"\\N":"" + CREATION_DATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LAST_UPD_BY==null?"\\N":LAST_UPD_BY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LAST_UPD_DATE==null?"\\N":"" + LAST_UPD_DATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DATAMART_LAST_UPD_BY==null?"\\N":DATAMART_LAST_UPD_BY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DATAMART_LAST_UPD_DATE==null?"\\N":"" + DATAMART_LAST_UPD_DATE, delimiters));
  }
  private static final DelimiterSet __inputDelimiters = new DelimiterSet((char) 1, (char) 10, (char) 0, (char) 0, false);
  private RecordParser __parser;
  public void parse(Text __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(CharSequence __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(byte [] __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(char [] __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(ByteBuffer __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(CharBuffer __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  private void __loadFromFields(List<String> fields) {
    Iterator<String> __it = fields.listIterator();
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.REPORTING_AFFILIATE = null; } else {
      this.REPORTING_AFFILIATE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.INVENTORY_TYPE = null; } else {
      this.INVENTORY_TYPE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.LIST_NO = null; } else {
      this.LIST_NO = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.LABEL_CODE = null; } else {
      this.LABEL_CODE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.SIZE_CODE = null; } else {
      this.SIZE_CODE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.PACK_SIZE = null; } else {
      this.PACK_SIZE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.D56_ITEM_NO = null; } else {
      this.D56_ITEM_NO = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.MONTH_DATE = null; } else {
      this.MONTH_DATE = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.FACT = null; } else {
      this.FACT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.CREATED_BY = null; } else {
      this.CREATED_BY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.CREATION_DATE = null; } else {
      this.CREATION_DATE = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.LAST_UPD_BY = null; } else {
      this.LAST_UPD_BY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.LAST_UPD_DATE = null; } else {
      this.LAST_UPD_DATE = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.DATAMART_LAST_UPD_BY = null; } else {
      this.DATAMART_LAST_UPD_BY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.DATAMART_LAST_UPD_DATE = null; } else {
      this.DATAMART_LAST_UPD_DATE = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  private void __loadFromFields0(Iterator<String> __it) {
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.REPORTING_AFFILIATE = null; } else {
      this.REPORTING_AFFILIATE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.INVENTORY_TYPE = null; } else {
      this.INVENTORY_TYPE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.LIST_NO = null; } else {
      this.LIST_NO = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.LABEL_CODE = null; } else {
      this.LABEL_CODE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.SIZE_CODE = null; } else {
      this.SIZE_CODE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.PACK_SIZE = null; } else {
      this.PACK_SIZE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.D56_ITEM_NO = null; } else {
      this.D56_ITEM_NO = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.MONTH_DATE = null; } else {
      this.MONTH_DATE = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.FACT = null; } else {
      this.FACT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.CREATED_BY = null; } else {
      this.CREATED_BY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.CREATION_DATE = null; } else {
      this.CREATION_DATE = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.LAST_UPD_BY = null; } else {
      this.LAST_UPD_BY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.LAST_UPD_DATE = null; } else {
      this.LAST_UPD_DATE = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.DATAMART_LAST_UPD_BY = null; } else {
      this.DATAMART_LAST_UPD_BY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.DATAMART_LAST_UPD_DATE = null; } else {
      this.DATAMART_LAST_UPD_DATE = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    QueryResult o = (QueryResult) super.clone();
    o.MONTH_DATE = (o.MONTH_DATE != null) ? (java.sql.Timestamp) o.MONTH_DATE.clone() : null;
    o.CREATION_DATE = (o.CREATION_DATE != null) ? (java.sql.Timestamp) o.CREATION_DATE.clone() : null;
    o.LAST_UPD_DATE = (o.LAST_UPD_DATE != null) ? (java.sql.Timestamp) o.LAST_UPD_DATE.clone() : null;
    o.DATAMART_LAST_UPD_DATE = (o.DATAMART_LAST_UPD_DATE != null) ? (java.sql.Timestamp) o.DATAMART_LAST_UPD_DATE.clone() : null;
    return o;
  }

  public void clone0(QueryResult o) throws CloneNotSupportedException {
    o.MONTH_DATE = (o.MONTH_DATE != null) ? (java.sql.Timestamp) o.MONTH_DATE.clone() : null;
    o.CREATION_DATE = (o.CREATION_DATE != null) ? (java.sql.Timestamp) o.CREATION_DATE.clone() : null;
    o.LAST_UPD_DATE = (o.LAST_UPD_DATE != null) ? (java.sql.Timestamp) o.LAST_UPD_DATE.clone() : null;
    o.DATAMART_LAST_UPD_DATE = (o.DATAMART_LAST_UPD_DATE != null) ? (java.sql.Timestamp) o.DATAMART_LAST_UPD_DATE.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("REPORTING_AFFILIATE", this.REPORTING_AFFILIATE);
    __sqoop$field_map.put("INVENTORY_TYPE", this.INVENTORY_TYPE);
    __sqoop$field_map.put("LIST_NO", this.LIST_NO);
    __sqoop$field_map.put("LABEL_CODE", this.LABEL_CODE);
    __sqoop$field_map.put("SIZE_CODE", this.SIZE_CODE);
    __sqoop$field_map.put("PACK_SIZE", this.PACK_SIZE);
    __sqoop$field_map.put("D56_ITEM_NO", this.D56_ITEM_NO);
    __sqoop$field_map.put("MONTH_DATE", this.MONTH_DATE);
    __sqoop$field_map.put("FACT", this.FACT);
    __sqoop$field_map.put("CREATED_BY", this.CREATED_BY);
    __sqoop$field_map.put("CREATION_DATE", this.CREATION_DATE);
    __sqoop$field_map.put("LAST_UPD_BY", this.LAST_UPD_BY);
    __sqoop$field_map.put("LAST_UPD_DATE", this.LAST_UPD_DATE);
    __sqoop$field_map.put("DATAMART_LAST_UPD_BY", this.DATAMART_LAST_UPD_BY);
    __sqoop$field_map.put("DATAMART_LAST_UPD_DATE", this.DATAMART_LAST_UPD_DATE);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("REPORTING_AFFILIATE", this.REPORTING_AFFILIATE);
    __sqoop$field_map.put("INVENTORY_TYPE", this.INVENTORY_TYPE);
    __sqoop$field_map.put("LIST_NO", this.LIST_NO);
    __sqoop$field_map.put("LABEL_CODE", this.LABEL_CODE);
    __sqoop$field_map.put("SIZE_CODE", this.SIZE_CODE);
    __sqoop$field_map.put("PACK_SIZE", this.PACK_SIZE);
    __sqoop$field_map.put("D56_ITEM_NO", this.D56_ITEM_NO);
    __sqoop$field_map.put("MONTH_DATE", this.MONTH_DATE);
    __sqoop$field_map.put("FACT", this.FACT);
    __sqoop$field_map.put("CREATED_BY", this.CREATED_BY);
    __sqoop$field_map.put("CREATION_DATE", this.CREATION_DATE);
    __sqoop$field_map.put("LAST_UPD_BY", this.LAST_UPD_BY);
    __sqoop$field_map.put("LAST_UPD_DATE", this.LAST_UPD_DATE);
    __sqoop$field_map.put("DATAMART_LAST_UPD_BY", this.DATAMART_LAST_UPD_BY);
    __sqoop$field_map.put("DATAMART_LAST_UPD_DATE", this.DATAMART_LAST_UPD_DATE);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("REPORTING_AFFILIATE".equals(__fieldName)) {
      this.REPORTING_AFFILIATE = (String) __fieldVal;
    }
    else    if ("INVENTORY_TYPE".equals(__fieldName)) {
      this.INVENTORY_TYPE = (String) __fieldVal;
    }
    else    if ("LIST_NO".equals(__fieldName)) {
      this.LIST_NO = (String) __fieldVal;
    }
    else    if ("LABEL_CODE".equals(__fieldName)) {
      this.LABEL_CODE = (String) __fieldVal;
    }
    else    if ("SIZE_CODE".equals(__fieldName)) {
      this.SIZE_CODE = (String) __fieldVal;
    }
    else    if ("PACK_SIZE".equals(__fieldName)) {
      this.PACK_SIZE = (String) __fieldVal;
    }
    else    if ("D56_ITEM_NO".equals(__fieldName)) {
      this.D56_ITEM_NO = (String) __fieldVal;
    }
    else    if ("MONTH_DATE".equals(__fieldName)) {
      this.MONTH_DATE = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("FACT".equals(__fieldName)) {
      this.FACT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("CREATED_BY".equals(__fieldName)) {
      this.CREATED_BY = (String) __fieldVal;
    }
    else    if ("CREATION_DATE".equals(__fieldName)) {
      this.CREATION_DATE = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("LAST_UPD_BY".equals(__fieldName)) {
      this.LAST_UPD_BY = (String) __fieldVal;
    }
    else    if ("LAST_UPD_DATE".equals(__fieldName)) {
      this.LAST_UPD_DATE = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("DATAMART_LAST_UPD_BY".equals(__fieldName)) {
      this.DATAMART_LAST_UPD_BY = (String) __fieldVal;
    }
    else    if ("DATAMART_LAST_UPD_DATE".equals(__fieldName)) {
      this.DATAMART_LAST_UPD_DATE = (java.sql.Timestamp) __fieldVal;
    }
    else {
      throw new RuntimeException("No such field: " + __fieldName);
    }
  }
  public boolean setField0(String __fieldName, Object __fieldVal) {
    if ("REPORTING_AFFILIATE".equals(__fieldName)) {
      this.REPORTING_AFFILIATE = (String) __fieldVal;
      return true;
    }
    else    if ("INVENTORY_TYPE".equals(__fieldName)) {
      this.INVENTORY_TYPE = (String) __fieldVal;
      return true;
    }
    else    if ("LIST_NO".equals(__fieldName)) {
      this.LIST_NO = (String) __fieldVal;
      return true;
    }
    else    if ("LABEL_CODE".equals(__fieldName)) {
      this.LABEL_CODE = (String) __fieldVal;
      return true;
    }
    else    if ("SIZE_CODE".equals(__fieldName)) {
      this.SIZE_CODE = (String) __fieldVal;
      return true;
    }
    else    if ("PACK_SIZE".equals(__fieldName)) {
      this.PACK_SIZE = (String) __fieldVal;
      return true;
    }
    else    if ("D56_ITEM_NO".equals(__fieldName)) {
      this.D56_ITEM_NO = (String) __fieldVal;
      return true;
    }
    else    if ("MONTH_DATE".equals(__fieldName)) {
      this.MONTH_DATE = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("FACT".equals(__fieldName)) {
      this.FACT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("CREATED_BY".equals(__fieldName)) {
      this.CREATED_BY = (String) __fieldVal;
      return true;
    }
    else    if ("CREATION_DATE".equals(__fieldName)) {
      this.CREATION_DATE = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("LAST_UPD_BY".equals(__fieldName)) {
      this.LAST_UPD_BY = (String) __fieldVal;
      return true;
    }
    else    if ("LAST_UPD_DATE".equals(__fieldName)) {
      this.LAST_UPD_DATE = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("DATAMART_LAST_UPD_BY".equals(__fieldName)) {
      this.DATAMART_LAST_UPD_BY = (String) __fieldVal;
      return true;
    }
    else    if ("DATAMART_LAST_UPD_DATE".equals(__fieldName)) {
      this.DATAMART_LAST_UPD_DATE = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
