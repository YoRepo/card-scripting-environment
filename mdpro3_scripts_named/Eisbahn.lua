--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 滑冰场  (ID: 54059040)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有水属性怪兽表侧表示存在，水属性以外的怪兽召唤·特殊召唤成功时，那些怪兽变成守备表示。
--[[ __CARD_HEADER_END__ ]]

--アイスバーン
function c54059040.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_SUMMON+TIMING_SPSUMMON)
	c:RegisterEffect(e1)
	--pos
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(54059040,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c54059040.target)
	e2:SetOperation(c54059040.operation)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c54059040.cfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c54059040.pfilter(c,e)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsNonAttribute(ATTRIBUTE_WATER) and (not e or c:IsRelateToEffect(e))
end
function c54059040.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c54059040.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and eg:IsExists(c54059040.pfilter,1,nil) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,eg,eg:GetCount(),0,0)
end
function c54059040.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c54059040.pfilter,nil,e)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
end
