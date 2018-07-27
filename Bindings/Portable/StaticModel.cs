using System;
using System.Runtime.InteropServices;

namespace Urho
{
	partial class StaticModel
	{
		public Material Material
		{
			get { return GetMaterial(0); }
			set { SetMaterial(0, value); }
		}

        [DllImport("mono-holourho", CallingConvention = CallingConvention.Cdecl)]
        internal static extern IntPtr StaticModel_ProcessRayQuery(IntPtr handle, ref Ray ray, ref RayQueryLevel level, float maxDistance, uint drawableFlags, uint viewMask);

        public RayQueryResult ProcessRayQuery(Ray ray, RayQueryLevel level, float maxDistance, DrawableFlags drawableFlags, uint viewMask = UInt32.MaxValue) {
            //Runtime.ValidateRefCounted(this);

            var result = new RayQueryResult();

            var ptr = StaticModel_ProcessRayQuery(Handle, ref ray, ref level, maxDistance, (uint)drawableFlags, viewMask);

            //handle

            if (ptr == IntPtr.Zero) {
                return result;
            }

            IntPtr data = new IntPtr(ptr.ToInt64());
            RayQueryResult item = (RayQueryResult)Marshal.PtrToStructure(data, typeof(RayQueryResult));

            return result;
        }
    }

	partial class AnimatedModel
	{
		public Model Model
		{
			get { return base.Model; }
			set { this.SetModel(value, true); }
		}
	}
}