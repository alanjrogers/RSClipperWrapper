//
//  Clipper.swift
//  RSClipperWrapper
//
//  Created by Matthias Fey on 07.08.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//  Upgraded to Swift 4 syntax and ported to macOS by robm

/// The `Clipper` class performs polygon clipping - union, difference,
/// intersection & exclusive-or. `Clipper` is built as a wrapper of the open source
/// Clipper library written in C++ by Angus Johnson.
final public class Clipper {
    
    public enum FillType {
        case evenOdd
        case nonZero
        case positive
        case negative
        
        fileprivate var mapped: _FillType {
            switch self {
            case .evenOdd: return _FillType.EvenOdd
            case .nonZero: return _FillType.NonZero
            case .positive: return _FillType.Positive
            case .negative: return _FillType.Negative
            }
        }
    }
    
    /// Constructs and returns the union of an array of polygons
    public class func union(_ polygons: [[CGPoint]], fillType: FillType = .evenOdd, clipFillType: FillType = .evenOdd) -> [[CGPoint]] {
        return (_Clipper.unionPolygons(
            polygons.map { $0.map { NSValue(cgPoint: $0)! } } as [AnyObject],
            subjFillType: fillType.mapped,
            clipFillType: clipFillType.mapped) as! [[NSValue]]
        ).map { $0.map { $0.cgPointValue } }
    }
    
    /// Constructs and returns the difference of an array of polygons
    /// from an array of polygons.
    public class func difference(_ polygons: [[CGPoint]], fillType: FillType = .evenOdd, fromPolygons clipPolygons: [[CGPoint]], clipFillType: FillType = .evenOdd) -> [[CGPoint]] {
        return (_Clipper.differencePolygons(
            polygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject],
            subjFillType: fillType.mapped,
            fromPolygons: clipPolygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject],
            clipFillType: clipFillType.mapped) as! [[NSValue]]
        ).map { $0.map { $0.cgPointValue } }
    }
    
    /// Constructs and returns the intersection of an array of polygons
    /// with an array of polygons.
    public class func intersect(_ polygons: [[CGPoint]], fillType: FillType = .evenOdd, withPolygons clipPolygons: [[CGPoint]], clipFillType: FillType = .evenOdd) -> [[CGPoint]] {
        
        return (_Clipper.intersectPolygons(
            polygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject],
            subjFillType: fillType.mapped,
            withPolygons: clipPolygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject],
            clipFillType: clipFillType.mapped) as! [[NSValue]]
        ).map { $0.map { $0.cgPointValue } }
    }
    
    /// Constructs and returns the exclusive-or boolean operation of an array of polygons
    /// with an array of polygons.
    public class func xor(_ polygons: [[CGPoint]], fillType: FillType = .evenOdd, withPolygons clipPolygons: [[CGPoint]], clipFillType: FillType = .evenOdd) -> [[CGPoint]] {
        
        return (_Clipper.xorPolygons(
            polygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject],
            subjFillType: fillType.mapped,
            withPolygons: clipPolygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject],
            clipFillType: clipFillType.mapped) as! [[NSValue]]
        ).map { $0.map { $0.cgPointValue } }
    }
    
    /// Checks and Returns if a polygon contains a point
    public class func polygon(_ polygon: [CGPoint], contains point: CGPoint) -> Bool {
        return _Clipper.polygon(polygon.map { NSValue(cgPoint: $0) }, contains: point)
    }
}

