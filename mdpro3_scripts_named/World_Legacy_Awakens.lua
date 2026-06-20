--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 来自星遗物中的觉醒  (ID: 12989604)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 254
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：用自己场上的怪兽为素材把1只连接怪兽连接召唤。
--[[ __CARD_HEADER_END__ ]]

--星遺物からの目醒め
function c12989604.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,12989604+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c12989604.target)
	e1:SetOperation(c12989604.activate)
	c:RegisterEffect(e1)
end
function c12989604.filter(c)
	return c:IsLinkSummonable(nil)
end
function c12989604.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c12989604.filter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c12989604.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c12989604.filter,tp,LOCATION_EXTRA,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.LinkSummon(tp,tc,nil)
	end
end
