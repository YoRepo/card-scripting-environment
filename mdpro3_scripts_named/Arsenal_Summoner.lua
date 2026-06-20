--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 武器召唤师  (ID: 85489096)
-- Type: Monster / Effect / Toon
-- Attribute: WIND
-- Race: Spellcaster
-- Level 4
-- ATK 1600 | DEF 1600
--
-- Effect Text:
-- ①：这张卡反转的场合发动。从卡组把1张「守护者」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ウェポンサモナー
function c85489096.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(85489096,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c85489096.target)
	e1:SetOperation(c85489096.operation)
	c:RegisterEffect(e1)
end
function c85489096.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c85489096.filter(c)
	return c:IsSetCard(0x52) and c:IsAbleToHand()
end
function c85489096.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c85489096.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
