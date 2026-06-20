--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 灵摆宝藏  (ID: 26237713)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 242
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把1只灵摆怪兽表侧加入额外卡组。
--[[ __CARD_HEADER_END__ ]]

--ペンデュラム・トレジャー
function c26237713.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOEXTRA)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,26237713+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c26237713.target)
	e1:SetOperation(c26237713.activate)
	c:RegisterEffect(e1)
end
function c26237713.filter(c)
	return c:IsType(TYPE_PENDULUM)
end
function c26237713.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26237713.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,nil,1,tp,LOCATION_DECK)
end
function c26237713.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(26237713,0))
	local g=Duel.SelectMatchingCard(tp,c26237713.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoExtraP(g,nil,REASON_EFFECT)
	end
end
