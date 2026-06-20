--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 邪心英雄 荒野风魔  (ID: 13293158)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Fiend
-- Level 8
-- ATK 1900 | DEF 2300
-- Setcode: 24584
--
-- Effect Text:
-- 「元素英雄 荒野侠」＋「元素英雄 羽翼侠」
-- 这张卡用「暗黑融合」的效果才能特殊召唤。
-- ①：这张卡攻击的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。
-- ②：这张卡给与对方战斗伤害的场合发动。对方场上盖放的魔法·陷阱卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--E-HERO ワイルド・サイクロン
function c13293158.initial_effect(c)
	aux.AddCodeList(c,94820406)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,21844576,86188410,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.DarkFusionLimit)
	c:RegisterEffect(e1)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(c13293158.aclimit)
	e2:SetCondition(c13293158.actcon)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(13293158,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetCondition(c13293158.condition)
	e3:SetTarget(c13293158.target)
	e3:SetOperation(c13293158.activate)
	c:RegisterEffect(e3)
end
c13293158.material_setcode=0x8
c13293158.dark_calling=true
function c13293158.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c13293158.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c13293158.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c13293158.filter(c)
	return c:IsFacedown()
end
function c13293158.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c13293158.filter,tp,0,LOCATION_SZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c13293158.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c13293158.filter,tp,0,LOCATION_SZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
