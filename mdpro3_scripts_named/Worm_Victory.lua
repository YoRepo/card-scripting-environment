--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 维多利异虫  (ID: 2088870)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Reptile
-- Level 7
-- ATK 0 | DEF 2500
-- Setcode: 62
--
-- Effect Text:
-- 反转：名字带有「异虫」的爬虫类族怪兽以外的场上表侧表示存在的怪兽全部破坏。这张卡的攻击力上升自己墓地存在的名字带有「异虫」的爬虫类族怪兽数量×500的数值。
--[[ __CARD_HEADER_END__ ]]

--ワーム・ヴィクトリー
function c2088870.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FLIP+EFFECT_TYPE_SINGLE)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetTarget(c2088870.destg)
	e1:SetOperation(c2088870.desop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c2088870.atkval)
	c:RegisterEffect(e2)
end
function c2088870.filter(c)
	return c:IsFaceup() and not (c:IsSetCard(0x3e) and c:IsRace(RACE_REPTILE))
end
function c2088870.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c2088870.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c2088870.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c2088870.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c2088870.vfilter(c)
	return c:IsSetCard(0x3e) and c:IsRace(RACE_REPTILE)
end
function c2088870.atkval(e,c)
	return Duel.GetMatchingGroupCount(c2088870.vfilter,c:GetControler(),LOCATION_GRAVE,0,nil)*500
end
