--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 水伶女·灯鱼  (ID: 39260991)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 1
-- ATK 300 | DEF 300
-- Setcode: 205
--
-- Effect Text:
-- ①：1回合1次，自己主要阶段才能发动。从卡组把1张「水族馆」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--アクアアクトレス・テトラ
function c39260991.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c39260991.thtg)
	e1:SetOperation(c39260991.thop)
	c:RegisterEffect(e1)
end
function c39260991.filter(c)
	return c:IsSetCard(0xce) and c:IsAbleToHand()
end
function c39260991.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c39260991.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c39260991.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c39260991.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
