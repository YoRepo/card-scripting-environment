--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 流丽之骑士 盖亚激流  (ID: 13289758)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Aqua
-- Rank 6
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 6星怪兽×2只以上
-- 「流丽之骑士 盖亚激流」1回合1次也能在自己场上的5·7阶的超量怪兽上面重叠来超量召唤。这张卡在超量召唤的回合不能作为超量召唤的素材。
-- ①：这张卡不能直接攻击。
-- ②：这张卡的攻击力上升这张卡作为超量素材中的怪兽的等级·阶级的合计×200。
-- ③：这张卡进行战斗的伤害步骤结束时发动。这张卡1个超量素材取除。
--[[ __CARD_HEADER_END__ ]]

--流麗の騎士ガイアストリーム
local s,id,o=GetID()
function s.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2,s.ovfilter,aux.Stringid(id,0),99,s.xyzop)
	c:EnableReviveLimit()
	--can not be xyz material
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e0:SetCondition(s.xyzcon)
	e0:SetValue(1)
	c:RegisterEffect(e0)
	--cannot direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(s.atkval)
	c:RegisterEffect(e2)
	--xyz
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_DAMAGE_STEP_END)
	e4:SetCondition(s.xyzcon2)
	e4:SetOperation(s.xyzop2)
	c:RegisterEffect(e4)
end
function s.ovfilter(c)
	return c:IsFaceup() and c:IsRank(5,7) and c:IsType(TYPE_XYZ)
end
function s.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,id)==0 end
	Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function s.xyzcon(e)
	local c=e:GetHandler()
	return c:IsStatus(STATUS_SPSUMMON_TURN) and c:IsSummonType(SUMMON_TYPE_XYZ)
end
function s.atkval(e,c)
	return c:GetOverlayGroup():GetSum(s.lv_or_rk)*200
end
function s.lv_or_rk(c)
	if c:IsType(TYPE_XYZ) then return c:GetRank()
	else return c:GetLevel() end
end
function s.xyzcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle()
end
function s.xyzop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() and c:GetOverlayCount()>0 then
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
	end
end
