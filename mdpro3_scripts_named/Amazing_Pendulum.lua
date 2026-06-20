--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 惊异灵摆  (ID: 37803970)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 242
--
-- Effect Text:
-- 「惊异灵摆」在1回合只能发动1张。
-- ①：自己的灵摆区域没有卡存在的场合才能发动。从自己的额外卡组把2只卡名不同的表侧表示的「魔术师」灵摆怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--アメイジング・ペンデュラム
function c37803970.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,37803970+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c37803970.condition)
	e1:SetTarget(c37803970.target)
	e1:SetOperation(c37803970.activate)
	c:RegisterEffect(e1)
end
function c37803970.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.GetFieldCard(tp,LOCATION_PZONE,0) and not Duel.GetFieldCard(tp,LOCATION_PZONE,1)
end
function c37803970.thfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x98) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c37803970.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetMatchingGroup(c37803970.thfilter,tp,LOCATION_EXTRA,0,nil)
		return g:GetClassCount(Card.GetCode)>=2
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_EXTRA)
end
function c37803970.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c37803970.thfilter,tp,LOCATION_EXTRA,0,nil)
	if g:GetClassCount(Card.GetCode)>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=g:SelectSubGroup(tp,aux.dncheck,false,2,2)
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
	end
end
